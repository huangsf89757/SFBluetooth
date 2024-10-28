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
    public init(bleCentralManager: SFBleCentralManager, blePeripheral: SFBlePeripheral, service: CBService, success: @escaping SFBleSuccess, failure: @escaping SFBleFailure) {
        self.service = service
        super.init(name: "discoverIncludedServices", bleCentralManager: bleCentralManager, blePeripheral: blePeripheral, success: success, failure: failure)
    }
    
    // MARK: func
    public override func excute() {
        onStart()
        super.excute()
        blePeripheral.discoverIncludedServices(id: id, includedServiceUUIDs: includedServiceUUIDs, for: service)
        onDoing()
    }
    
    // MARK: centralManager
    // ...
    
    // MARK: peripheral
    public override func peripheralDidDiscoverIncludedServices(peripheral: CBPeripheral, service: CBService, error: (any Error)?) {
        if let error = error {
            onFailure(error: .client(.peripheral(.discover(.includedServices(error.localizedDescription)))))
        } else {
            onSuccess(data: service.includedServices)
        }
    }
}

