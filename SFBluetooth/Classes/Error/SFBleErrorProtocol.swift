//
//  SFBleCmdErrorProtocol.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/24.
//

import Foundation

// MARK: - SFBleCmdErrorProtocol
public protocol SFBleCmdErrorProtocol {
    var code: Int {get}
    var msg: String {get}
}
