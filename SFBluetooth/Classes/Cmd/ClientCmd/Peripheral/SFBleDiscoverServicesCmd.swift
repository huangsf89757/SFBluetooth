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
    public init(bleCentralManager: SFBleCentralManager, blePeripheral: SFBlePeripheral, success: @escaping SFBleSuccess, failure: @escaping SFBleFailure) {
        super.init(name: "discoverServices", bleCentralManager: bleCentralManager, blePeripheral: blePeripheral, success: success, failure: failure)
    }
    
    // MARK: func
    public override func excute() {
        onStart()
        super.excute()
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
