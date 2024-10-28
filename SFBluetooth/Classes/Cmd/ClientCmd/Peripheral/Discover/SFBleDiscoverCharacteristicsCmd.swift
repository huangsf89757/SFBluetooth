//
//  SFBleDiscoverCharacteristicsCmd.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/28.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension


// MARK: - SFBleDiscoverCharacteristicsCmd
public class SFBleDiscoverCharacteristicsCmd: SFBlePeripheralCmd {
    // MARK: var
    public let service: CBService
    public var characteristicUUIDs: [CBUUID]?
    
    // MARK: life cycle
    public init(bleCentralManager: SFBleCentralManager, blePeripheral: SFBlePeripheral, service: CBService, success: @escaping SFBleSuccess, failure: @escaping SFBleFailure) {
        self.service = service
        super.init(name: "discoverCharacteristics", bleCentralManager: bleCentralManager, blePeripheral: blePeripheral, success: success, failure: failure)
    }
    
    // MARK: func
    public override func execute() {
        onStart()
        super.execute()
        blePeripheral.discoverCharacteristics(id: id, characteristicUUIDs: characteristicUUIDs, for: service)
        onDoing()
    }
    
    // MARK: centralManager
    // ...
    
    // MARK: peripheral
    public override func peripheralDidDiscoverCharacteristics(peripheral: CBPeripheral, service: CBService, error: (any Error)?) {
        if let error = error {
            onFailure(error: .client(.peripheral(.discover(.characteristics(error.localizedDescription)))))
        } else {
            onSuccess(data: service.characteristics)
        }
    }
}

