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
public typealias SFBleCmdSuccess = (_ data: Any?, _ msg: String?, _ isDone: Bool) -> Void
public typealias SFBleCmdFailure = (_ error: SFBleCmdError) -> Void


// MARK: - SFBleCmd
public class SFBleCmd {
    // MARK: var
    /// 类型
    public let type: SFBleCmdType
    /// 唯一标识
    public private(set) var id = UUID()
    /// 插件
    public var plugins: [SFBleCmdPlugin] = [SFBleCmdLogPlugin()]
    
    /// 成功回调
    public private(set) var success: SFBleCmdSuccess?
    /// 失败回调
    public private(set) var failure: SFBleCmdFailure?
    /// continuation
    public private(set) var continuation: AsyncThrowingStream<(data: Any?, msg: String?), Error>.Continuation?

    
    
    // MARK: life cycle
    public init(type: SFBleCmdType) {
        self.type = type
    }
    
    // MARK: func
    /// 检查前提条件
    open func check() -> Bool {
        return true
    }
    /// 执行
    /// 外部调用请使用：executeCallback / executeAsync
    open func execute() {
        guard check() else {
            return
        }
        self.id = UUID()
    }
    
    // MARK: execute
    /// 回调方式
    public final func executeCallback(success: @escaping SFBleCmdSuccess, failure: @escaping SFBleCmdFailure) {
        self.success = success
        self.failure = failure
        self.execute()
    }
   
    /// async / await 方式
    public final func executeAsync() -> AsyncThrowingStream<(data: Any?, msg: String?), Error> {
        return AsyncThrowingStream { continuation in
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
    public func onSuccess(type: SFBleCmdType, data: Any? = nil, msg: String? = nil, isDone: Bool = true) {
        plugins.forEach { plugin in
            plugin.onSuccess(type: type, data: data, msg: msg, isDone: isDone)
        }
        success?(data, msg, isDone)
        if isDone {
            continuation?.yield((data, msg))
            continuation?.finish()
        } else {
            continuation?.yield((data, msg))
        }
    }
    public func onFailure(type: SFBleCmdType, error: SFBleCmdError) {
        plugins.forEach { plugin in
            plugin.onFailure(type: type, error: error)
        }
        failure?(error)
        continuation?.finish(throwing: error)
    }
}
