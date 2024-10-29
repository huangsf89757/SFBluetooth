//
//  SFBleDiscoverIncludedServicesCmd.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/28.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension


// MARK: - SFBleDiscoverIncludedServicesCmd
public class SFBleDiscoverIncludedServicesCmd: SFBlePeripheralCmd {
    // MARK: var
    public let service: CBService
    public var includedServiceUUIDs: [CBUUID]?
    
    // MARK: life cycle
    public init(bleCentralManager: SFBleCentralManager, blePeripheral: SFBlePeripheral, service: CBService) {
        self.service = service
        super.init(name: "discoverIncludedServices", bleCentralManager: bleCentralManager, blePeripheral: blePeripheral)
    }
    
    // MARK: func
    public override func execute() {
        onStart(type: type)
        super.execute()
        blePeripheral.discoverIncludedServices(id: id, includedServiceUUIDs: includedServiceUUIDs, for: service)
        onDoing(type: type)
    }
    
    // MARK: centralManager
    // ...
    
    // MARK: peripheral
    public override func peripheralDidDiscoverIncludedServices(peripheral: CBPeripheral, service: CBService, error: (any Error)?) {
        if let error = error {
            onFailure(type: type, error: .client(.peripheral(.discover(.includedServices(error.localizedDescription)))))
        } else {
            onSuccess(type: type, data: service.includedServices)
        }
    }
}

