//
//  SFBleReadCharacteristicValueCmd.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/28.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension


// MARK: - SFBleReadCharacteristicValueCmd
public class SFBleReadCharacteristicValueCmd: SFBlePeripheralCmd {
    // MARK: var
    public let characteristic: CBCharacteristic
    
    // MARK: life cycle
    public init(bleCentralManager: SFBleCentralManager, blePeripheral: SFBlePeripheral, characteristic: CBCharacteristic, success: @escaping SFBleSuccess, failure: @escaping SFBleFailure) {
        self.characteristic = characteristic
        super.init(name: "readCharacteristicValue", bleCentralManager: bleCentralManager, blePeripheral: blePeripheral, success: success, failure: failure)
    }
    
    // MARK: func
    public override func excute() {
        onStart()
        super.excute()
        blePeripheral.readValue(id: id, for: characteristic)
        onDoing()
    }
    
    // MARK: centralManager
    // ...
    
    // MARK: peripheral
    public override func peripheralDidUpdateValueForCharacteristic(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: (any Error)?) {
        if let error = error {
            onFailure(error: .client(.peripheral(.read(.descriptor(error.localizedDescription)))))
        } else {
            onSuccess(data: characteristic.value)
        }
    }
}

