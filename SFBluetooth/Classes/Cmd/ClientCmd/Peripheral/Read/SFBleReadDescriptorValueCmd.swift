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
    public init(bleCentralManager: SFBleCentralManager, blePeripheral: SFBlePeripheral, descriptor: CBDescriptor, success: @escaping SFBleSuccess, failure: @escaping SFBleFailure) {
        self.descriptor = descriptor
        super.init(name: "readDescriptorValue", bleCentralManager: bleCentralManager, blePeripheral: blePeripheral, success: success, failure: failure)
    }
    
    // MARK: func
    public override func excute() {
        onStart()
        super.excute()
        blePeripheral.readValue(id: id, for: descriptor)
        onDoing()
    }
    
    // MARK: centralManager
    // ...
    
    // MARK: peripheral
    public override func peripheralDidUpdateValueForDescriptor(peripheral: CBPeripheral, descriptor: CBDescriptor, error: (any Error)?) {
        if let error = error {
            onFailure(error: .client(.peripheral(.read(.descriptor(error.localizedDescription)))))
        } else {
            onSuccess(data: descriptor.value)
        }
    }
}


