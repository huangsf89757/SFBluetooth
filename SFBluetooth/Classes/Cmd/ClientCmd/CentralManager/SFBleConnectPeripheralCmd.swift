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
    public var peripheral: CBPeripheral?
    public var options: [String: Any]?
    
    // MARK: life cycle
    public override init(name: String, bleCentralManager: SFBleCentralManager, success: @escaping SFBleSuccess, failure: @escaping SFBleFailure) {
        super.init(name: "connectPeripheral", bleCentralManager: bleCentralManager, success: success, failure: failure)
    }
    
    // MARK: func
    public override func excute() {
        onStart()
        super.excute()
        guard let peripheral = peripheral else {
            onFailure(error: .client(.centralManager(.connectPeripheral("peripheral = nil"))))
            return
        }
        bleCentralManager.connect(id: id, peripheral: peripheral, options: options)
        onDoing()
    }
    
    // MARK: centralManager
    public override func centralManagerDidConnectPeripheral(peripheral: CBPeripheral) {
        onSuccess(data: nil)
    }
    public override func centralManagerDidFailToConnectPeripheral(peripheral: CBPeripheral, error: (Error)?) {
        onFailure(error: .client(.centralManager(.connectPeripheral(error?.localizedDescription ?? "connect failed"))))
    }
    
}
