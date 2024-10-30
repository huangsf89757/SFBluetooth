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
    public init(bleCentralManager: SFBleCentralManager, blePeripheral: SFBlePeripheral, characteristic: CBCharacteristic, data: Data, writeType: CBCharacteristicWriteType) {
        self.characteristic = characteristic
        self.data = data
        self.writeType = writeType
        super.init(name: "writeCharacteristicValue", bleCentralManager: bleCentralManager, blePeripheral: blePeripheral)
    }
    
    // MARK: func
    public override func execute() {
        onStart(type: type)
        super.execute()
        blePeripheral.writeValue(id: id, data: data, for: characteristic, type: writeType)
        onDoing(type: type)
    }
    
    // MARK: centralManager
    // ...
    
    // MARK: peripheral
    public override func peripheralDidWriteValueForCharacteristic(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: (any Error)?) {
        if let error = error {
            onFailure(type: type, error: .client(.peripheral(.write(.descriptor(error.localizedDescription)))))
        } else {
            onSuccess(type: type, data: characteristic.value, msg: "did write characteristic value")
        }
    }
}
