//
//  SFBlePeripheralRequest.swift
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


// MARK: - SFBlePeripheralRequest
public class SFBlePeripheralRequest: SFBleCentralManagerRequest {
    // MARK: var
    public let blePeripheral: SFBlePeripheral
    
    // MARK: life cycle
    public init(name: String, bleCentralManager: SFBleCentralManager, blePeripheral: SFBlePeripheral) {
        self.blePeripheral = blePeripheral
        super.init(name: name, bleCentralManager: bleCentralManager)
    }
}
