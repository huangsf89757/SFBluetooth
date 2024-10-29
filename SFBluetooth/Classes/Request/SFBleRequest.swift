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
public typealias SFBleRequestSuccess = (_ data: Any?, _ msg: String?) -> Void
public typealias SFBleRequestFailure = (_ error: SFBleRequestError) -> Void

// MARK: - SFBleRequest
open class SFBleRequest {
    // MARK: var
    /// 类型
    public var type: SFBleRequestType
    /// 唯一标识
    public private(set) var id = UUID()
    /// 插件
    public var plugins: [SFBleRequestPlugin] = [SFBleRequestLogPlugin()]

    /// 成功回调
    public private(set) var success: SFBleRequestSuccess?
    /// 失败回调
    public private(set) var failure: SFBleRequestFailure?
    /// continuation
    public private(set) var continuation: CheckedContinuation<(data: Any?, msg: String?), Error>?
        
    /// 当前正在执行的cmd
    public private(set) var cmd: SFBleCmd?
    
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
    public final func start() {
        doNext()
    }
    private func doNext() {
        let (isSuccess, cmd) = getNextCmd()
        guard isSuccess else {
            // failure
            return
        }
        self.cmd = cmd
        guard let cmd = cmd else {
            // success
            return
        }
        Task {
            do {
                try await cmd.executeAsync()
                doNext()
            } catch let error {
                // failure
            }
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
    public func onSuccess(type: SFBleRequestType, data: Any? = nil, msg: String? = nil) {
        plugins.forEach { plugin in
            plugin.onSuccess(type: type, data: data, msg: msg)
        }
        success?(data, msg)
        continuation?.resume(returning: (data, msg))
    }
    public func onFailure(type: SFBleRequestType, error: SFBleRequestError) {
        plugins.forEach { plugin in
            plugin.onFailure(type: type, error: error)
        }
        failure?(error)
        continuation?.resume(throwing: error)
    }
}
