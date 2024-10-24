//
//  SFBleCmdType.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/24.
//

import Foundation


// MARK: - SFBleCmdType
public enum SFBleCmdType {
    case client(String)
    case server(String)
    
    var name: String {
        switch self {
        case .client(let name):
            return "Cmd[C]: \(name)"
        case .server(let name):
            return "Cmd[S]: \(name)"
        }
    }
}

