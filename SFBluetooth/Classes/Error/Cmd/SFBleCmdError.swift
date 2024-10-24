//
//  SFBleCmdError.swift
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


// MARK: - SFBleCmdError
public enum SFBleCmdError: SFBleCmdErrorProtocol {
    case custom(String)
    case client(SFBleClientCmdError)
    case server(SFBleServerCmdError)

    public var code: Int {
        var code = 0
        switch self {
        case .custom(let string):
            return 0
        case .client(let error):
            return 10000 + error.code
        case .server(let error):
            return 20000 + error.code
        }
    }
    
    public var msg: String {
        switch self {
        case .custom(let string):
            return string
        case .client(let error):
            return error.msg
        case .server(let error):
            return error.msg
        }
    }
}

