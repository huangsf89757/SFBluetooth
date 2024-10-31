//
//  SFBleRequest.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/24.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger


// MARK: - SFBleRequestResponse
public typealias SFBleRequestSuccess = (_ data: Any?, _ msg: String?, _ isDone: Bool) -> Void
public typealias SFBleRequestFailure = (_ error: SFBleRequestError) -> Void

// MARK: - SFBleRequest
open class SFBleRequest {
    // MARK: var
    /// 类型
    public let type: SFBleRequestType
    /// 唯一标识
    public private(set) var id = UUID()
    /// 插件
    public var plugins: [SFBleRequestPlugin] = [SFBleRequestLogPlugin()]

    /// 成功回调
    public private(set) var success: SFBleRequestSuccess?
    /// 失败回调
    public private(set) var failure: SFBleRequestFailure?
    /// continuation
    public private(set) var continuation: AsyncThrowingStream<(data: Any?, msg: String?), Error>.Continuation?
        
    /// 当前正在执行的cmd
    public private(set) var cmd: SFBleCmd?
    /// 执行结果
    public private(set) var result: (Any?, String?, Bool)?
    
    // MARK: life cycle
    public init(type: SFBleRequestType) {
        self.type = type
    }
    
    
    // MARK: func
    open func getStartCmd() -> SFBleCmd? {
        return nil
    }
   
    open func getNextCmd() -> (Bool, SFBleCmd?) {
        return (false, nil)
    }
    
    private func doNext() {
        let (isSuccess, cmd) = getNextCmd()
        guard isSuccess else {
            onFailure(type: type, error: .custom("get next cmd failed"))
            return
        }
        self.cmd = cmd
        guard let cmd = cmd else {
            if let (data, msg, isDone) = result {
                onSuccess(type: type, data: data, msg: msg, isDone: isDone)
            } else {
                onSuccess(type: type)
            }
            return
        }
        cmd.executeCallback { [weak self] data, msg, isDone in
            guard let self = self else { return }
            self.result = (data, msg, isDone)
            if isDone {
                self.doNext()
            }
        } failure: { [weak self] error in
            guard let self = self else { return }
            self.onFailure(type: self.type, error: .cmd(error))
        }
    }
   
    
    // MARK: start
    /// 回调方式
    public final func startCallback(success: @escaping SFBleRequestSuccess, failure: @escaping SFBleRequestFailure) {
        self.success = success
        self.failure = failure
        self.doNext()
    }
   
    /// async / await 方式
    public final func startAsync() -> AsyncThrowingStream<(data: Any?, msg: String?), Error> {
        return AsyncThrowingStream { continuation in
            self.continuation = continuation
            self.doNext()
        }
    }
    
}


// MARK: - SFBleRequestProcess
extension SFBleRequest: SFBleRequestProcess {
    public func onStart(type: SFBleRequestType, msg: String? = nil) {
        plugins.forEach { plugin in
            plugin.onStart(type: type, msg: msg)
        }
    }
    public func onWaiting(type: SFBleRequestType, msg: String? = nil) {
        plugins.forEach { plugin in
            plugin.onWaiting(type: type, msg: msg)
        }
    }
    public func onDoing(type: SFBleRequestType, msg: String? = nil) {
        plugins.forEach { plugin in
            plugin.onDoing(type: type, msg: msg)
        }
    }
    public func onSuccess(type: SFBleRequestType, data: Any? = nil, msg: String? = nil, isDone: Bool = true) {
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
    public func onFailure(type: SFBleRequestType, error: SFBleRequestError) {
        plugins.forEach { plugin in
            plugin.onFailure(type: type, error: error)
        }
        failure?(error)
        continuation?.finish(throwing: error)
    }
}
