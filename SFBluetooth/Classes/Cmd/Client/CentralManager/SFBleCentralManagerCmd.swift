//
//  SFBleCentralManagerCmd.swift
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


// MARK: - SFBleCentralManagerCmd
public class SFBleCentralManagerCmd: SFBleClientCmd {
    // MARK: var
    public private(set) var bleCentralManager: SFBleCentralManager
    
    // MARK: life cycle
    public init(name: String, bleCentralManager: SFBleCentralManager) {
        self.bleCentralManager = bleCentralManager
        super.init(name: name)
        self.configBleCentralManagerNotify()
    }
    
    // MARK: func
    public override func check() -> Bool {
        guard super.check() else {
            return false
        }
        let centralManagerState = bleCentralManager.centralManager.state
        guard centralManagerState == .poweredOn else {
            onFailure(type: type, error: .client(.centralManager(.state("蓝牙未开启 state: \(centralManagerState.sf.description)"))))
            return false
        }
        return true
    }
    
    // MARK: centralManager
    open func centralManagerDidUpdateState(state: CBManagerState) {
        if state != .poweredOn {
            onFailure(type: type, error: .client(.centralManager(.state("蓝牙状态变更 state: \(state.sf.description)"))))
        }
    }
    open func centralManagerDidUpdateIsScanning(isScanning: Bool) {}
    open func centralManagerWillRestoreState(dict: [String : Any]) {}
    open func centralManagerDidDiscoverPeripheral(peripheral: CBPeripheral, advertisementData: [String : Any], RSSI: NSNumber) {}
    open func centralManagerDidConnectPeripheral(peripheral: CBPeripheral) {}
    open func centralManagerDidFailToConnectPeripheral(peripheral: CBPeripheral, error: (any Error)?) {}
    open func centralManagerDidDisconnectPeripheral(peripheral: CBPeripheral, error: (any Error)?) {}
    open func centralManagerDidDisconnectPeripheral(peripheral: CBPeripheral, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: (any Error)?) {}
    open func centralManagerDidOccurConnectionEvents(peripheral: CBPeripheral, event: CBConnectionEvent) {}
    open func centralManagerDidUpdateANCSAuthorization(peripheral: CBPeripheral) {}
    
}

// MARK: - SFBleCentralManagerCmd
extension SFBleCentralManagerCmd {
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

