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
    // custom
    case custom(String)
    
    // centralManager
    case managerState(CBManagerState)
    case scan(String)
    case connect(String)
    case disconnect(String)
    case register(String)
    
    // peripheral
    case peripheralState(CBPeripheralState)

    /// 状态码
    public var code: Int {
        switch self {
        case .custom(let msg):
            return 0
        case .managerState(let state):
            return 1
        case .scan(let msg):
            return 2
        case .connect(let msg):
            return 3
        case .disconnect(let msg):
            return 4
        case .register(let msg):
            return 5
        case .peripheralState(let state):
            return 1
        }
    }
    
    /// 描述
    public var description: String {
        switch self {
        case .custom(let msg):
            return msg
        case .managerState(let state):
            return "centralManager`s state is \(state.sf.description)."
        case .scan(let msg):
            return msg
        case .connect(let msg):
            return msg
        case .disconnect(let msg):
            return msg
        case .register(let msg):
            return msg
        case .peripheralState(let state):
            return "peripheral`s state is \(state.sf.description)."
        }
    }
}
