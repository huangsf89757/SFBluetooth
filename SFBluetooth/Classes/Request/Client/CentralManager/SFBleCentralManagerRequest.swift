//
//  SFBleCentralManagerRequest.swift
//  IQKeyboardManagerSwift
//
//  Created by hsf on 2024/10/31.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger


// MARK: - SFBleCentralManagerRequest
public class SFBleCentralManagerRequest: SFBleClientRequest {
    // MARK: var
    public let bleCentralManager: SFBleCentralManager
    
    // MARK: life cycle
    public init(name: String, bleCentralManager: SFBleCentralManager) {
        self.bleCentralManager = bleCentralManager
        super.init(name: name)
    }
}
