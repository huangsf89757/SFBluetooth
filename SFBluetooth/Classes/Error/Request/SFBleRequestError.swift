//
//  SFBleRequestError.swift
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


// MARK: - SFBleRequestError
public enum SFBleRequestError: SFBleCmdErrorProtocol {
    case custom(String)
    case cmd(SFBleCmdError)
//    case client(SFBleClientCmdError)
//    case server(SFBleServerCmdError)

    public var code: Int {
       return 0
    }
    
    public var msg: String {
        return ""
    }
}

