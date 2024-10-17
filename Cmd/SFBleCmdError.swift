//
//  SFBleCmdError.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/16.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger


// MARK: - SFBleCmdError
public enum SFBleCmdError {
    case custom(String)
    case state(CBManagerState)
    
    /// 状态码
    public var code: Int {
        switch self {
        case .custom(let string):
            return 0
        case .state(let cBManagerState):
            return 1
        }
    }
    
    /// 描述
    public var description: String {
        switch self {
        case .custom(let string):
            return string
        case .state(let cBManagerState):
            return cBManagerState.sf.description
       
        }
    }
}
