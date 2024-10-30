//
//  SFBleDiscoverDescriptorsCmd.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/28.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension


// MARK: - SFBleDiscoverDescriptorsCmd
public class SFBleDiscoverDescriptorsCmd: SFBlePeripheralCmd {
    // MARK: var
    public let characteristic: CBCharacteristic
    /// (descriptors) -> (isMatch, isContinue)
    public var condition: ((_ descriptors: [CBDescriptor]?) -> (Bool, Bool))?
    
    // MARK: life cycle
    public init(bleCentralManager: SFBleCentralManager, blePeripheral: SFBlePeripheral, characteristic: CBCharacteristic) {
        self.characteristic = characteristic
        super.init(name: "discoverDescriptors", bleCentralManager: bleCentralManager, blePeripheral: blePeripheral)
    }
    
    // MARK: func
    public override func execute() {
        onStart(type: type)
        super.execute()
        blePeripheral.discoverDescriptors(id: id, for: characteristic)
        onDoing(type: type)
    }
    
    // MARK: centralManager
    // ...
    
    // MARK: peripheral
    public override func peripheralDidDiscoverDescriptorsForCharacteristic(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: (any Error)?) {
        if let error = error {
            onFailure(type: type, error: .client(.peripheral(.discover(.descriptors(error.localizedDescription)))))
        } else {
            let descriptors = characteristic.descriptors
            guard let condition = condition else { return }
            let (isMatch, isContinue) = condition(descriptors)
            guard isMatch else { return }
            onSuccess(type: type, data: descriptors, msg: "did discover descriptors", isDone: !isContinue)
        }
    }
}

