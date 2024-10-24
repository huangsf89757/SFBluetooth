//
//  SFBleServerError.swift
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


// MARK: - SFBleServerError
public enum SFBleServerError: SFBleErrorProtocol {
    case custom(String)
    case peripheralManager(SFBlePeripheralManagerError)
    case central(SFBleCentralError)
    
    public var code: Int {
        switch self {
        case .custom(let msg):
            return 0
        case .peripheralManager(let error):
            return 1000 + error.code
        case .central(let error):
            return 2000 + error.code
        }
    }
    
    public var msg: String {
        switch self {
        case .custom(let string):
            return string
        case .peripheralManager(let error):
            return error.msg
        case .central(let error):
            return error.msg
        }
    }
}


// MARK: - SFBlePeripheralManagerError
public enum SFBlePeripheralManagerError: SFBleErrorProtocol {
    case custom(String)
    
    public var code: Int {
        return 0
    }
    
    public var msg: String {
        return ""
    }
}


// MARK: - SFBleCentralError
public enum SFBleCentralError: SFBleErrorProtocol {
    case custom(String)
    
    public var code: Int {
        return 0
    }
    
    public var msg: String {
        return ""
    }
}

