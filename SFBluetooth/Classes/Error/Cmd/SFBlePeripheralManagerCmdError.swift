//
//  SFBlePeripheralManagerCmdError.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/24.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension


// MARK: - SFBlePeripheralManagerCmdError
public enum SFBlePeripheralManagerCmdError: SFBleCmdErrorProtocol {
    case custom(String)
    
    public var code: Int {
        return 0
    }
    
    public var msg: String {
        return ""
    }
}
