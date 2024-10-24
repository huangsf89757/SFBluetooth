//
//  SFBleError.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/23.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger


// MARK: - SFBleError
public enum SFBleError {
    case custom(String)
    case centralManager(SFBleCentralManagerError)
    case peripheral(SFBlePeripheralError)

    /// 状态码
    public var code: Int {
        switch self {
        case .custom(let msg):
            return 0
        case .centralManager(let error):
            return 10000
        case .peripheral(let error):
            return 20000
        }
    }
    
    /// 描述
    public var description: String {
        var code = self.code
        switch self {
        case .custom(let msg):
            return msg
        case .centralManager(let error):
            code += error.code
            return "\(code): \(error.description)"
        case .peripheral(let error):
            code += error.code
            return "\(code): \(error.description)"
        }
    }
}


// MARK: - SFBleCentralManagerError
public enum SFBleCentralManagerError {
    case custom(String)
    case isScanning(String)
    case state(String)
    case restore(String)
    case discoverPeripheral(String)
    case connectPeripheral(String)
    case failToConnectPeripheral(String)
    case disconnectPeripheral(String)
    case connectionEvent(String)
    case ANCSAuthorization(String)
    
    /// 状态码
    public var code: Int {
        return 0
    }
    
    /// 描述
    public var description: String {
        switch self {
        case .custom(let msg):
            return msg
        case .isScanning(let msg):
            return msg
        case .state(let msg):
            return msg
        case .restore(let msg):
            return msg
        case .discoverPeripheral(let msg):
            return msg
        case .connectPeripheral(let msg):
            return msg
        case .failToConnectPeripheral(let msg):
            return msg
        case .disconnectPeripheral(let msg):
            return msg
        case .connectionEvent(let msg):
            return msg
        case .ANCSAuthorization(let msg):
            return msg
        }
    }
}


// MARK: - SFBlePeripheralError
public enum SFBlePeripheralError {
    /// 状态码
    public var code: Int { 
        return 0
    }
    
    /// 描述
    public var description: String {
        return ""
    }
}
