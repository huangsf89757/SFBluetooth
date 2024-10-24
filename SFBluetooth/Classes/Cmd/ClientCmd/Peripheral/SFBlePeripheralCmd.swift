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
open class SFBlePeripheralCmd: SFBleCentralManagerCmd {
    // MARK: var
    public private(set) var blePeripheral: SFBlePeripheral
    
    // MARK: life cycle
    public init(type: SFBleCmdType, bleCentralManager: SFBleCentralManager, blePeripheral: SFBlePeripheral, success: @escaping SFBleSuccess, failure: @escaping SFBleFailure) {
        self.blePeripheral = blePeripheral
        super.init(type: type, bleCentralManager: bleCentralManager, success: success, failure: failure)
        self.configBlePeripheralCallback()
    }
    
    // MARK: func
    open override func excute() {
        super.excute()
        let isScanning = bleCentralManager.centralManager.isScanning
        if isScanning {
            onFailure(error: .client(.centralManager(.isScanning("当前扫描中，请先停止扫描。"))))
            return
        }
        let peripheralState = blePeripheral.peripheral.state
        guard peripheralState == .connected else {
            onFailure(error: .client(.centralManager(.connectPeripheral("外设不在连接中。state: \(peripheralState.sf.description)"))))
            return
        }
    }
    
    // MARK: peripheral
    open func peripheralDidUpdateState(peripheral: CBPeripheral, state: CBPeripheralState) -> () {
        if state != .connected {
            failure(.client(.centralManager(.connectPeripheral("外设不在连接中。state: \(state.sf.description)"))))
            return
        }
    }
    open func peripheralDidUpdateName(peripheral: CBPeripheral) -> () {}
    open func peripheralDidModifyServices(peripheral: CBPeripheral, invalidatedServices: [CBService]) -> () {}
    open func peripheralDidUpdateRSSI(peripheral: CBPeripheral, error: (any Error)?) -> () {}
    open func peripheralIsReadyToSendWriteWithoutResponse(peripheral: CBPeripheral) -> () {}
    open func peripheralDidReadRSSI(peripheral: CBPeripheral, RSSI: NSNumber, error: (any Error)?) -> () {}
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
            self?.peripheralDidReadRSSI(peripheral: peripheral, RSSI: RSSI, error: error)
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


