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
    case client
    case server
}

// MARK: - SFBleCmd
open class SFBleCmd {
    // MARK: var
    public var type: SFBleCmdType
    public private(set) var id = UUID()
    public private(set) var success: SFBleSuccess
    public private(set) var failure: SFBleFailure
    public private(set) var process: SFBleProcess = .none
    public var plugins = [SFBleCmdPlugin]()
    
    // MARK: life cycle
    public init(type: SFBleCmdType, success: @escaping SFBleSuccess, failure: @escaping SFBleFailure) {
        self.type = type
        self.success = success
        self.failure = failure
    }
    
    // MARK: func
    open func excute() {
        self.id = UUID()
        onStart()
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
    public func onStart() {
        self.process = .start
        plugins.forEach { plugin in
            plugin.onStart(type: type)
        }
    }
    public func onWaiting() {
        self.process = .waiting
        plugins.forEach { plugin in
            plugin.onWaiting(type: type)
        }
    }
    public func onDoing() {
        self.process = .doing
        plugins.forEach { plugin in
            plugin.onDoing(type: type)
        }
    }
    public func onSuccess(data: Any?, msg: String?) {
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
