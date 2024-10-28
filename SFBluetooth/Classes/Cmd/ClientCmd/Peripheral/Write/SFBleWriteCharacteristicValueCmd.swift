//
//  SFBleWriteCharacteristicValueCmd.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/28.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension


// MARK: - SFBleWriteCharacteristicValueCmd
public class SFBleWriteCharacteristicValueCmd: SFBlePeripheralCmd {
    // MARK: var
    public let characteristic: CBCharacteristic
    public let data: Data
    public let writeType: CBCharacteristicWriteType
    
    // MARK: life cycle
    public init(bleCentralManager: SFBleCentralManager, blePeripheral: SFBlePeripheral, characteristic: CBCharacteristic, data: Data, writeType: CBCharacteristicWriteType, success: @escaping SFBleSuccess, failure: @escaping SFBleFailure) {
        self.characteristic = characteristic
        self.data = data
        self.writeType = writeType
        super.init(name: "writeCharacteristicValue", bleCentralManager: bleCentralManager, blePeripheral: blePeripheral, success: success, failure: failure)
    }
    
    // MARK: func
    public override func excute() {
        onStart()
        super.excute()
        blePeripheral.writeValue(id: id, data: data, for: characteristic, type: writeType)
        onDoing()
    }
    
    // MARK: centralManager
    // ...
    
    // MARK: peripheral
    public override func peripheralDidWriteValueForCharacteristic(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: (any Error)?) {
        if let error = error {
            onFailure(error: .client(.peripheral(.write(.descriptor(error.localizedDescription)))))
        } else {
            onSuccess(data: characteristic.value)
        }
    }
}
