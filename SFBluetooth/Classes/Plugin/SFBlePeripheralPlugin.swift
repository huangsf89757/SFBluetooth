//
//  SFBlePeripheralPlugin.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/23.
//

import Foundation
import CoreBluetooth


// MARK: - SFBlePeripheralPlugin
public protocol SFBlePeripheralPlugin {
    func readRSSI(peripheral: CBPeripheral)

    func discoverServices(peripheral: CBPeripheral, serviceUUIDs: [CBUUID]?)

    func discoverIncludedServices(peripheral: CBPeripheral, includedServiceUUIDs: [CBUUID]?, service: CBService)

    func discoverCharacteristics(peripheral: CBPeripheral, characteristicUUIDs: [CBUUID]?, service: CBService)
    
    func readCharacteristicValue(peripheral: CBPeripheral, characteristic: CBCharacteristic)

    func getMaximumWriteValueLength(peripheral: CBPeripheral, type: CBCharacteristicWriteType, length: Int)
    
    func writeCharacteristicValue(peripheral: CBPeripheral, data: Data, characteristic: CBCharacteristic, type: CBCharacteristicWriteType)

    func setCharacteristicNotificationState(peripheral: CBPeripheral, enabled: Bool, characteristic: CBCharacteristic)

    func discoverDescriptors(peripheral: CBPeripheral, characteristic: CBCharacteristic)

    func readDescriptorValue(peripheral: CBPeripheral, descriptor: CBDescriptor)

    func writeDescriptorValue(peripheral: CBPeripheral, data: Data, descriptor: CBDescriptor)

    func openL2CAPChannel(peripheral: CBPeripheral, PSM: CBL2CAPPSM)
    
    func didUpdateState(peripheral: CBPeripheral, state: CBPeripheralState)

    func didUpdateName(peripheral: CBPeripheral, name: String?)

    func didModifyServices(peripheral: CBPeripheral, invalidatedServices: [CBService])

    func didUpdateRSSI(peripheral: CBPeripheral, RSSI: NSNumber?, error: (any Error)?)

    func didReadRSSI(peripheral: CBPeripheral, RSSI: NSNumber, error: (any Error)?)

    func didDiscoverServices(peripheral: CBPeripheral, error: (any Error)?)

    func didDiscoverIncludedServices(peripheral: CBPeripheral, service: CBService, error: (any Error)?)

    func didDiscoverCharacteristics(peripheral: CBPeripheral, service: CBService, error: (any Error)?)

    func didUpdateCharacteristicValue(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: (any Error)?)
    
    func didWriteCharacteristicValue(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: (any Error)?)

    func didUpdateCharacteristicNotificationState(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: (any Error)?)

    func didDiscoverDescriptors(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: (any Error)?)

    func didUpdateDescriptorValue(peripheral: CBPeripheral, descriptor: CBDescriptor, error: (any Error)?)

    func didWriteDescriptorValue(peripheral: CBPeripheral, descriptor: CBDescriptor, error: (any Error)?)

    func isReadyToSendWriteWithoutResponse(peripheral: CBPeripheral)

    func didOpenL2CAPChannel(peripheral: CBPeripheral, channel: CBL2CAPChannel?, error: (any Error)?)
}


extension SFBlePeripheralPlugin {
    func readRSSI(peripheral: CBPeripheral) {}

    func discoverServices(peripheral: CBPeripheral, serviceUUIDs: [CBUUID]?) {}

    func discoverIncludedServices(peripheral: CBPeripheral, includedServiceUUIDs: [CBUUID]?, service: CBService) {}

    func discoverCharacteristics(peripheral: CBPeripheral, characteristicUUIDs: [CBUUID]?, service: CBService) {}
    
    func readCharacteristicValue(peripheral: CBPeripheral, characteristic: CBCharacteristic) {}

    func getMaximumWriteValueLength(peripheral: CBPeripheral, type: CBCharacteristicWriteType, length: Int) {}
    
    func writeCharacteristicValue(peripheral: CBPeripheral, data: Data, characteristic: CBCharacteristic, type: CBCharacteristicWriteType) {}

    func setCharacteristicNotificationState(peripheral: CBPeripheral, enabled: Bool, characteristic: CBCharacteristic) {}

    func discoverDescriptors(peripheral: CBPeripheral, characteristic: CBCharacteristic) {}

    func readDescriptorValue(peripheral: CBPeripheral, descriptor: CBDescriptor) {}

    func writeDescriptorValue(peripheral: CBPeripheral, data: Data, descriptor: CBDescriptor) {}

    func openL2CAPChannel(peripheral: CBPeripheral, PSM: CBL2CAPPSM) {}
    
    func didUpdateState(peripheral: CBPeripheral, state: CBPeripheralState) {}

    func didUpdateName(peripheral: CBPeripheral, name: String?) {}

    func didModifyServices(peripheral: CBPeripheral, invalidatedServices: [CBService]) {}

    func didUpdateRSSI(peripheral: CBPeripheral, RSSI: NSNumber?, error: (any Error)?) {}

    func didReadRSSI(peripheral: CBPeripheral, RSSI: NSNumber, error: (any Error)?) {}

    func didDiscoverServices(peripheral: CBPeripheral, error: (any Error)?) {}

    func didDiscoverIncludedServices(peripheral: CBPeripheral, service: CBService, error: (any Error)?) {}

    func didDiscoverCharacteristics(peripheral: CBPeripheral, service: CBService, error: (any Error)?) {}

    func didUpdateCharacteristicValue(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: (any Error)?) {}
    
    func didWriteCharacteristicValue(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: (any Error)?) {}

    func didUpdateCharacteristicNotificationState(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: (any Error)?) {}

    func didDiscoverDescriptors(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: (any Error)?) {}

    func didUpdateDescriptorValue(peripheral: CBPeripheral, descriptor: CBDescriptor, error: (any Error)?) {}

    func didWriteDescriptorValue(peripheral: CBPeripheral, descriptor: CBDescriptor, error: (any Error)?) {}

    func isReadyToSendWriteWithoutResponse(peripheral: CBPeripheral) {}

    func didOpenL2CAPChannel(peripheral: CBPeripheral, channel: CBL2CAPChannel?, error: (any Error)?) {}
}
