//
//  SFBleCentralManagerError.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/24.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension


// MARK: - SFBleCentralManagerError
public enum SFBleCentralManagerError: SFBleErrorProtocol {
    case custom(String)
    case isScanning(String)
    case state(String)
    case restore(String)
    case discoverPeripheral(String)
    case connectPeripheral(String)
    case disconnectPeripheral(String)
    case connectionEvent(String)
    case ANCSAuthorization(String)
    
    public var code: Int {
        return 0
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
        case .disconnectPeripheral(let msg):
            return msg
        case .connectionEvent(let msg):
            return msg
        case .ANCSAuthorization(let msg):
            return msg
        }
    }
}
