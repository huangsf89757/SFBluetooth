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
public typealias SFBleFailure = (_ error: SFBleError) -> Void

// MARK: - SFBleCmdType
public enum SFBleCmdType {
    case client(String)
    case server(String)
    
    var description: String {
        switch self {
        case .client(let name):
            return "CMD[C]: \(name) > "
        case .server(let name):
            return "CMD[S]: \(name) > "
        }
    }
}

// MARK: - SFBleCmd
open class SFBleCmd {
    // MARK: var
    /// 类型
    public var type: SFBleCmdType
    /// 名称（read-only）
    public private(set) var name: String!
    /// 唯一标识
    public private(set) var id = UUID()
    /// 进程
    public private(set) var process: SFBleProcess = .none
    /// 插件
    public var plugins = [SFBleCmdPlugin]()
    /// 成功回调
    public private(set) var success: SFBleSuccess
    /// 失败回调
    public private(set) var failure: SFBleFailure
    
    
    // MARK: life cycle
    public init(type: SFBleCmdType, success: @escaping SFBleSuccess, failure: @escaping SFBleFailure) {
        self.type = type
        switch type {
        case .client(let string):
            self.name = string
        case .server(let string):
            self.name = string
        }
        self.success = success
        self.failure = failure
    }
    
    // MARK: func
    open func excute() {
        self.id = UUID()
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
        success(data, msg)
    }
    public func onFailure(error: SFBleError) {
        self.process = .end
        plugins.forEach { plugin in
            plugin.onFailure(type: type, error: error)
        }
        failure(error)
    }
}
