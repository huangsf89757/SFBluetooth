//
//  SFBlePeripheralError.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/24.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension


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
