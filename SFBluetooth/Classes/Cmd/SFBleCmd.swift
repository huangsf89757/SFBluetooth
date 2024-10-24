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

// MARK: - SFBleProcess
public enum SFBleProcess {
    case start
    case waiting
    case doing
    case end
}

// MARK: - SFBleCmd
open class SFBleCmd {
    // MARK: var
    public private(set) var id = UUID()
    public private(set) var success: SFBleSuccess
    public private(set) var failure: SFBleFailure
    public private(set) var process: SFBleProcess = .start
    
    // MARK: life cycle
    public init(id: UUID = UUID(), success: @escaping SFBleSuccess, failure: @escaping SFBleFailure) {
        self.id = id
        self.success = success
        self.failure = failure
    }
    
    // MARK: func
    open func excute() {
        self.process = .start
        self.id = UUID()
    }
//
//    public func waiting() {
//        self.process = .waiting
//    }
//    public func doing() {
//        self.process = .doing
//    }
//    public func success(_ data: Any?, _ msg: String?) {
//        self.process = .end
//        successBlock(data, msg)
//    }
//    public func failure(_ error: SFBleError) {
//        self.process = .end
//        failureBlock(error)
//    }
    
}
