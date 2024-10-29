//
//  SFBleRequestType.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/29.
//

import Foundation


// MARK: - SFBleRequestType
public enum SFBleRequestType {
    case client(String)
    case server(String)
    
    var name: String {
        switch self {
        case .client(let name):
            return "Request[C]: \(name)"
        case .server(let name):
            return "Request[S]: \(name)"
        }
    }
}

