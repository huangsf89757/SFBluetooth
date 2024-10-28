//
//  SFBleDiscoverServicesCmd.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/24.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension


// MARK: - SFBleDiscoverServicesCmd
public class SFBleDiscoverServicesCmd: SFBlePeripheralCmd {
    // MARK: var
    public var serviceUUIDs: [CBUUID]?
    
    // MARK: life cycle
    public init(bleCentralManager: SFBleCentralManager, blePeripheral: SFBlePeripheral) {
        super.init(name: "discoverServices", bleCentralManager: bleCentralManager, blePeripheral: blePeripheral)
    }
    
    // MARK: func
    public override func execute() {
        onStart()
        super.execute()
        blePeripheral.discoverServices(id: id, serviceUUIDs: serviceUUIDs)
        onDoing()
    }
    
    // MARK: centralManager
    // ...
    
    // MARK: peripheral
    public override func peripheralDidDiscoverServices(peripheral: CBPeripheral, error: (any Error)?) {
        if let error = error {
            onFailure(error: .client(.peripheral(.discover(.services(error.localizedDescription)))))
        } else {
            onSuccess(data: peripheral.services)
        }
    }
}
