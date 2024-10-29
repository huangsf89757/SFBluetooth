//
//  SFBleCmd.swift
//  IQKeyboardManagerSwift
//
//  Created by hsf on 2024/10/18.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger


// MARK: - SFBleCmdResponse
public typealias SFBleCmdSuccess = (_ data: Any?, _ msg: String?) -> Void
public typealias SFBleCmdFailure = (_ error: SFBleCmdError) -> Void


// MARK: - SFBleCmd
public class SFBleCmd {
    // MARK: var
    /// 类型
    public var type: SFBleCmdType
    /// 唯一标识
    public private(set) var id = UUID()
    /// 插件
    public var plugins: [SFBleCmdPlugin] = [SFBleCmdLogPlugin()]
    
    /// 成功回调
    public private(set) var success: SFBleCmdSuccess?
    /// 失败回调
    public private(set) var failure: SFBleCmdFailure?
    /// continuation
    public private(set) var continuation: CheckedContinuation<(data: Any?, msg: String?), Error>?
    
    
    // MARK: life cycle
    public init(type: SFBleCmdType) {
        self.type = type
    }
    
    // MARK: execute
    /// 检查前提条件
    open func check() -> Bool {
        return true
    }
    /// 执行
    open func execute() {
        guard check() else {
//            onFailure(type: type, error: .custom("不满足前提条件")) // !!!: 注意这里会多回调一次
            return
        }
        self.id = UUID()
    }
    
    /// 回调方式
    public final func executeCallback(success: @escaping SFBleCmdSuccess, failure: @escaping SFBleCmdFailure) {
        self.success = success
        self.failure = failure
        self.execute()
    }
    /// async / await 方式
    public final func executeAsync() async throws -> (data: Any?, msg: String?) {
        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            self.execute()
        }
    }
}


// MARK: - SFBleCmdProcess
extension SFBleCmd: SFBleCmdProcess {
    public func onStart(type: SFBleCmdType, msg: String? = nil) {
        plugins.forEach { plugin in
            plugin.onStart(type: type, msg: msg)
        }
    }
    public func onWaiting(type: SFBleCmdType, msg: String? = nil) {
        plugins.forEach { plugin in
            plugin.onWaiting(type: type, msg: msg)
        }
    }
    public func onDoing(type: SFBleCmdType, msg: String? = nil) {
        plugins.forEach { plugin in
            plugin.onDoing(type: type, msg: msg)
        }
    }
    public func onSuccess(type: SFBleCmdType, data: Any? = nil, msg: String? = nil) {
        plugins.forEach { plugin in
            plugin.onSuccess(type: type, data: data, msg: msg)
        }
        success?(data, msg)
        continuation?.resume(returning: (data, msg))
    }
    public func onFailure(type: SFBleCmdType, error: SFBleCmdError) {
        plugins.forEach { plugin in
            plugin.onFailure(type: type, error: error)
        }
        failure?(error)
        continuation?.resume(throwing: error)
    }
}
