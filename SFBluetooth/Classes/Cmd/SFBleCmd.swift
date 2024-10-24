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



// MARK: - SFBleCmd
open class SFBleCmd {
    // MARK: var
    public private(set) var id = UUID()
    public private(set) var success: SFBleSuccess
    public private(set) var failure: SFBleFailure
    public private(set) var process: SFBleProcess = .none
    
    // MARK: life cycle
    public init(id: UUID = UUID(), success: @escaping SFBleSuccess, failure: @escaping SFBleFailure) {
        self.id = id
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
    }
    public func onWaiting() {
        self.process = .waiting
    }
    public func onDoing() {
        self.process = .doing
    }
    public func onSuccess(_ data: Any?, _ msg: String?) {
        self.process = .end
        success(data, msg)
    }
    public func onFailure(_ error: SFBleError) {
        self.process = .end
        failure(error)
    }
}
