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
public let SF_Notify_CentralManager_Callback_IsScanning_DidUpdated =                     NSNotification.Name("SF_Notify_CentralManager_Callback_IsScanning_DidUpdated")
public let SF_Notify_CentralManager_Callback_State_DidUpdated =                          NSNotification.Name("SF_Notify_CentralManager_Callback_State_DidUpdated")
public let SF_Notify_CentralManager_Callback_ANCSAuthorization_DidUpdated =              NSNotification.Name("SF_Notify_CentralManager_Callback_ANCSAuthorization_DidUpdated")
public let SF_Notify_CentralManager_Callback_WillRestoreState =                          NSNotification.Name("SF_Notify_CentralManager_Callback_WillRestoreState")
public let SF_Notify_CentralManager_Callback_DidDiscoverPeripheral =                     NSNotification.Name("SF_Notify_CentralManager_Callback_DidDiscoverPeripheral")
public let SF_Notify_CentralManager_Callback_ConnectPeripheral_Success =                 NSNotification.Name("SF_Notify_CentralManager_Callback_ConnectPeripheral_Success")
public let SF_Notify_CentralManager_Callback_ConnectPeripheral_Failure =                 NSNotification.Name("SF_Notify_CentralManager_Callback_ConnectPeripheral_Failure")
public let SF_Notify_CentralManager_Callback_DisconnectPeripheral_Success =              NSNotification.Name("SF_Notify_CentralManager_Callback_DisconnectPeripheral_Success")
public let SF_Notify_CentralManager_Callback_DisconnectPeripheralAutoReconnect_Success = NSNotification.Name("SF_Notify_CentralManager_Callback_DisconnectPeripheralAutoReconnect_Success")
public let SF_Notify_CentralManager_Callback_ConnectionEvents_Occur =                    NSNotification.Name("SF_Notify_CentralManager_Callback_ConnectionEvents_Occur")

// MARK: - Tag
public let SF_Tag_CentralManager_IsScanning_DidUpdated =                        "Tag_CentralManager_IsScanning_DidUpdated"
public let SF_Tag_CentralManager_State_DidUpdated =                             "Tag_CentralManager_State_DidUpdated"
public let SF_Tag_CentralManager_ANCSAuthorization_DidUpdated =                 "Tag_CentralManager_ANCSAuthorization_DidUpdated"
public let SF_Tag_CentralManager_WillRestoreState =                             "Tag_CentralManager_WillRestoreState"
public let SF_Tag_CentralManager_RetrievePeripherals =                          "Tag_CentralManager_RetrievePeripherals"
public let SF_Tag_CentralManager_RetrieveConnectedPeripherals =                 "Tag_CentralManager_RetrieveConnectedPeripherals"
public let SF_Tag_CentralManager_Scan_Start =                                   "Tag_CentralManager_Scan_Start"
public let SF_Tag_CentralManager_Scan_Stop =                                    "Tag_CentralManager_Scan_Stop"
public let SF_Tag_CentralManager_DidDiscoverPeripheral =                        "Tag_CentralManager_DidDiscoverPeripheral"
public let SF_Tag_CentralManager_ConnectPeripheral_Start =                      "Tag_CentralManager_ConnectPeripheral_Start"
public let SF_Tag_CentralManager_ConnectPeripheral_Success =                    "Tag_CentralManager_ConnectPeripheral_Success"
public let SF_Tag_CentralManager_ConnectPeripheral_Failure =                    "Tag_CentralManager_ConnectPeripheral_Failure"
public let SF_Tag_CentralManager_DisconnectPeripheral_Start =                   "Tag_CentralManager_DisconnectPeripheral_Start"
public let SF_Tag_CentralManager_DisconnectPeripheral_Success =                 "Tag_CentralManager_DisconnectPeripheral_Success"
public let SF_Tag_CentralManager_DisconnectPeripheralAutoReconnect_Success =    "Tag_CentralManager_DisconnectPeripheralAutoReconnect_Success"
public let SF_Tag_CentralManager_ConnectionEvents_Register =                    "Tag_CentralManager_ConnectionEvents_Register"
public let SF_Tag_CentralManager_ConnectionEvents_Occur =                       "Tag_CentralManager_ConnectionEvents_Occur"

// MARK: - SFBleCentralManagerLogOption
public struct SFBleCentralManagerLogOption: OptionSet {
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let isScanningDidChanged =                        SFBleCentralManagerLogOption(rawValue: 1 << 0)
    public static let stateDidUpdated =                             SFBleCentralManagerLogOption(rawValue: 1 << 1)
    public static let ANCSAuthorizationDidUpdated =                 SFBleCentralManagerLogOption(rawValue: 1 << 2)
    public static let willRestoreState =                            SFBleCentralManagerLogOption(rawValue: 1 << 3)
    public static let retrievePeripherals =                         SFBleCentralManagerLogOption(rawValue: 1 << 4)
    public static let retrieveConnectedPeripherals =                SFBleCentralManagerLogOption(rawValue: 1 << 5)
    public static let scanStart =                                   SFBleCentralManagerLogOption(rawValue: 1 << 6)
    public static let scanStop =                                    SFBleCentralManagerLogOption(rawValue: 1 << 7)
    public static let didDiscoverPeripheral =                       SFBleCentralManagerLogOption(rawValue: 1 << 8)
    public static let connectPeripheralStart =                      SFBleCentralManagerLogOption(rawValue: 1 << 9)
    public static let connectPeripheralSuccess =                    SFBleCentralManagerLogOption(rawValue: 1 << 10)
    public static let connectPeripheralFailure =                    SFBleCentralManagerLogOption(rawValue: 1 << 11)
    public static let disconnectPeripheralStart =                   SFBleCentralManagerLogOption(rawValue: 1 << 12)
    public static let disconnectPeripheralSuccess =                 SFBleCentralManagerLogOption(rawValue: 1 << 13)
    public static let disconnectPeripheralAutoReconnectSuccess =    SFBleCentralManagerLogOption(rawValue: 1 << 14)
    public static let connectionEventsRegister =                    SFBleCentralManagerLogOption(rawValue: 1 << 15)
    public static let connectionEventsOccur =                       SFBleCentralManagerLogOption(rawValue: 1 << 16)
    
    public static let all: SFBleCentralManagerLogOption = [.isScanningDidChanged, .stateDidUpdated, .ANCSAuthorizationDidUpdated, .willRestoreState, .retrievePeripherals, .retrieveConnectedPeripherals, .scanStart, .scanStop, .didDiscoverPeripheral, .connectPeripheralStart, .connectPeripheralSuccess, .connectPeripheralFailure, .disconnectPeripheralStart, .disconnectPeripheralSuccess, .disconnectPeripheralAutoReconnectSuccess, .connectionEventsRegister, .connectionEventsOccur]
}


// MARK: - SFBleCentralManager
public class SFBleCentralManager: NSObject, SFBleProtocol {
    // MARK: var
    public var id: UUID?
    public private(set) var centralManager: CBCentralManager!
    public var logOption: SFBleCentralManagerLogOption = .all
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
                // log
                if logOption.contains(.isScanningDidChanged) {
                    let msg_centralManager = "centralManager=\(centralManager.sf.description)"
                    let msg_isScanning = "isScanning=\(isScanning)"
                    logCallback(tag: SF_Tag_CentralManager_IsScanning_DidUpdated,
                           msgs: [msg_centralManager, msg_isScanning])
                }
                
                // notify
                var userInfo = [String: Any]()
                userInfo["centralManager"] = centralManager
                userInfo["isScanning"] = isScanning
                NotificationCenter.default.post(name: SF_Notify_CentralManager_Callback_IsScanning_DidUpdated, object: nil, userInfo: userInfo)
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
        // log
        if logOption.contains(.retrievePeripherals) {
            let msg_centralManager = "centralManager=\(centralManager.sf.description)"
            var msg_identifiers = "identifiers=["
            for identifier in identifiers {
                msg_identifiers.append(identifier.uuidString)
            }
            msg_identifiers.append("]")
            var msg_peripherals = "peripherals=["
            for peripheral in peripherals {
                msg_peripherals.append(peripheral.sf.description)
            }
            msg_peripherals.append("]")
            logTry(tag: SF_Tag_CentralManager_RetrievePeripherals,
                   msgs: [msg_centralManager, msg_identifiers],
                   result: msg_peripherals)
        }
        return peripherals
    }
    
    /// 检索已连接的外设
    public func retrieveConnectedPeripherals(id: UUID, services: [CBUUID]) -> [CBPeripheral] {
        // do
        self.id = id
        let peripherals = centralManager.retrieveConnectedPeripherals(withServices: services)
        // log
        if logOption.contains(.retrieveConnectedPeripherals) {
            let msg_centralManager = "centralManager=\(centralManager.sf.description)"
            var msg_services = "services=["
            for service in services {
                msg_services.append(service.uuidString)
            }
            msg_services.append("]")
            var msg_peripherals = "peripherals=["
            for peripheral in peripherals {
                msg_peripherals.append(peripheral.sf.description)
            }
            msg_peripherals.append("]")
            logTry(tag: SF_Tag_CentralManager_RetrieveConnectedPeripherals,
                   msgs: [msg_centralManager, msg_services],
                   result: msg_peripherals)
        }
        return peripherals
    }
    
    /// 开始扫描
    public func scanForPeripherals(id: UUID, services: [CBUUID]?, options: [String: Any]?) {
        // do
        self.id = id
        centralManager.scanForPeripherals(withServices: services, options: options)
        // log
        if logOption.contains(.scanStart) {
            let msg_centralManager = "centralManager=\(centralManager.sf.description)"
            var msg_services = "services=nil"
            if let services = services {
                msg_services = "services=["
                for service in services {
                    msg_services.append(service.uuidString)
                }
                msg_services.append("]")
            }
            var msg_options = "options=nil"
            if let options = options {
                msg_options = "options=\(options)"
            }
            logTry(tag: SF_Tag_CentralManager_Scan_Start,
                   msgs: [msg_centralManager, msg_services, msg_options],
                   result: nil)
        }
    }
    
    /// 停止扫描
    public func stopScan(id: UUID) {
        // do
        self.id = id
        centralManager.stopScan()
        // log
        if logOption.contains(.scanStop) {
            let msg_centralManager = "centralManager=\(centralManager.sf.description)"
            logTry(tag: SF_Tag_CentralManager_Scan_Stop,
                   msgs: [msg_centralManager, ],
                   result: nil)
        }
    }
    
    /// 连接外设
    public func connect(id: UUID, peripheral: CBPeripheral, options: [String: Any]?) {
        // do
        self.id = id
        centralManager.connect(peripheral, options: options)
        // log
        if logOption.contains(.connectPeripheralStart) {
            let msg_centralManager = "centralManager=\(centralManager.sf.description)"
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            var msg_options = "options=nil"
            if let options = options {
                msg_options = "options=\(options)"
            }
            logTry(tag: SF_Tag_CentralManager_ConnectPeripheral_Start,
                   msgs: [msg_centralManager, msg_peripheral, msg_options],
                   result: nil)
        }
    }
    
    /// 断开外设
    public func disconnect(id: UUID, peripheral: CBPeripheral) {
        // do
        self.id = id
        centralManager.cancelPeripheralConnection(peripheral)
        // log
        if logOption.contains(.disconnectPeripheralStart) {
            let msg_centralManager = "centralManager=\(centralManager.sf.description)"
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            logTry(tag: SF_Tag_CentralManager_DisconnectPeripheral_Start,
                   msgs: [msg_centralManager, msg_peripheral],
                   result: nil)
        }
    }
    
    /// 注册连接事件
    @available(iOS 13.0, *)
    public func registerForConnectionEvents(id: UUID, options: [CBConnectionEventMatchingOption : Any]?) {
        // do
        self.id = id
        centralManager.registerForConnectionEvents(options: options)
        // log
        if logOption.contains(.connectionEventsRegister) {
            let msg_centralManager = "centralManager=\(centralManager.sf.description)"
            var msg_options = "options=nil"
            if let options = options {
                msg_options = "options=\(options)"
            }
            logTry(tag: SF_Tag_CentralManager_ConnectionEvents_Register,
                   msgs: [msg_centralManager, msg_options],
                   result: nil)
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
        // log
        if logOption.contains(.stateDidUpdated) {
            let msg_centralManager = "centralManager=\(centralManager.sf.description)"
            logCallback(tag: SF_Tag_CentralManager_State_DidUpdated,
                        msgs: [msg_centralManager, ])
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["centralManager"] = centralManager
        NotificationCenter.default.post(name: SF_Notify_CentralManager_Callback_State_DidUpdated, object: nil, userInfo: userInfo)
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
        // log
        if logOption.contains(.stateDidUpdated) {
            let msg_centralManager = "centralManager=\(centralManager.sf.description)"
            let msg_dict = "dict=\(dict)"
            logCallback(tag: SF_Tag_CentralManager_WillRestoreState,
                        msgs: [msg_centralManager, msg_dict])
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
        // log
        if logOption.contains(.didDiscoverPeripheral) {
            let msg_centralManager = "centralManager=\(centralManager.sf.description)"
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_advertisementData = "advertisementData=\(advertisementData)"
            let msg_RSSI = "RSSI=\(RSSI)"
            logCallback(tag: SF_Tag_CentralManager_DidDiscoverPeripheral,
                        msgs: [msg_centralManager, msg_peripheral, msg_advertisementData, msg_RSSI])
            
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
        // log
        if logOption.contains(.connectPeripheralSuccess) {
            let msg_centralManager = "centralManager=\(centralManager.sf.description)"
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            logCallback(tag: SF_Tag_CentralManager_ConnectPeripheral_Success,
                        msgs: [msg_centralManager, msg_peripheral])
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["centralManager"] = centralManager
        userInfo["peripheral"] = peripheral
        NotificationCenter.default.post(name: SF_Notify_CentralManager_Callback_ConnectPeripheral_Success, object: nil, userInfo: userInfo)
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
        // log
        if logOption.contains(.connectPeripheralFailure) {
            let msg_centralManager = "centralManager=\(centralManager.sf.description)"
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            logCallback(tag: SF_Tag_CentralManager_ConnectPeripheral_Failure,
                        msgs: [msg_centralManager, msg_peripheral, msg_error])
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["centralManager"] = centralManager
        userInfo["peripheral"] = peripheral
        if let error = error {
            userInfo["error"] = error
        }
        NotificationCenter.default.post(name: SF_Notify_CentralManager_Callback_ConnectPeripheral_Failure, object: nil, userInfo: userInfo)
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
        // log
        if logOption.contains(.disconnectPeripheralSuccess) {
            let msg_centralManager = "centralManager=\(centralManager.sf.description)"
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            logCallback(tag: SF_Tag_CentralManager_DisconnectPeripheral_Success,
                        msgs: [msg_centralManager, msg_peripheral, msg_error])
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["centralManager"] = centralManager
        userInfo["peripheral"] = peripheral
        if let error = error {
            userInfo["error"] = error
        }
        NotificationCenter.default.post(name: SF_Notify_CentralManager_Callback_DisconnectPeripheral_Success, object: nil, userInfo: userInfo)
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
        // log
        if logOption.contains(.disconnectPeripheralAutoReconnectSuccess) {
            let msg_centralManager = "centralManager=\(centralManager.sf.description)"
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_timestamp = "timestamp=\(timestamp)"
            let msg_isReconnecting = "isReconnecting=\(isReconnecting)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            logCallback(tag: SF_Tag_CentralManager_DisconnectPeripheralAutoReconnect_Success,
                        msgs: [msg_centralManager, msg_peripheral, msg_timestamp, msg_isReconnecting, msg_error])
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
        NotificationCenter.default.post(name: SF_Notify_CentralManager_Callback_DisconnectPeripheralAutoReconnect_Success, object: nil, userInfo: userInfo)
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
        // log
        if logOption.contains(.connectionEventsOccur) {
            let msg_centralManager = "centralManager=\(centralManager.sf.description)"
            let msg_event = "event=\(event.sf.description)"
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            logCallback(tag: SF_Tag_CentralManager_ConnectionEvents_Occur,
                        msgs: [msg_centralManager, msg_event, msg_peripheral])
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["centralManager"] = centralManager
        userInfo["event"] = event
        userInfo["peripheral"] = peripheral
        NotificationCenter.default.post(name: SF_Notify_CentralManager_Callback_ConnectionEvents_Occur, object: nil, userInfo: userInfo)
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
        // log
        if logOption.contains(.ANCSAuthorizationDidUpdated) {
            let msg_centralManager = "centralManager=\(centralManager.sf.description)"
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            logCallback(tag: SF_Tag_CentralManager_ANCSAuthorization_DidUpdated,
                        msgs: [msg_centralManager, msg_peripheral])
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["centralManager"] = centralManager
        userInfo["peripheral"] = peripheral
        NotificationCenter.default.post(name: SF_Notify_CentralManager_Callback_ANCSAuthorization_DidUpdated, object: nil, userInfo: userInfo)
    }
}


