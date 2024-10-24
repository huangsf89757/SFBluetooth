//
//  SFBleClientError.swift
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


// MARK: - SFBleClientError
public enum SFBleClientError: SFBleErrorProtocol {
    case custom(String)
    case centralManager(SFBleCentralManagerError)
    case peripheral(SFBlePeripheralError)
    
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


// MARK: - SFBleCentralManagerError
public enum SFBleCentralManagerError: SFBleErrorProtocol {
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
    
    public var code: Int {
        switch self {
        case .custom(let msg):
            return 0
        case .isScanning(let msg):
            return 100
        case .state(let msg):
            return 200
        case .restore(let msg):
            return 300
        case .discoverPeripheral(let msg):
            return 400
        case .connectPeripheral(let msg):
            return 500
        case .failToConnectPeripheral(let msg):
            return 600
        case .disconnectPeripheral(let msg):
            return 700
        case .connectionEvent(let msg):
            return 800
        case .ANCSAuthorization(let msg):
            return 900
        }
    }
    
    public var msg: String {
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
public enum SFBlePeripheralError: SFBleErrorProtocol {
    case custom(String)
    case readRSSI(String)
    case discoverServices(String)
    
    public var code: Int {
        return 0
    }
    
    public var msg: String {
        return ""
    }
}
