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
    public var bleCentralManager: SFBleCentralManager
    
    // MARK: life cycle
    public init(success: @escaping SFBleCmdSuccess, failure: @escaping SFBleCmdFailure, bleCentralManager: SFBleCentralManager) {
        self.bleCentralManager = bleCentralManager
        super.init(success: success, failure: failure)
    }
    
    // MARK: excute
    public override func execute() {
        super.execute()
        let state = bleCentralManager.centralManager.state
        guard state == .poweredOn else {
            failure(.state(state))
            return
        }
    }
}

