//
//  SFBlePeripheralCmd.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/18.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger


// MARK: - SFBlePeripheralCmd
public class SFBlePeripheralCmd: SFBleCmd {
    // MARK: var
    public var blePeripheral: SFBlePeripheral
    
    // MARK: life cycle
    public init(success: @escaping SFBleCmdSuccess, failure: @escaping SFBleCmdFailure, blePeripheral: SFBlePeripheral) {
        self.blePeripheral = blePeripheral
        super.init(success: success, failure: failure)
    }
    
    // MARK: excute
    public override func execute() {
        super.execute()
        let state = blePeripheral.state
        guard state == .connected else {
            failure(.state(state))
            return
        }
    }
}

