//
//  SFBleCentralManagerCmdError.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/24.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension


// MARK: - SFBleCentralManagerCmdError
public enum SFBleCentralManagerCmdError: SFBleCmdErrorProtocol {
    case custom(String)
    case state(String)
    case scan(String)
    case connect(String)
    case disconnect(String)
    case event(String)
    case ANCS(String)
        
    public var code: Int {
        return 0
    }
    
    public var msg: String {
        return ""
    }
}
