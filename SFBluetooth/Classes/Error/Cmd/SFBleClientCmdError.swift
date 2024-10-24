//
//  SFBleClientCmdError.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/24.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension

// MARK: - SFBleClientCmdError
public enum SFBleClientCmdError: SFBleCmdErrorProtocol {
    case custom(String)
    case centralManager(SFBleCentralManagerCmdError)
    case peripheral(SFBlePeripheralCmdError)
    
    public var code: Int {
        switch self {
        case .custom(let msg):
            return 0
        case .centralManager(let error):
            return 1000 + error.code
        case .peripheral(let error):
            return 2000 + error.code
        }
    }
    
    public var msg: String {
        switch self {
        case .custom(let string):
            return string
        case .centralManager(let error):
            return error.msg
        case .peripheral(let error):
            return error.msg
        }
    }
}






