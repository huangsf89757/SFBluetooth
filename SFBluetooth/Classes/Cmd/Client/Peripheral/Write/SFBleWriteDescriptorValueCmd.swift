//
//  SFBleWriteDescriptorValueCmd.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/28.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension


// MARK: - SFBleWriteDescriptorValueCmd
public class SFBleWriteDescriptorValueCmd: SFBlePeripheralCmd {
    // MARK: var
    public let descriptor: CBDescriptor
    public let data: Data
    
    // MARK: life cycle
    public init(bleCentralManager: SFBleCentralManager, blePeripheral: SFBlePeripheral, descriptor: CBDescriptor, data: Data) {
        self.descriptor = descriptor
        self.data = data
        super.init(name: "writeDescriptorValue", bleCentralManager: bleCentralManager, blePeripheral: blePeripheral)
    }
    
    // MARK: func
    public override func execute() {
        onStart(type: type)
        super.execute()
        blePeripheral.writeValue(id: id, data: data, for: descriptor)
        onDoing(type: type)
    }
    
    // MARK: centralManager
    // ...
    
    // MARK: peripheral
    public override func peripheralDidWriteValueForDescriptor(peripheral: CBPeripheral, descriptor: CBDescriptor, error: (any Error)?) {
        if let error = error {
            onFailure(type: type, error: .client(.peripheral(.write(.descriptor(error.localizedDescription)))))
        } else {
            onSuccess(type: type, data: descriptor.value, msg: "did write descriptor value")
        }
    }
}
