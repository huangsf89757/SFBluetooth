//
//  SFBleRequest.swift
//  IQKeyboardManagerSwift
//
//  Created by hsf on 2024/10/18.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger


// MARK: - SFBleRequest
open class SFBleRequest: SFBleProtocol {
    // MARK: var
    public var id: UUID?
    public var step: SFBleStep = .start
    public var bleCentralManager: SFBleCentralManager? {
        didSet {
            configBleCentralManagerNotify()
        }
    }
    public var blePeripheral: SFBlePeripheral? {
        didSet {
            configBlePeripheralCallback()
        }
    }
    
    // MARK: func
    /// 下一步
    open func next() {
        #warning("在子类中实现")
    }
    
    /// 执行
    open func excute() {
//        guard let id = id else { return }
//        switch step {
//        case .start:
//            <#code#>
//        case .startScan:
//            bleCentralManager?.scanForPeripherals(id: id, services: <#T##[CBUUID]?#>, options: <#T##[String : Any]?#>)
//        case .stopScan:
//            bleCentralManager?.stopScan(id: id)
//        case .connect:
//            bleCentralManager?.connect(id: id, peripheral: <#T##CBPeripheral#>, options: <#T##[String : Any]?#>)
//        case .disconnect:
//            bleCentralManager?.disconnect(id: id, peripheral: <#T##CBPeripheral#>)
//        case .registerEvents:
//            if #available(iOS 13.0, *) {
//                bleCentralManager?.registerForConnectionEvents(id: id, options: <#T##[CBConnectionEventMatchingOption : Any]?#>)
//            } else {
//                // Fallback on earlier versions
//            }
//        case .readRSSI:
//            blePeripheral?.readRSSI(id: id)
//        case .discoverServices:
//            blePeripheral?.discoverServices(id: id, serviceUUIDs: <#T##[CBUUID]?#>)
//        case .discoverIncludedServices:
//            blePeripheral?.discoverIncludedServices(id: id, includedServiceUUIDs: <#T##[CBUUID]?#>, for: <#T##CBService#>)
//        case .discoverCharacteristics:
//            blePeripheral?.discoverCharacteristics(id: id, characteristicUUIDs: <#T##[CBUUID]?#>, for: <#T##CBService#>)
//        case .readCharacteristicValue:
//            blePeripheral?.readValue(id: id, for: <#T##CBCharacteristic#>)
//        case .writeCharacteristicValue:
//            blePeripheral?.writeValue(id: id, data: <#T##Data#>, for: <#T##CBCharacteristic#>, type: <#T##CBCharacteristicWriteType#>)
//        case .setNotifyValue:
//            blePeripheral?.setNotifyValue(id: id, enabled: <#T##Bool#>, for: <#T##CBCharacteristic#>)
//        case .discoverDescriptors:
//            blePeripheral?.discoverDescriptors(id: id, for: <#T##CBCharacteristic#>)
//        case .readDescriptorValue:
//            blePeripheral?.readValue(id: id, for: <#T##CBDescriptor#>)
//        case .writeDescriptorValue:
//            blePeripheral?.writeValue(id: id, data: <#T##Data#>, for: <#T##CBDescriptor#>)
//        case .openL2CAPChannel:
//            blePeripheral?.openL2CAPChannel(id: id, PSM: <#T##CBL2CAPPSM#>)
//        case .end:
//            <#code#>
//        }
    }
    
    // MARK: centralManager
    open func centralManagerIsScanningDidUpdated(isScanning: Bool) {}
    open func centralManagerStateDidUpdated(state: CBManagerState) {}
    open func centralManagerWillRestoreState(dict: [String : Any]) {}
    open func centralManagerDidDiscoverPeripheral(peripheral: CBPeripheral, advertisementData: [String : Any], RSSI: NSNumber) {}
    open func centralManagerConnectPeripheralSuccess(peripheral: CBPeripheral) {}
    open func centralManagerConnectPeripheralFailure(peripheral: CBPeripheral, error: (any Error)?) {}
    open func centralManagerDisconnectPeripheralSuccess(peripheral: CBPeripheral, error: (any Error)?) {}
    open func centralManagerDisconnectPeripheralAutoReconnectSuccess(peripheral: CBPeripheral, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: (any Error)?) {}
    open func centralManagerConnectionEventsOccur(peripheral: CBPeripheral, event: CBConnectionEvent) {}
    open func centralManagerANCSAuthorizationDidUpdated(peripheral: CBPeripheral) {}
    
    // MARK: peripheral
    open func peripheralDidUpdateState(peripheral: CBPeripheral, state: CBPeripheralState) -> () {}
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
extension SFBleRequest {
    private func configBleCentralManagerNotify() {
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerCallbackIsScanningDidUpdated), name: SF_Notify_CentralManager_Callback_IsScanning_DidUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerCallbackStateDidUpdated), name: SF_Notify_CentralManager_Callback_State_DidUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerCallbackWillRestoreState), name: SF_Notify_CentralManager_Callback_WillRestoreState, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerCallbackDidDiscoverPeripheral), name: SF_Notify_CentralManager_Callback_DidDiscoverPeripheral, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerCallbackConnectPeripheralSuccess), name: SF_Notify_CentralManager_Callback_ConnectPeripheral_Success, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerCallbackConnectPeripheralFailure), name: SF_Notify_CentralManager_Callback_ConnectPeripheral_Failure, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerCallbackDisconnectPeripheralSuccess), name: SF_Notify_CentralManager_Callback_DisconnectPeripheral_Success, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerCallbackDisconnectPeripheralAutoReconnectSuccess), name: SF_Notify_CentralManager_Callback_DisconnectPeripheralAutoReconnect_Success, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerCallbackConnectionEventsOccur), name: SF_Notify_CentralManager_Callback_ConnectionEvents_Occur, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerCallbackANCSAuthorizationDidUpdated), name: SF_Notify_CentralManager_Callback_ANCSAuthorization_DidUpdated, object: nil)
    }
    
    @objc private func notifyCentralManagerCallbackIsScanningDidUpdated(_ sender: NSNotification) {
        guard let userInfo = sender.userInfo else { Log.error("userInfo=nil"); return }
        guard let centralManager = userInfo["centralManager"] as? CBCentralManager else { Log.error("centralManager=nil"); return }
        guard centralManager === bleCentralManager?.centralManager else { Log.debug("centralManager !== bleCentralManager.centralManager"); return }
        guard let isScanning = userInfo["isScanning"] as? Bool else { Log.error("isScanning=nil"); return }
        centralManagerIsScanningDidUpdated(isScanning: isScanning)
    }
    
    @objc private func notifyCentralManagerCallbackStateDidUpdated(_ sender: NSNotification) {
        guard let userInfo = sender.userInfo else { Log.error("userInfo=nil"); return }
        guard let centralManager = userInfo["centralManager"] as? CBCentralManager else { Log.error("centralManager=nil"); return }
        guard centralManager === bleCentralManager?.centralManager else { Log.debug("centralManager !== bleCentralManager.centralManager"); return }
        centralManagerStateDidUpdated(state: centralManager.state)
    }
    
    @objc private func notifyCentralManagerCallbackWillRestoreState(_ sender: NSNotification) {
        guard let userInfo = sender.userInfo else { Log.error("userInfo=nil"); return }
        guard let centralManager = userInfo["centralManager"] as? CBCentralManager else { Log.error("centralManager=nil"); return }
        guard centralManager === bleCentralManager?.centralManager else { Log.debug("centralManager !== bleCentralManager.centralManager"); return }
        guard let dict = userInfo["dict"] as? [String : Any] else { Log.error("dict=nil"); return }
        centralManagerWillRestoreState(dict: dict)
    }
    
    @objc private func notifyCentralManagerCallbackDidDiscoverPeripheral(_ sender: NSNotification) {
        guard let userInfo = sender.userInfo else { Log.error("userInfo=nil"); return }
        guard let centralManager = userInfo["centralManager"] as? CBCentralManager else { Log.error("centralManager=nil"); return }
        guard centralManager === bleCentralManager?.centralManager else { Log.debug("centralManager !== bleCentralManager.centralManager"); return }
        guard let peripheral = userInfo["peripheral"] as? CBPeripheral else { Log.error("peripheral=nil"); return }
        guard let advertisementData = userInfo["advertisementData"] as? [String : Any] else { Log.error("advertisementData=nil"); return }
        guard let RSSI = userInfo["RSSI"] as? NSNumber else { Log.error("RSSI=nil"); return }
        centralManagerDidDiscoverPeripheral(peripheral: peripheral, advertisementData: advertisementData, RSSI: RSSI)
    }
    
    @objc private func notifyCentralManagerCallbackConnectPeripheralSuccess(_ sender: NSNotification) {
        guard let userInfo = sender.userInfo else { Log.error("userInfo=nil"); return }
        guard let centralManager = userInfo["centralManager"] as? CBCentralManager else { Log.error("centralManager=nil"); return }
        guard centralManager === bleCentralManager?.centralManager else { Log.debug("centralManager !== bleCentralManager.centralManager"); return }
        guard let peripheral = userInfo["peripheral"] as? CBPeripheral else { Log.error("peripheral=nil"); return }
        centralManagerConnectPeripheralSuccess(peripheral: peripheral)
    }
    
    @objc private func notifyCentralManagerCallbackConnectPeripheralFailure(_ sender: NSNotification) {
        guard let userInfo = sender.userInfo else { Log.error("userInfo=nil"); return }
        guard let centralManager = userInfo["centralManager"] as? CBCentralManager else { Log.error("centralManager=nil"); return }
        guard centralManager === bleCentralManager?.centralManager else { Log.debug("centralManager !== bleCentralManager.centralManager"); return }
        guard let peripheral = userInfo["peripheral"] as? CBPeripheral else { Log.error("peripheral=nil"); return }
        if let error = userInfo["error"] as? (any Error) { 
            centralManagerConnectPeripheralFailure(peripheral: peripheral, error: error)
        } else {
            centralManagerConnectPeripheralFailure(peripheral: peripheral, error: nil)
        }
    }
    
    @objc private func notifyCentralManagerCallbackDisconnectPeripheralSuccess(_ sender: NSNotification) {
        guard let userInfo = sender.userInfo else { Log.error("userInfo=nil"); return }
        guard let centralManager = userInfo["centralManager"] as? CBCentralManager else { Log.error("centralManager=nil"); return }
        guard centralManager === bleCentralManager?.centralManager else { Log.debug("centralManager !== bleCentralManager.centralManager"); return }
        guard let peripheral = userInfo["peripheral"] as? CBPeripheral else { Log.error("peripheral=nil"); return }
        if let error = userInfo["error"] as? (any Error) { 
            centralManagerDisconnectPeripheralSuccess(peripheral: peripheral, error: error)
        } else {
            centralManagerDisconnectPeripheralSuccess(peripheral: peripheral, error: nil)
        }
    }
    
    @objc private func notifyCentralManagerCallbackDisconnectPeripheralAutoReconnectSuccess(_ sender: NSNotification) {
        guard let userInfo = sender.userInfo else { Log.error("userInfo=nil"); return }
        guard let centralManager = userInfo["centralManager"] as? CBCentralManager else { Log.error("centralManager=nil"); return }
        guard centralManager === bleCentralManager?.centralManager else { Log.debug("centralManager !== bleCentralManager.centralManager"); return }
        guard let peripheral = userInfo["peripheral"] as? CBPeripheral else { Log.error("peripheral=nil"); return }
        guard let timestamp = userInfo["timestamp"] as? CFAbsoluteTime else { Log.error("timestamp=nil"); return }
        guard let isReconnecting = userInfo["isReconnecting"] as? Bool else { Log.error("isReconnecting=nil"); return }
        if let error = userInfo["error"] as? (any Error) {
            centralManagerDisconnectPeripheralAutoReconnectSuccess(peripheral: peripheral, timestamp: timestamp, isReconnecting: isReconnecting, error: error)
        } else {
            centralManagerDisconnectPeripheralAutoReconnectSuccess(peripheral: peripheral, timestamp: timestamp, isReconnecting: isReconnecting, error: nil)
        }
    }
    
    @objc private func notifyCentralManagerCallbackConnectionEventsOccur(_ sender: NSNotification) {
        guard let userInfo = sender.userInfo else { Log.error("userInfo=nil"); return }
        guard let centralManager = userInfo["centralManager"] as? CBCentralManager else { Log.error("centralManager=nil"); return }
        guard centralManager === bleCentralManager?.centralManager else { Log.debug("centralManager !== bleCentralManager.centralManager"); return }
        guard let event = userInfo["event"] as? CBConnectionEvent else { Log.error("event=nil"); return }
        guard let peripheral = userInfo["peripheral"] as? CBPeripheral else { Log.error("peripheral=nil"); return }
        centralManagerConnectionEventsOccur(peripheral: peripheral, event: event)
    }
    
    @objc private func notifyCentralManagerCallbackANCSAuthorizationDidUpdated(_ sender: NSNotification) {
        guard let userInfo = sender.userInfo else { Log.error("userInfo=nil"); return }
        guard let centralManager = userInfo["centralManager"] as? CBCentralManager else { Log.error("centralManager=nil"); return }
        guard centralManager === bleCentralManager?.centralManager else { Log.debug("centralManager !== bleCentralManager.centralManager"); return }
        guard let peripheral = userInfo["peripheral"] as? CBPeripheral else { Log.error("peripheral=nil"); return }
        centralManagerANCSAuthorizationDidUpdated(peripheral: peripheral)
    }
}

// MARK: - BlePeripheral
extension SFBleRequest {
    private func configBlePeripheralCallback() {
        blePeripheral?.didUpdateState = {
            [weak self] peripheral, state in
            self?.peripheralDidUpdateState(peripheral: peripheral, state: state)
        }
        blePeripheral?.didUpdateName = {
            [weak self] peripheral in
            self?.peripheralDidUpdateName(peripheral: peripheral)
        }
        blePeripheral?.didModifyServices = {
            [weak self] peripheral, invalidatedServices in
            self?.peripheralDidModifyServices(peripheral: peripheral, invalidatedServices: invalidatedServices)
        }
        blePeripheral?.didUpdateRSSI = {
            [weak self] peripheral, error in
            self?.peripheralDidUpdateRSSI(peripheral: peripheral, error: error)
        }
        blePeripheral?.isReadyToSendWriteWithoutResponse = {
            [weak self] peripheral in
            self?.peripheralIsReadyToSendWriteWithoutResponse(peripheral: peripheral)
        }
        blePeripheral?.didReadRSSI = {
            [weak self] peripheral, RSSI, error in
            self?.peripheralDidReadRSSI(peripheral: peripheral, RSSI: RSSI, error: error)
        }
        blePeripheral?.didDiscoverServices = {
            [weak self] peripheral, error in
            self?.peripheralDidDiscoverServices(peripheral: peripheral, error: error)
        }
        blePeripheral?.didDiscoverIncludedServices = {
            [weak self] peripheral, service, error in
            self?.peripheralDidDiscoverIncludedServices(peripheral: peripheral, service: service, error: error)
        }
        blePeripheral?.didDiscoverCharacteristics = {
            [weak self] peripheral, service, error in
            self?.peripheralDidDiscoverCharacteristics(peripheral: peripheral, service: service, error: error)
        }
        blePeripheral?.didUpdateValueForCharacteristic = {
            [weak self] peripheral, characteristic, error in
            self?.peripheralDidUpdateValueForCharacteristic(peripheral: peripheral, characteristic: characteristic, error: error)
        }
        blePeripheral?.didWriteValueForCharacteristic = {
            [weak self] peripheral, characteristic, error in
            self?.peripheralDidWriteValueForCharacteristic(peripheral: peripheral, characteristic: characteristic, error: error)
        }
        blePeripheral?.didUpdateNotificationStateForCharacteristic = {
            [weak self] peripheral, characteristic, error in
            self?.peripheralDidUpdateNotificationStateForCharacteristic(peripheral: peripheral, characteristic: characteristic, error: error)
        }
        blePeripheral?.didDiscoverDescriptorsForCharacteristic = {
            [weak self] peripheral, characteristic, error in
            self?.peripheralDidDiscoverDescriptorsForCharacteristic(peripheral: peripheral, characteristic: characteristic, error: error)
        }
        blePeripheral?.didUpdateValueForDescriptor = {
            [weak self] peripheral, descriptor, error in
            self?.peripheralDidUpdateValueForDescriptor(peripheral: peripheral, descriptor: descriptor, error: error)
        }
        blePeripheral?.didWriteValueForDescriptor = {
            [weak self] peripheral, descriptor, error in
            self?.peripheralDidWriteValueForDescriptor(peripheral: peripheral, descriptor: descriptor, error: error)
        }
        blePeripheral?.didOpenChannel = {
            [weak self] peripheral, channel, error in
            self?.peripheralDidOpenChannel(peripheral: peripheral, channel: channel, error: error)
        }
    }
}
