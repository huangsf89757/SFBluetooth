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
    /// (characteristics) -> (isMatch, isContinue)
    public var condition: ((_ characteristics: [CBCharacteristic]?) -> (Bool, Bool))?
    
    // MARK: life cycle
    public init(bleCentralManager: SFBleCentralManager, blePeripheral: SFBlePeripheral, service: CBService) {
        self.service = service
        super.init(name: "discoverCharacteristics", bleCentralManager: bleCentralManager, blePeripheral: blePeripheral)
    }
    
    // MARK: override
    public override func execute() {
        onStart(type: type)
        super.execute()
        blePeripheral.discoverCharacteristics(id: id, characteristicUUIDs: characteristicUUIDs, for: service)
        onDoing(type: type)
    }
    
    // MARK: centralManager
    // ...
    
    // MARK: peripheral
    public override func peripheralDidDiscoverCharacteristics(peripheral: CBPeripheral, service: CBService, error: (any Error)?) {
        if let error = error {
            onFailure(type: type, error: .client(.peripheral(.discover(.characteristics(error.localizedDescription)))))
        } else {
            let characteristics = service.characteristics
            guard let condition = condition else { return }
            let (isMatch, isContinue) = condition(characteristics)
            guard isMatch else { return }
            onSuccess(type: type, data: characteristics, msg: "did discover characteristics", isDone: !isContinue)
        }
    }
}

