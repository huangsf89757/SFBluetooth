//
//  SFBlePeripheralCmd.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/24.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger


// MARK: - SFBlePeripheralCmd
public class SFBlePeripheralCmd: SFBleCentralManagerCmd {
    // MARK: var
    public let blePeripheral: SFBlePeripheral
    
    // MARK: life cycle
    public init(name: String, bleCentralManager: SFBleCentralManager, blePeripheral: SFBlePeripheral) {
        self.blePeripheral = blePeripheral
        super.init(name: name, bleCentralManager: bleCentralManager)
        self.configBlePeripheralCallback()
    }
    
    // MARK: func
    public override func check() -> Bool {
        let isScanning = bleCentralManager.centralManager.isScanning
        if isScanning {
            onFailure(type: type, error: .client(.centralManager(.scan("centralManager.isScanning != true. isScanning:\(isScanning)"))))
            return false
        }
        let peripheralState = blePeripheral.peripheral.state
        guard peripheralState == .connected else {
            onFailure(type: type, error: .client(.centralManager(.state("peripheral.state != connected. state: \(peripheralState.sf.description)."))))
            return false
        }
        return true
    }
    
    // MARK: peripheral
    open func peripheralDidUpdateState(peripheral: CBPeripheral, state: CBPeripheralState) -> () {
        if state != .connected {
            onFailure(type: type, error: .client(.centralManager(.state("did update peripheral.state( \(state.sf.description))."))))
            return
        }
    }
    open func peripheralDidUpdateName(peripheral: CBPeripheral) -> () {}
    open func peripheralDidModifyServices(peripheral: CBPeripheral, invalidatedServices: [CBService]) -> () {}
    open func peripheralDidUpdateRSSI(peripheral: CBPeripheral, error: (any Error)?) -> () {}
    open func peripheralIsReadyToSendWriteWithoutResponse(peripheral: CBPeripheral) -> () {}
    open func peripheralDidReadRssi(peripheral: CBPeripheral, RSSI: NSNumber, error: (any Error)?) -> () {}
    open func peripheralDidDiscoverServices(peripheral: CBPeripheral, error: (any Error)?) -> () {}
    open func peripheralDidDiscoverIncludedServices(peripheral: CBPeripheral, service: CBService, error: (any Error)?) -> () {}
    open func peripheralDidDiscoverCharacteristics(peripheral: CBPeripheral, service: CBService, error: (any Error)?) -> () {}
    open func peripheralDidUpdateValueForCharacteristic(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: (any Error)?) -> () {}
    open func peripheralDidWriteValueForCharacteristic(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: (any Error)?) -> () {}
    open func peripheralDidUpdateNotificationStateForCharacteristic(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: (any Error)?) -> () {}
    open func peripheralDidDiscoverDescriptorsForCharacteristic(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: (any Error)?) -> () {}
    open func peripheralDidUpdateValueForDescriptor(peripheral: CBPeripheral, descriptor: CBDescriptor, error: (any Error)?) -> () {}
    open func peripheralDidWriteValueForDescriptor(peripheral: CBPeripheral, descriptor: CBDescriptor, error: (any Error)?) -> () {}
    open func peripheralDidOpenChannel(peripheral: CBPeripheral, channel: CBL2CAPChannel?, error: (any Error)?) -> () {}
}


// MARK: - BlePeripheral
extension SFBlePeripheralCmd {
    private func configBlePeripheralCallback() {
        blePeripheral.didUpdateState = {
            [weak self] peripheral, state in
            self?.peripheralDidUpdateState(peripheral: peripheral, state: state)
        }
        blePeripheral.didUpdateName = {
            [weak self] peripheral in
            self?.peripheralDidUpdateName(peripheral: peripheral)
        }
        blePeripheral.didModifyServices = {
            [weak self] peripheral, invalidatedServices in
            self?.peripheralDidModifyServices(peripheral: peripheral, invalidatedServices: invalidatedServices)
        }
        blePeripheral.didUpdateRSSI = {
            [weak self] peripheral, error in
            self?.peripheralDidUpdateRSSI(peripheral: peripheral, error: error)
        }
        blePeripheral.isReadyToSendWriteWithoutResponse = {
            [weak self] peripheral in
            self?.peripheralIsReadyToSendWriteWithoutResponse(peripheral: peripheral)
        }
        blePeripheral.didReadRSSI = {
            [weak self] peripheral, RSSI, error in
            self?.peripheralDidReadRssi(peripheral: peripheral, RSSI: RSSI, error: error)
        }
        blePeripheral.didDiscoverServices = {
            [weak self] peripheral, error in
            self?.peripheralDidDiscoverServices(peripheral: peripheral, error: error)
        }
        blePeripheral.didDiscoverIncludedServices = {
            [weak self] peripheral, service, error in
            self?.peripheralDidDiscoverIncludedServices(peripheral: peripheral, service: service, error: error)
        }
        blePeripheral.didDiscoverCharacteristics = {
            [weak self] peripheral, service, error in
            self?.peripheralDidDiscoverCharacteristics(peripheral: peripheral, service: service, error: error)
        }
        blePeripheral.didUpdateValueForCharacteristic = {
            [weak self] peripheral, characteristic, error in
            self?.peripheralDidUpdateValueForCharacteristic(peripheral: peripheral, characteristic: characteristic, error: error)
        }
        blePeripheral.didWriteValueForCharacteristic = {
            [weak self] peripheral, characteristic, error in
            self?.peripheralDidWriteValueForCharacteristic(peripheral: peripheral, characteristic: characteristic, error: error)
        }
        blePeripheral.didUpdateNotificationStateForCharacteristic = {
            [weak self] peripheral, characteristic, error in
            self?.peripheralDidUpdateNotificationStateForCharacteristic(peripheral: peripheral, characteristic: characteristic, error: error)
        }
        blePeripheral.didDiscoverDescriptorsForCharacteristic = {
            [weak self] peripheral, characteristic, error in
            self?.peripheralDidDiscoverDescriptorsForCharacteristic(peripheral: peripheral, characteristic: characteristic, error: error)
        }
        blePeripheral.didUpdateValueForDescriptor = {
            [weak self] peripheral, descriptor, error in
            self?.peripheralDidUpdateValueForDescriptor(peripheral: peripheral, descriptor: descriptor, error: error)
        }
        blePeripheral.didWriteValueForDescriptor = {
            [weak self] peripheral, descriptor, error in
            self?.peripheralDidWriteValueForDescriptor(peripheral: peripheral, descriptor: descriptor, error: error)
        }
        blePeripheral.didOpenChannel = {
            [weak self] peripheral, channel, error in
            self?.peripheralDidOpenChannel(peripheral: peripheral, channel: channel, error: error)
        }
    }
}


