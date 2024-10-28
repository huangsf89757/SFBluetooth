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


// MARK: - SFBleResponse
public typealias SFBleSuccess = (_ data: Any?, _ msg: String?) -> Void
public typealias SFBleFailure = (_ error: SFBleCmdError) -> Void


// MARK: - SFBleCmd
public class SFBleCmd {
    // MARK: var
    /// 类型
    public var type: SFBleCmdType
    /// 唯一标识
    public private(set) var id = UUID()
    /// 进程
    public private(set) var process: SFBleProcess = .none
    /// 插件
    public var plugins: [SFBleCmdPlugin] = [SFBleCmdLogPlugin()]
    /// 成功回调
    public private(set) var success: SFBleSuccess?
    /// 失败回调
    public private(set) var failure: SFBleFailure?
    /// continuation
    public private(set) var continuation: CheckedContinuation<(data: Any?, msg: String?), Error>?
    
    
    // MARK: life cycle
    public init(type: SFBleCmdType) {
        self.type = type
    }
    
    // MARK: execute
    /// 执行方式
    open func execute() {
        self.id = UUID()
    }
    
    /// 回调方式
    public func executeCallback(success: @escaping SFBleSuccess, failure: @escaping SFBleFailure) {
        self.success = success
        self.failure = failure
        self.execute()
    }
    /// async / await 方式
    public func executeAsync() async throws -> (data: Any?, msg: String?) {
        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            self.execute()
        }
    }
}


// MARK: - SFBleProcess
public enum SFBleProcess {
    case none
    case start
    case waiting
    case doing
    case end
}

extension SFBleCmd {
    public func onStart(msg: String? = nil) {
        self.process = .start
        plugins.forEach { plugin in
            plugin.onStart(type: type, msg: msg)
        }
    }
    public func onWaiting(msg: String? = nil) {
        self.process = .waiting
        plugins.forEach { plugin in
            plugin.onWaiting(type: type, msg: msg)
        }
    }
    public func onDoing(msg: String? = nil) {
        self.process = .doing
        plugins.forEach { plugin in
            plugin.onDoing(type: type, msg: msg)
        }
    }
    public func onSuccess(data: Any?, msg: String? = nil) {
        self.process = .end
        plugins.forEach { plugin in
            plugin.onSuccess(type: type, data: data, msg: msg)
        }
        success?(data, msg)
        continuation?.resume(returning: (data, msg))
    }
    public func onFailure(error: SFBleCmdError) {
        self.process = .end
        plugins.forEach { plugin in
            plugin.onFailure(type: type, error: error)
        }
        failure?(error)
        continuation?.resume(throwing: error)
    }
}
