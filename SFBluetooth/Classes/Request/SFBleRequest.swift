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

// MARK: - SFBleStep
public enum SFBleStep {
    // start
    case start
    // centralManager
    case startScan
    case stopScan
    case connect
    case disconnect
    case registerEvents
    // peripheral
    case readRSSI
    case discoverServices
    case discoverIncludedServices
    case discoverCharacteristics
    case readCharacteristicValue
    case writeCharacteristicValue
    case setNotifyValue
    case discoverDescriptors
    case readDescriptorValue
    case writeDescriptorValue
    case openL2CAPChannel
    // end
    case end
}

// MARK: - SFBleRequest
public class SFBleRequest {
    public var step: SFBleStep = .start
    
    public func next() {
        #warning("在子类中实现")
    }
}

extension SFBleRequest {
    private func addCentralManagerNotify() {
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerIsScanningDidChanged(_:)), name: SF_Notify_CentralManager_IsScanning_DidChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerStateDidUpdated(_:)), name: SF_Notify_CentralManager_State_DidUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerANCSAuthorizationDidUpdated(_:)), name: SF_Notify_CentralManager_ANCSAuthorization_DidUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerWillRestoreState(_:)), name: SF_Notify_CentralManager_WillRestoreState, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerRetrievePeripherals(_:)), name: SF_Notify_CentralManager_RetrievePeripherals, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerRetrieveConnectedPeripherals(_:)), name: SF_Notify_CentralManager_RetrieveConnectedPeripherals, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerScanStart(_:)), name: SF_Notify_CentralManager_Scan_Start, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerScanStop(_:)), name: SF_Notify_CentralManager_Scan_Stop, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerDidDiscoverPeripheral(_:)), name: SF_Notify_CentralManager_DidDiscoverPeripheral, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerConnectPeripheralStart(_:)), name: SF_Notify_CentralManager_ConnectPeripheral_Start, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerConnectPeripheralSuccess(_:)), name: SF_Notify_CentralManager_ConnectPeripheral_Success, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerConnectPeripheralFailure(_:)), name: SF_Notify_CentralManager_ConnectPeripheral_Failure, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerDisconnectPeripheralStart(_:)), name: SF_Notify_CentralManager_DisconnectPeripheral_Start, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerDisconnectPeripheralSuccess(_:)), name: SF_Notify_CentralManager_DisconnectPeripheral_Success, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerDisconnectPeripheralAutoReconnectSuccess(_:)), name: SF_Notify_CentralManager_DisconnectPeripheralAutoReconnect_Success, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerConnectionEventsRegister(_:)), name: SF_Notify_CentralManager_ConnectionEvents_Register, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(notifyCentralManagerConnectionEventsOccur(_:)), name: SF_Notify_CentralManager_ConnectionEvents_Occur, object: nil)
    }
    
    @objc private func notifyCentralManagerIsScanningDidChanged(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
        guard let isScanning = userInfo["isScanning"] as? Bool else { return }
    }
    
    @objc private func notifyCentralManagerStateDidUpdated(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
    }
    
    @objc private func notifyCentralManagerANCSAuthorizationDidUpdated(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
        guard let peripheral = userInfo["peripheral"] as? CBPeripheral else { return }
    }
    
    @objc private func notifyCentralManagerWillRestoreState(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
        guard let dict = userInfo["dict"] as? [String : Any] else { return }
    }
    
    @objc private func notifyCentralManagerRetrievePeripherals(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
        guard let identifiers = userInfo["identifiers"] as? [UUID] else { return }
        guard let peripherals = userInfo["peripherals"] as? [CBPeripheral] else { return }
    }
    
    @objc private func notifyCentralManagerRetrieveConnectedPeripherals(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
        guard let identifiers = userInfo["identifiers"] as? [UUID] else { return }
        guard let peripherals = userInfo["peripherals"] as? [CBPeripheral] else { return }
    }
    
    @objc private func notifyCentralManagerScanStart(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
        if let serviceUUIDs = userInfo["serviceUUIDs"] as? [CBUUID] {  }
        if let options = userInfo["options"] as? [String: Any] {  }
    }
    
    @objc private func notifyCentralManagerScanStop(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
    }
    
    @objc private func notifyCentralManagerDidDiscoverPeripheral(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
        guard let peripheral = userInfo["peripheral"] as? CBPeripheral else { return }
        guard let advertisementData = userInfo["advertisementData"] as? [String : Any] else { return }
        guard let RSSI = userInfo["RSSI"] as? NSNumber else { return }
    }
    
    @objc private func notifyCentralManagerConnectPeripheralStart(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
    }
    
    @objc private func notifyCentralManagerConnectPeripheralSuccess(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
    }
    
    @objc private func notifyCentralManagerConnectPeripheralFailure(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
    }
    
    @objc private func notifyCentralManagerDisconnectPeripheralStart(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
    }
    
    @objc private func notifyCentralManagerDisconnectPeripheralSuccess(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
    }
    
    @objc private func notifyCentralManagerDisconnectPeripheralAutoReconnectSuccess(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
    }
    
    @objc private func notifyCentralManagerConnectionEventsRegister(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
    }
    
    @objc private func notifyCentralManagerConnectionEventsOccur(_ sender: Notification) {
        guard let userInfo = sender.userInfo else { return }
        guard let central = userInfo["central"] as? CBCentralManager else { return }
    }
}
