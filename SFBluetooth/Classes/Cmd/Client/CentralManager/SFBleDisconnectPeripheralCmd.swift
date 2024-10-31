//
//  SFBleDisconnectPeripheralCmd.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/24.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension


// MARK: - SFBleDisconnectPeripheralCmd
public class SFBleDisconnectPeripheralCmd: SFBleCentralManagerCmd {
    // MARK: var
    public let peripheral: CBPeripheral
    
    // MARK: life cycle
    public init(bleCentralManager: SFBleCentralManager, peripheral: CBPeripheral) {
        self.peripheral = peripheral
        super.init(name: "connectPeripheral", bleCentralManager: bleCentralManager)
    }
    
    // MARK: override
    public override func execute() {
        onStart(type: type)
        super.execute()
        bleCentralManager.disconnect(id: id, peripheral: peripheral)
        onDoing(type: type)
    }
    
    // MARK: centralManager
    public override func centralManagerDidDisconnectPeripheral(peripheral: CBPeripheral, error: (Error)?) {
        if let error = error {
            onFailure(type: type, error: .client(.centralManager(.disconnect(error.localizedDescription))))
        } else {
            onSuccess(type: type, msg: "did disconnect peripheral.")
        }
    }
    public override func centralManagerDidDisconnectPeripheral(peripheral: CBPeripheral, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: (Error)?) {
        if let error = error {
            onFailure(type: type, error: .client(.centralManager(.disconnect(error.localizedDescription))))
        } else {
            onSuccess(type: type, msg: "did disconnect peripheral and then reconnect.")
        }
    }
    
}
