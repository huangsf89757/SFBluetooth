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
    public init(name: String, bleCentralManager: SFBleCentralManager, peripheral: CBPeripheral, success: @escaping SFBleSuccess, failure: @escaping SFBleFailure) {
        self.peripheral = peripheral
        super.init(name: "connectPeripheral", bleCentralManager: bleCentralManager, success: success, failure: failure)
    }
    
    // MARK: func
    public override func execute() {
        onStart()
        super.execute()
        bleCentralManager.disconnect(id: id, peripheral: peripheral)
        onDoing()
    }
    
    // MARK: centralManager
    public override func centralManagerDidDisconnectPeripheral(peripheral: CBPeripheral, error: (Error)?) {
        onSuccess(data: nil, msg: error?.localizedDescription)
    }
    public override func centralManagerDidDisconnectPeripheral(peripheral: CBPeripheral, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: (Error)?) {
        onSuccess(data: nil, msg: error?.localizedDescription)
    }
    
}
