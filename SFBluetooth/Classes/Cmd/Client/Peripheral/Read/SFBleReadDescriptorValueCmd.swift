//
//  SFBleReadDescriptorValueCmd.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/28.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension


// MARK: - SFBleReadDescriptorValueCmd
public class SFBleReadDescriptorValueCmd: SFBlePeripheralCmd {
    // MARK: var
    public let descriptor: CBDescriptor
    
    // MARK: life cycle
    public init(bleCentralManager: SFBleCentralManager, blePeripheral: SFBlePeripheral, descriptor: CBDescriptor) {
        self.descriptor = descriptor
        super.init(name: "readDescriptorValue", bleCentralManager: bleCentralManager, blePeripheral: blePeripheral)
    }
    
    // MARK: override
    public override func execute() {
        onStart(type: type)
        super.execute()
        blePeripheral.readValue(id: id, for: descriptor)
        onDoing(type: type)
    }
    
    // MARK: centralManager
    // ...
    
    // MARK: peripheral
    public override func peripheralDidUpdateValueForDescriptor(peripheral: CBPeripheral, descriptor: CBDescriptor, error: (any Error)?) {
        if let error = error {
            onFailure(type: type, error: .client(.peripheral(.read(.descriptor(error.localizedDescription)))))
        } else {
            onSuccess(type: type, data: descriptor.value, msg: "did read descriptor value")
        }
    }
}


