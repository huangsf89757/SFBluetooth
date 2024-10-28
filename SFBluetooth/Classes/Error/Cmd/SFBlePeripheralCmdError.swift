//
//  SFBlePeripheralCmdError.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/24.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension


// MARK: - SFBlePeripheralCmdError
public enum SFBlePeripheralCmdError: SFBleCmdErrorProtocol {
    case custom(String)
    case discover(SFBlePeripheralDiscoverCmdError)
    case read(SFBlePeripheralReadCmdError)
    case write(SFBlePeripheralWriteCmdError)
    case L2CAP
    
    public var code: Int {
        return 0
    }
    
    public var msg: String {
        return ""
    }
}

// MARK: - SFBlePeripheralDiscoverCmdError
public enum SFBlePeripheralDiscoverCmdError {
    case services(String)
    case includedServices(String)
    case characteristics(String)
    case descriptors(String)
}

// MARK: - SFBlePeripheralReadCmdError
public enum SFBlePeripheralReadCmdError {
    case characteristic(String)
    case descriptor(String)
    case rssi(String)
}


// MARK: - SFBlePeripheralWriteCmdError
public enum SFBlePeripheralWriteCmdError {
    case characteristic(String)
    case descriptor(String)
}



