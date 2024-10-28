//
//  SFBleConnectPeripheralCmd.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/24.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension


// MARK: - SFBleConnectPeripheralCmd
public class SFBleConnectPeripheralCmd: SFBleCentralManagerCmd {
    // MARK: var
    public let peripheral: CBPeripheral
    public var options: [String: Any]?
    
    // MARK: life cycle
    public init(bleCentralManager: SFBleCentralManager, peripheral: CBPeripheral) {
        self.peripheral = peripheral
        super.init(name: "connectPeripheral", bleCentralManager: bleCentralManager)
    }
    
    // MARK: func
    public override func execute() {
        onStart()
        super.execute()
        bleCentralManager.connect(id: id, peripheral: peripheral, options: options)
        onDoing()
    }
    
    // MARK: centralManager
    public override func centralManagerDidConnectPeripheral(peripheral: CBPeripheral) {
        onSuccess(data: nil)
    }
    public override func centralManagerDidFailToConnectPeripheral(peripheral: CBPeripheral, error: (Error)?) {
        onFailure(error: .client(.centralManager(.connect(error?.localizedDescription ?? "unknown error"))))
    }
    
}
