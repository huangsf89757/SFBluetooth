//
//  SFBleClientCmd.swift
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


// MARK: - SFBleClientCmd
open class SFBleClientCmd: SFBleCmd {
    // MARK: var
    public private(set) var bleCentralManager: SFBleCentralManager
    public private(set) var blePeripheral: SFBlePeripheral
    
    // MARK: life cycle
    public init(bleCentralManager: SFBleCentralManager, blePeripheral: SFBlePeripheral, success: @escaping SFBleSuccess, failure: @escaping SFBleFailure) {
        self.bleCentralManager = bleCentralManager
        self.blePeripheral = blePeripheral
        super.init(type: .client, success: success, failure: failure)
        self.configBleCentralManagerNotify()
        self.configBlePeripheralCallback()
    }
    
    // MARK: func
    open override func excute() {
        super.excute()
        let centralManagerState = bleCentralManager.centralManager.state
        guard centralManagerState == .poweredOn else {
            onFailure(error: .client(.centralManager(.state("蓝牙未开启。state: \(centralManagerState.sf.description)"))))
            return
        }
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
    
    // MARK: centralManager
    open func centralManagerDidUpdateState(state: CBManagerState) {
        if state != .poweredOn {
            onFailure(error: .client(.centralManager(.state("蓝牙未开启。state: \(state.sf.description)"))))
        }
    }
    open func centralManagerDidUpdateIsScanning(isScanning: Bool) {
        if isScanning {
            onFailure(error: .client(.centralManager(.isScanning("当前处于扫描状态。"))))
        }
    }
    open func centralManagerWillRestoreState(dict: [String : Any]) {}
    open func centralManagerDidDiscoverPeripheral(peripheral: CBPeripheral, advertisementData: [String : Any], RSSI: NSNumber) {}
    open func centralManagerDidConnectPeripheral(peripheral: CBPeripheral) {}
    open func centralManagerDidFailToConnectPeripheral(peripheral: CBPeripheral, error: (any Error)?) {}
    open func centralManagerDidDisconnectPeripheral(peripheral: CBPeripheral, error: (any Error)?) {}
    open func centralManagerDidDisconnectPeripheral(peripheral: CBPeripheral, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: (any Error)?) {}
    open func centralManagerDidOccurConnectionEvents(peripheral: CBPeripheral, event: CBConnectionEvent) {}
    open func centralManagerDidUpdateANCSAuthorization(peripheral: CBPeripheral) {}
    
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

// MARK: - BleCentralManager
extension SFBleClientCmd {
    private func configBleCentralManagerNotify() {
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerCallbackDidUpdateState), name: SF_Notify_CentralManager_Callback_DidUpdateState, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerCallbackDidUpdateIsScanning), name: SF_Notify_CentralManager_Callback_DidUpdateIsScanning, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerCallbackWillRestoreState), name: SF_Notify_CentralManager_Callback_WillRestoreState, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerCallbackDidDiscoverPeripheral), name: SF_Notify_CentralManager_Callback_DidDiscoverPeripheral, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerCallbackDidConnectPeripheral), name: SF_Notify_CentralManager_Callback_DidConnectPeripheral, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerCallbackDidFailConnectPeripheral), name: SF_Notify_CentralManager_Callback_DidFailConnectPeripheral, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerCallbackDidDisconnectPeripheral), name: SF_Notify_CentralManager_Callback_DidDisconnectPeripheral, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerCallbackDidDisconnectPeripheralAutoReconnect), name: SF_Notify_CentralManager_Callback_DidDisconnectPeripheralAutoReconnect, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerCallbackDidOccurConnectionEvents), name: SF_Notify_CentralManager_Callback_DidOccurConnectionEvents, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerCallbackDidUpdateANCSAuthorization), name: SF_Notify_CentralManager_Callback_DidUpdateANCSAuthorization, object: nil)
    }
    
    @objc private func notifyCentralManagerCallbackDidUpdateState(_ sender: NSNotification) {
        guard let userInfo = sender.userInfo else { Log.error("userInfo=nil"); return }
        guard let centralManager = userInfo["centralManager"] as? CBCentralManager else { Log.error("centralManager=nil"); return }
        guard centralManager === bleCentralManager.centralManager else { Log.debug("centralManager !== bleCentralManager.centralManager"); return }
        centralManagerDidUpdateState(state: centralManager.state)
    }
    
    @objc private func notifyCentralManagerCallbackDidUpdateIsScanning(_ sender: NSNotification) {
        guard let userInfo = sender.userInfo else { Log.error("userInfo=nil"); return }
        guard let centralManager = userInfo["centralManager"] as? CBCentralManager else { Log.error("centralManager=nil"); return }
        guard centralManager === bleCentralManager.centralManager else { Log.debug("centralManager !== bleCentralManager.centralManager"); return }
        guard let isScanning = userInfo["isScanning"] as? Bool else { Log.error("isScanning=nil"); return }
        centralManagerDidUpdateIsScanning(isScanning: isScanning)
    }
    
    @objc private func notifyCentralManagerCallbackWillRestoreState(_ sender: NSNotification) {
        guard let userInfo = sender.userInfo else { Log.error("userInfo=nil"); return }
        guard let centralManager = userInfo["centralManager"] as? CBCentralManager else { Log.error("centralManager=nil"); return }
        guard centralManager === bleCentralManager.centralManager else { Log.debug("centralManager !== bleCentralManager.centralManager"); return }
        guard let dict = userInfo["dict"] as? [String : Any] else { Log.error("dict=nil"); return }
        centralManagerWillRestoreState(dict: dict)
    }
    
    @objc private func notifyCentralManagerCallbackDidDiscoverPeripheral(_ sender: NSNotification) {
        guard let userInfo = sender.userInfo else { Log.error("userInfo=nil"); return }
        guard let centralManager = userInfo["centralManager"] as? CBCentralManager else { Log.error("centralManager=nil"); return }
        guard centralManager === bleCentralManager.centralManager else { Log.debug("centralManager !== bleCentralManager.centralManager"); return }
        guard let peripheral = userInfo["peripheral"] as? CBPeripheral else { Log.error("peripheral=nil"); return }
        guard let advertisementData = userInfo["advertisementData"] as? [String : Any] else { Log.error("advertisementData=nil"); return }
        guard let RSSI = userInfo["RSSI"] as? NSNumber else { Log.error("RSSI=nil"); return }
        centralManagerDidDiscoverPeripheral(peripheral: peripheral, advertisementData: advertisementData, RSSI: RSSI)
    }
    
    @objc private func notifyCentralManagerCallbackDidConnectPeripheral(_ sender: NSNotification) {
        guard let userInfo = sender.userInfo else { Log.error("userInfo=nil"); return }
        guard let centralManager = userInfo["centralManager"] as? CBCentralManager else { Log.error("centralManager=nil"); return }
        guard centralManager === bleCentralManager.centralManager else { Log.debug("centralManager !== bleCentralManager.centralManager"); return }
        guard let peripheral = userInfo["peripheral"] as? CBPeripheral else { Log.error("peripheral=nil"); return }
        centralManagerDidConnectPeripheral(peripheral: peripheral)
    }
    
    @objc private func notifyCentralManagerCallbackDidFailConnectPeripheral(_ sender: NSNotification) {
        guard let userInfo = sender.userInfo else { Log.error("userInfo=nil"); return }
        guard let centralManager = userInfo["centralManager"] as? CBCentralManager else { Log.error("centralManager=nil"); return }
        guard centralManager === bleCentralManager.centralManager else { Log.debug("centralManager !== bleCentralManager.centralManager"); return }
        guard let peripheral = userInfo["peripheral"] as? CBPeripheral else { Log.error("peripheral=nil"); return }
        if let error = userInfo["error"] as? (any Error) {
            centralManagerDidFailToConnectPeripheral(peripheral: peripheral, error: error)
        } else {
            centralManagerDidFailToConnectPeripheral(peripheral: peripheral, error: nil)
        }
    }
    
    @objc private func notifyCentralManagerCallbackDidDisconnectPeripheral(_ sender: NSNotification) {
        guard let userInfo = sender.userInfo else { Log.error("userInfo=nil"); return }
        guard let centralManager = userInfo["centralManager"] as? CBCentralManager else { Log.error("centralManager=nil"); return }
        guard centralManager === bleCentralManager.centralManager else { Log.debug("centralManager !== bleCentralManager.centralManager"); return }
        guard let peripheral = userInfo["peripheral"] as? CBPeripheral else { Log.error("peripheral=nil"); return }
        if let error = userInfo["error"] as? (any Error) {
            centralManagerDidDisconnectPeripheral(peripheral: peripheral, error: error)
        } else {
            centralManagerDidDisconnectPeripheral(peripheral: peripheral, error: nil)
        }
    }
    
    @objc private func notifyCentralManagerCallbackDidDisconnectPeripheralAutoReconnect(_ sender: NSNotification) {
        guard let userInfo = sender.userInfo else { Log.error("userInfo=nil"); return }
        guard let centralManager = userInfo["centralManager"] as? CBCentralManager else { Log.error("centralManager=nil"); return }
        guard centralManager === bleCentralManager.centralManager else { Log.debug("centralManager !== bleCentralManager.centralManager"); return }
        guard let peripheral = userInfo["peripheral"] as? CBPeripheral else { Log.error("peripheral=nil"); return }
        guard let timestamp = userInfo["timestamp"] as? CFAbsoluteTime else { Log.error("timestamp=nil"); return }
        guard let isReconnecting = userInfo["isReconnecting"] as? Bool else { Log.error("isReconnecting=nil"); return }
        if let error = userInfo["error"] as? (any Error) {
            centralManagerDidDisconnectPeripheral(peripheral: peripheral, timestamp: timestamp, isReconnecting: isReconnecting, error: error)
        } else {
            centralManagerDidDisconnectPeripheral(peripheral: peripheral, timestamp: timestamp, isReconnecting: isReconnecting, error: nil)
        }
    }
    
    @objc private func notifyCentralManagerCallbackDidOccurConnectionEvents(_ sender: NSNotification) {
        guard let userInfo = sender.userInfo else { Log.error("userInfo=nil"); return }
        guard let centralManager = userInfo["centralManager"] as? CBCentralManager else { Log.error("centralManager=nil"); return }
        guard centralManager === bleCentralManager.centralManager else { Log.debug("centralManager !== bleCentralManager.centralManager"); return }
        guard let event = userInfo["event"] as? CBConnectionEvent else { Log.error("event=nil"); return }
        guard let peripheral = userInfo["peripheral"] as? CBPeripheral else { Log.error("peripheral=nil"); return }
        centralManagerDidOccurConnectionEvents(peripheral: peripheral, event: event)
    }
    
    @objc private func notifyCentralManagerCallbackDidUpdateANCSAuthorization(_ sender: NSNotification) {
        guard let userInfo = sender.userInfo else { Log.error("userInfo=nil"); return }
        guard let centralManager = userInfo["centralManager"] as? CBCentralManager else { Log.error("centralManager=nil"); return }
        guard centralManager === bleCentralManager.centralManager else { Log.debug("centralManager !== bleCentralManager.centralManager"); return }
        guard let peripheral = userInfo["peripheral"] as? CBPeripheral else { Log.error("peripheral=nil"); return }
        centralManagerDidUpdateANCSAuthorization(peripheral: peripheral)
    }
}

// MARK: - BlePeripheral
extension SFBleClientCmd {
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

