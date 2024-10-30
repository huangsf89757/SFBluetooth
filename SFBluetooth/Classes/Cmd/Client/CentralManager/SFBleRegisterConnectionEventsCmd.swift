//
//  SFBleRegisterConnectionEventsCmd.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/24.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension


// MARK: - SFBleRegisterConnectionEventsCmd
public class SFBleRegisterConnectionEventsCmd: SFBleCentralManagerCmd {
    // MARK: var
    public var options: [CBConnectionEventMatchingOption : Any]?
    
    // MARK: life cycle
    public init(bleCentralManager: SFBleCentralManager) {
        super.init(name: "registerConnectionEvents", bleCentralManager: bleCentralManager)
    }
    
    // MARK: func
    public override func execute() {
        onStart(type: type)
        super.execute()
        bleCentralManager.registerForConnectionEvents(id: id, options: options)
        onDoing(type: type)
    }
    
    // MARK: centralManager
    public override func centralManagerDidOccurConnectionEvents(peripheral: CBPeripheral, event: CBConnectionEvent) {
        onSuccess(type: type, data: (peripheral, event), msg: "did occur connection event")
    }
    
}

