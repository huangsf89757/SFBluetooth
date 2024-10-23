//
//  SFBleCentralManager.swift
//  SFBluetooth
//
//  Created by hsf on 2024/8/20.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger

// MARK: - Notify
public let SF_Notify_CentralManager_Callback_DidUpdateState =                          NSNotification.Name("SF_Notify_CentralManager_Callback_DidUpdateState")
public let SF_Notify_CentralManager_Callback_DidUpdateIsScanning =                     NSNotification.Name("SF_Notify_CentralManager_Callback_DidUpdateIsScanning")
public let SF_Notify_CentralManager_Callback_DidUpdateANCSAuthorization =              NSNotification.Name("SF_Notify_CentralManager_Callback_DidUpdateANCSAuthorization")
public let SF_Notify_CentralManager_Callback_WillRestoreState =                          NSNotification.Name("SF_Notify_CentralManager_Callback_WillRestoreState")
public let SF_Notify_CentralManager_Callback_DidDiscoverPeripheral =                     NSNotification.Name("SF_Notify_CentralManager_Callback_DidDiscoverPeripheral")
public let SF_Notify_CentralManager_Callback_DidConnectPeripheral =                 NSNotification.Name("SF_Notify_CentralManager_Callback_DidConnectPeripheral")
public let SF_Notify_CentralManager_Callback_DidFailConnectPeripheral =                 NSNotification.Name("SF_Notify_CentralManager_Callback_DidFailConnectPeripheral")
public let SF_Notify_CentralManager_Callback_DidDisconnectPeripheral =              NSNotification.Name("SF_Notify_CentralManager_Callback_DidDisconnectPeripheral")
public let SF_Notify_CentralManager_Callback_DidDisconnectPeripheralAutoReconnect = NSNotification.Name("SF_Notify_CentralManager_Callback_DidDisconnectPeripheralAutoReconnect")
public let SF_Notify_CentralManager_Callback_DidOccurConnectionEvents =                    NSNotification.Name("SF_Notify_CentralManager_Callback_DidOccurConnectionEvents")


// MARK: - SFBleCentralManager
public class SFBleCentralManager: NSObject {
    // MARK: var
    public var id = UUID()
    public private(set) var centralManager: CBCentralManager!
    public var plugins = [SFBleCentralManagerPlugin]()
   
    public private(set) lazy var discoverLogger: SFDiscoveryLogger = {
        return SFDiscoveryLogger()
    }()
    
    // MARK: life cycle
    public init(queue: dispatch_queue_t?, options: [String : Any]?) {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: queue, options: options)
        centralManager.addObserver(self, forKeyPath: "isScanning", options: .new, context: nil)
    }
    deinit {
        centralManager.removeObserver(self, forKeyPath: "isScanning")
    }
    
}

// MARK: - KVO
extension SFBleCentralManager {
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let centralManager = object as? CBCentralManager, centralManager == self.centralManager {
            if keyPath == "isScanning", let isScanning = change?[.newKey] as? Bool {
                // plugins
                plugins.forEach { plugin in
                    plugin.centralManager(centralManager, didUpdateIsScannig: id, isScanning: isScanning)
                }
                // notify
                var userInfo = [String: Any]()
                userInfo["centralManager"] = centralManager
                userInfo["isScanning"] = isScanning
                NotificationCenter.default.post(name: SF_Notify_CentralManager_Callback_DidUpdateIsScanning, object: nil, userInfo: userInfo)
                return
            }
            return
        }
    }
}


// MARK: - func
extension SFBleCentralManager {
    /// 检索外设
    public func retrievePeripherals(id: UUID, identifiers: [UUID]) -> [CBPeripheral] {
        // do
        self.id = id
        let peripherals = centralManager.retrievePeripherals(withIdentifiers: identifiers)
        // plugins
        plugins.forEach { plugin in
            plugin.centralManager(centralManager, retrievePeripherals: id, identifiers: identifiers, return: peripherals)
        }
        return peripherals
    }
    
    /// 检索已连接的外设
    public func retrieveConnectedPeripherals(id: UUID, services: [CBUUID]) -> [CBPeripheral] {
        // do
        self.id = id
        let peripherals = centralManager.retrieveConnectedPeripherals(withServices: services)
        // plugins
        plugins.forEach { plugin in
            plugin.centralManager(centralManager, retrieveConnectedPeripherals: id, services: services, return: peripherals)
        }
        return peripherals
    }
    
    /// 开始扫描
    public func scanForPeripherals(id: UUID, services: [CBUUID]?, options: [String: Any]?) {
        // do
        self.id = id
        centralManager.scanForPeripherals(withServices: services, options: options)
        // plugins
        plugins.forEach { plugin in
            plugin.centralManager(centralManager, scanForPeripherals: id, services: services, options: options)
        }
    }
    
    /// 停止扫描
    public func stopScan(id: UUID) {
        // do
        self.id = id
        centralManager.stopScan()
        // plugins
        plugins.forEach { plugin in
            plugin.centralManager(centralManager, stopScan: id)
        }
    }
    
    /// 连接外设
    public func connect(id: UUID, peripheral: CBPeripheral, options: [String: Any]?) {
        // do
        self.id = id
        centralManager.connect(peripheral, options: options)
        // plugins
        plugins.forEach { plugin in
            plugin.centralManager(centralManager, connect: id, peripheral: peripheral, options: options)
        }
    }
    
    /// 断开外设
    public func disconnect(id: UUID, peripheral: CBPeripheral) {
        // do
        self.id = id
        centralManager.cancelPeripheralConnection(peripheral)
        // plugins
        plugins.forEach { plugin in
            plugin.centralManager(centralManager, disconnect: id, peripheral: peripheral)
        }
    }
    
    /// 注册连接事件
    @available(iOS 13.0, *)
    public func registerForConnectionEvents(id: UUID, options: [CBConnectionEventMatchingOption : Any]?) {
        // do
        self.id = id
        centralManager.registerForConnectionEvents(options: options)
        // plugins
        plugins.forEach { plugin in
            plugin.centralManager(centralManager, registerForConnectionEvents: id, options: options)
        }
    }
}

// MARK: - CBCentralManagerDelegate
extension SFBleCentralManager: CBCentralManagerDelegate {
    
    
    /**
     *  @method centralManagerDidUpdateState:
     *
     *  @param central  The central manager whose state has changed.
     *
     *  @discussion     Invoked whenever the central manager's state has been updated. Commands should only be issued when the state is
     *                  <code>CBCentralManagerStatePoweredOn</code>. A state below <code>CBCentralManagerStatePoweredOn</code>
     *                  implies that scanning has stopped and any connected peripherals have been disconnected. If the state moves below
     *                  <code>CBCentralManagerStatePoweredOff</code>, all <code>CBPeripheral</code> objects obtained from this central
     *                  manager become invalid and must be retrieved or discovered again.
     *
     *  @see            state
     *
     */
    @available(iOS 5.0, *)
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        // plugins
        plugins.forEach { plugin in
            plugin.centralManager(central, didUpdateState: id)
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["centralManager"] = centralManager
        NotificationCenter.default.post(name: SF_Notify_CentralManager_Callback_DidUpdateState, object: nil, userInfo: userInfo)
    }
    
    
    /**
     *  @method centralManager:willRestoreState:
     *
     *  @param central      The central manager providing this information.
     *  @param dict            A dictionary containing information about <i>central</i> that was preserved by the system at the time the app was terminated.
     *
     *  @discussion            For apps that opt-in to state preservation and restoration, this is the first method invoked when your app is relaunched into
     *                        the background to complete some Bluetooth-related task. Use this method to synchronize your app's state with the state of the
     *                        Bluetooth system.
     *
     *  @seealso            CBCentralManagerRestoredStatePeripheralsKey;
     *  @seealso            CBCentralManagerRestoredStateScanServicesKey;
     *  @seealso            CBCentralManagerRestoredStateScanOptionsKey;
     *
     */
    @available(iOS 5.0, *)
    public func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        // plugins
        plugins.forEach { plugin in
            plugin.centralManager(central, willRestoreState: id, dict: dict)
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["centralManager"] = centralManager
        userInfo["dict"] = dict
        NotificationCenter.default.post(name: SF_Notify_CentralManager_Callback_WillRestoreState, object: nil, userInfo: userInfo)
    }
    
    
    /**
     *  @method centralManager:didDiscoverPeripheral:advertisementData:RSSI:
     *
     *  @param central              The central manager providing this update.
     *  @param peripheral           A <code>CBPeripheral</code> object.
     *  @param advertisementData    A dictionary containing any advertisement and scan response data.
     *  @param RSSI                 The current RSSI of <i>peripheral</i>, in dBm. A value of <code>127</code> is reserved and indicates the RSSI
     *                                was not available.
     *
     *  @discussion                 This method is invoked while scanning, upon the discovery of <i>peripheral</i> by <i>central</i>. A discovered peripheral must
     *                              be retained in order to use it; otherwise, it is assumed to not be of interest and will be cleaned up by the central manager. For
     *                              a list of <i>advertisementData</i> keys, see {@link CBAdvertisementDataLocalNameKey} and other similar constants.
     *
     *  @seealso                    CBAdvertisementData.h
     *
     */
    @available(iOS 5.0, *)
    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        // plugins
        plugins.forEach { plugin in
            plugin.centralManager(central, didDiscover: id, peripheral: peripheral, advertisementData: advertisementData, rssi: RSSI)
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["centralManager"] = centralManager
        userInfo["peripheral"] = peripheral
        userInfo["advertisementData"] = advertisementData
        userInfo["RSSI"] = RSSI
        NotificationCenter.default.post(name: SF_Notify_CentralManager_Callback_DidDiscoverPeripheral, object: nil, userInfo: userInfo)
    }
    
    
    /**
     *  @method centralManager:didConnectPeripheral:
     *
     *  @param central      The central manager providing this information.
     *  @param peripheral   The <code>CBPeripheral</code> that has connected.
     *
     *  @discussion         This method is invoked when a connection initiated by {@link connectPeripheral:options:} has succeeded.
     *
     */
    @available(iOS 5.0, *)
    public func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        // plugins
        plugins.forEach { plugin in
            plugin.centralManager(central, didConnect: id, peripheral: peripheral)
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["centralManager"] = centralManager
        userInfo["peripheral"] = peripheral
        NotificationCenter.default.post(name: SF_Notify_CentralManager_Callback_DidConnectPeripheral, object: nil, userInfo: userInfo)
    }
    
    
    /**
     *  @method centralManager:didFailToConnectPeripheral:error:
     *
     *  @param central      The central manager providing this information.
     *  @param peripheral   The <code>CBPeripheral</code> that has failed to connect.
     *  @param error        The cause of the failure.
     *
     *  @discussion         This method is invoked when a connection initiated by {@link connectPeripheral:options:} has failed to complete. As connection attempts do not
     *                      timeout, the failure of a connection is atypical and usually indicative of a transient issue.
     *
     */
    @available(iOS 5.0, *)
    public func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: (any Error)?) {
        // plugins
        plugins.forEach { plugin in
            plugin.centralManager(central, didFailToConnect: id, peripheral: peripheral, error: error)
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["centralManager"] = centralManager
        userInfo["peripheral"] = peripheral
        if let error = error {
            userInfo["error"] = error
        }
        NotificationCenter.default.post(name: SF_Notify_CentralManager_Callback_DidFailConnectPeripheral, object: nil, userInfo: userInfo)
    }
    
    
    /**
     *  @method centralManager:didDisconnectPeripheral:error:
     *
     *  @param central      The central manager providing this information.
     *  @param peripheral   The <code>CBPeripheral</code> that has disconnected.
     *  @param error        If an error occurred, the cause of the failure.
     *
     *  @discussion         This method is invoked upon the disconnection of a peripheral that was connected by {@link connectPeripheral:options:}. If the disconnection
     *                      was not initiated by {@link cancelPeripheralConnection}, the cause will be detailed in the <i>error</i> parameter. Once this method has been
     *                      called, no more methods will be invoked on <i>peripheral</i>'s <code>CBPeripheralDelegate</code>.
     *
     */
    @available(iOS 5.0, *)
    public func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: (any Error)?) {
        // plugins
        plugins.forEach { plugin in
            plugin.centralManager(central, didDisconnectPeripheral: id, peripheral: peripheral, error: error)
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["centralManager"] = centralManager
        userInfo["peripheral"] = peripheral
        if let error = error {
            userInfo["error"] = error
        }
        NotificationCenter.default.post(name: SF_Notify_CentralManager_Callback_DidDisconnectPeripheral, object: nil, userInfo: userInfo)
    }
    
    
    /**
     *  @method centralManager:didDisconnectPeripheral:timestamp:isReconnecting:error
     *
     *  @param central      The central manager providing this information.
     *  @param peripheral   The <code>CBPeripheral</code> that has disconnected.
     *  @param timestamp        Timestamp of the disconnection, it can be now or a few seconds ago.
     *  @param isReconnecting      If reconnect was triggered upon disconnection.
     *  @param error        If an error occurred, the cause of the failure.
     *
     *  @discussion         This method is invoked upon the disconnection of a peripheral that was connected by {@link connectPeripheral:options:}. If perihperal is
     *                      connected with connect option {@link CBConnectPeripheralOptionEnableAutoReconnect}, once this method has been called, the system
     *                      will automatically invoke connect to the peripheral. And if connection is established with the peripheral afterwards,
     *                      {@link centralManager:didConnectPeripheral:} can be invoked. If perihperal is connected without option
     *                      CBConnectPeripheralOptionEnableAutoReconnect, once this method has been called, no more methods will be invoked on
     *                       <i>peripheral</i>'s <code>CBPeripheralDelegate</code> .
     *
     */
    @available(iOS 5.0, *)
    public func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: (any Error)?) {
        // plugins
        plugins.forEach { plugin in
            plugin.centralManager(central, didDisconnectPeripheral: id, peripheral: peripheral, timestamp: timestamp, isReconnecting: isReconnecting, error: error)
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["centralManager"] = centralManager
        userInfo["peripheral"] = peripheral
        userInfo["timestamp"] = timestamp
        userInfo["isReconnecting"] = isReconnecting
        if let error = error {
            userInfo["error"] = error
        }
        NotificationCenter.default.post(name: SF_Notify_CentralManager_Callback_DidDisconnectPeripheralAutoReconnect, object: nil, userInfo: userInfo)
    }
    
    
    /**
     *  @method centralManager:connectionEventDidOccur:forPeripheral:
     *
     *  @param central      The central manager providing this information.
     *  @param event        The <code>CBConnectionEvent</code> that has occurred.
     *  @param peripheral   The <code>CBPeripheral</code> that caused the event.
     *
     *  @discussion         This method is invoked upon the connection or disconnection of a peripheral that matches any of the options provided in {@link registerForConnectionEventsWithOptions:}.
     *
     */
    @available(iOS 13.0, *)
    public func centralManager(_ central: CBCentralManager, connectionEventDidOccur event: CBConnectionEvent, for peripheral: CBPeripheral) {
        // plugins
        plugins.forEach { plugin in
            plugin.centralManager(central, connectionEventDidOccur: id, event: event, for: peripheral)
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["centralManager"] = centralManager
        userInfo["event"] = event
        userInfo["peripheral"] = peripheral
        NotificationCenter.default.post(name: SF_Notify_CentralManager_Callback_DidOccurConnectionEvents, object: nil, userInfo: userInfo)
    }
    
    
    /**
     *  @method centralManager:didUpdateANCSAuthorizationForPeripheral:
     *
     *  @param central      The central manager providing this information.
     *  @param peripheral   The <code>CBPeripheral</code> that caused the event.
     *
     *  @discussion         This method is invoked when the authorization status changes for a peripheral connected with {@link connectPeripheral:} option {@link CBConnectPeripheralOptionRequiresANCS}.
     *
     */
    @available(iOS 13.0, *)
    public func centralManager(_ central: CBCentralManager, didUpdateANCSAuthorizationFor peripheral: CBPeripheral) {
        // plugins
        plugins.forEach { plugin in
            plugin.centralManager(central, didUpdateANCSAuthorization: id, for: peripheral)
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["centralManager"] = centralManager
        userInfo["peripheral"] = peripheral
        NotificationCenter.default.post(name: SF_Notify_CentralManager_Callback_DidUpdateANCSAuthorization, object: nil, userInfo: userInfo)
    }
}


