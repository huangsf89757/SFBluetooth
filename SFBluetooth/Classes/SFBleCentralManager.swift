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

// MARK: - Tag
public let SF_Tag_CentralManager_IsScanning_DidChanged =                        "SF_Tag_CentralManager_IsScanning_DidChanged"
public let SF_Tag_CentralManager_State_DidUpdated =                             "SF_Tag_CentralManager_State_DidUpdated"
public let SF_Tag_CentralManager_ANCSAuthorization_DidUpdated =                 "SF_Tag_CentralManager_ANCSAuthorization_DidUpdated"

public let SF_Tag_CentralManager_WillRestoreState =                             "SF_Tag_CentralManager_WillRestoreState"
public let SF_Tag_CentralManager_RetrievePeripherals =                          "SF_Tag_CentralManager_RetrievePeripherals"
public let SF_Tag_CentralManager_RetrieveConnectedPeripherals =                 "SF_Tag_CentralManager_RetrieveConnectedPeripherals"

public let SF_Tag_CentralManager_Scan_Start =                                   "SF_Tag_CentralManager_Scan_Start"
public let SF_Tag_CentralManager_Scan_Stop =                                    "SF_Tag_CentralManager_Scan_Stop"
public let SF_Tag_CentralManager_DidDiscoverPeripheral =                        "SF_Tag_CentralManager_DidDiscoverPeripheral"

public let SF_Tag_CentralManager_ConnectPeripheral_Start =                      "SF_Tag_CentralManager_ConnectPeripheral_Start"
public let SF_Tag_CentralManager_ConnectPeripheral_Success =                    "SF_Tag_CentralManager_ConnectPeripheral_Success"
public let SF_Tag_CentralManager_ConnectPeripheral_Failure =                    "SF_Tag_CentralManager_ConnectPeripheral_Failure"

public let SF_Tag_CentralManager_DisconnectPeripheral_Start =                   "SF_Tag_CentralManager_DisconnectPeripheral_Start"
public let SF_Tag_CentralManager_DisconnectPeripheral_Success =                 "SF_Tag_CentralManager_DisconnectPeripheral_Success"
public let SF_Tag_CentralManager_DisconnectPeripheralAutoReconnect_Success =    "SF_Tag_CentralManager_DisconnectPeripheralAutoReconnect_Success"

public let SF_Tag_CentralManager_ConnectionEvents_Register =                    "SF_Tag_CentralManager_ConnectionEvents_Register"
public let SF_Tag_CentralManager_ConnectionEvents_Occur =                       "SF_Tag_CentralManager_ConnectionEvents_Occur"


// MARK: - Notify
public let SF_Notify_CentralManager_IsScanning_DidChanged =                     NSNotification.Name("SF_Notify_CentralManager_IsScanning_DidChanged")
public let SF_Notify_CentralManager_State_DidUpdated =                          NSNotification.Name("SF_Notify_CentralManager_State_DidUpdated")
public let SF_Notify_CentralManager_ANCSAuthorization_DidUpdated =              NSNotification.Name("SF_Notify_CentralManager_ANCSAuthorization_DidUpdated")

public let SF_Notify_CentralManager_WillRestoreState =                          NSNotification.Name("SF_Notify_CentralManager_WillRestoreState")
public let SF_Notify_CentralManager_RetrievePeripherals =                       NSNotification.Name("SF_Notify_CentralManager_RetrievePeripherals")
public let SF_Notify_CentralManager_RetrieveConnectedPeripherals =              NSNotification.Name("SF_Notify_CentralManager_RetrieveConnectedPeripherals")

public let SF_Notify_CentralManager_Scan_Start =                                NSNotification.Name("SF_Notify_CentralManager_Scan_Start")
public let SF_Notify_CentralManager_Scan_Stop =                                 NSNotification.Name("SF_Notify_CentralManager_Scan_Stop")
public let SF_Notify_CentralManager_DidDiscoverPeripheral =                     NSNotification.Name("SF_Notify_CentralManager_DidDiscoverPeripheral")

public let SF_Notify_CentralManager_ConnectPeripheral_Start =                   NSNotification.Name("SF_Notify_CentralManager_ConnectPeripheral_Start")
public let SF_Notify_CentralManager_ConnectPeripheral_Success =                 NSNotification.Name("SF_Notify_CentralManager_ConnectPeripheral_Success")
public let SF_Notify_CentralManager_ConnectPeripheral_Failure =                 NSNotification.Name("SF_Notify_CentralManager_ConnectPeripheral_Failure")

public let SF_Notify_CentralManager_DisconnectPeripheral_Start =                NSNotification.Name("SF_Notify_CentralManager_DisconnectPeripheral_Start")
public let SF_Notify_CentralManager_DisconnectPeripheral_Success =              NSNotification.Name("SF_Notify_CentralManager_DisconnectPeripheral_Success")
public let SF_Notify_CentralManager_DisconnectPeripheralAutoReconnect_Success = NSNotification.Name("SF_Notify_CentralManager_DisconnectPeripheralAutoReconnect_Success")

public let SF_Notify_CentralManager_ConnectionEvents_Register =                 NSNotification.Name("SF_Notify_CentralManager_ConnectionEvents_Register")
public let SF_Notify_CentralManager_ConnectionEvents_Occur =                    NSNotification.Name("SF_Notify_CentralManager_ConnectionEvents_Occur")


// MARK: - SFCentralManagerLogOption
public struct SFCentralManagerLogOption: OptionSet {
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let isScanningDidChanged = SFCentralManagerLogOption(rawValue: 1 << 0)
    public static let stateDidUpdated = SFCentralManagerLogOption(rawValue: 1 << 1)
    public static let ANCSAuthorizationDidUpdated = SFCentralManagerLogOption(rawValue: 1 << 2)
    
    public static let willRestoreState = SFCentralManagerLogOption(rawValue: 1 << 3)
    public static let retrievePeripherals = SFCentralManagerLogOption(rawValue: 1 << 4)
    public static let retrieveConnectedPeripherals = SFCentralManagerLogOption(rawValue: 1 << 5)
    
    public static let scanStart = SFCentralManagerLogOption(rawValue: 1 << 6)
    public static let scanStop = SFCentralManagerLogOption(rawValue: 1 << 7)
    public static let didDiscoverPeripheral = SFCentralManagerLogOption(rawValue: 1 << 8)
    
    public static let connectPeripheralStart = SFCentralManagerLogOption(rawValue: 1 << 9)
    public static let connectPeripheralSuccess = SFCentralManagerLogOption(rawValue: 1 << 10)
    public static let connectPeripheralFailure = SFCentralManagerLogOption(rawValue: 1 << 11)
    
    public static let disconnectPeripheralStart = SFCentralManagerLogOption(rawValue: 1 << 12)
    public static let disconnectPeripheralSuccess = SFCentralManagerLogOption(rawValue: 1 << 13)
    public static let disconnectPeripheralAutoReconnectSuccess = SFCentralManagerLogOption(rawValue: 1 << 14)
    
    public static let connectionEventsRegister = SFCentralManagerLogOption(rawValue: 1 << 15)
    public static let connectionEventsOccur = SFCentralManagerLogOption(rawValue: 1 << 16)
    
    // Combine all options into a single option for convenience
    public static let all: SFCentralManagerLogOption = [
        .isScanningDidChanged,
        .stateDidUpdated,
        .ANCSAuthorizationDidUpdated,
        .willRestoreState,
        .retrievePeripherals,
        .retrieveConnectedPeripherals,
        .scanStart,
        .scanStop,
        .didDiscoverPeripheral,
        .connectPeripheralStart,
        .connectPeripheralSuccess,
        .connectPeripheralFailure,
        .disconnectPeripheralStart,
        .disconnectPeripheralSuccess,
        .disconnectPeripheralAutoReconnectSuccess,
        .connectionEventsRegister,
        .connectionEventsOccur
    ]
}


// MARK: - SFBleCentralManager
public class SFBleCentralManager: NSObject {
    // MARK: var
    public private(set) var centralManager: CBCentralManager!
    public var logOption: SFCentralManagerLogOption = .all
    public private(set) lazy var discoverLogger: SFDiscoveryLogger = {
        return SFDiscoveryLogger()
    }()
    public var id: String?
    
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
                    let msg_tag = SF_Tag_CentralManager_IsScanning_DidChanged
                    let msg_central = "central=\(centralManager.sf.description)"
                    let msg_isScanning = "isScanning=\(isScanning)"
                    let msgs = [msg_tag, msg_central, msg_isScanning].joined(separator: "\n")
                    Log.info("\n\(msgs)\n")
                }
                // notify
                var userInfo = [String: Any]()
                userInfo["central"] = centralManager
                userInfo["isScanning"] = isScanning
                NotificationCenter.default.post(name: SF_Notify_CentralManager_IsScanning_DidChanged, object: nil, userInfo: userInfo)
                return
            }
            return
        }
    }
}

// MARK: - log
extension SFBleCentralManager {
    enum SFLogMedthod {
        case immediate
        case waiting
        
        var description: String {
            switch self {
            case .immediate:
                return "immediate"
            case .waiting:
                return "waiting"
            }
        }
    }
    // 通用的日志记录函数
    private func logOperation(option: SFCentralManagerLogOption, id: String, tag: String, params: [String: String], isSuccess: Bool, medthod: SFLogMedthod, result: String? = nil) {
        guard logOption.contains(option) else { return }
        // id
        let msg_id = "ID: \(id)"
        // try
        var msg_try = """
        Try:
            \(tag)
            central=\(centralManager.sf.description)
        """
        if params.count > 0 {
            msg_try += "\n\(params.map { "    \($0.key)=\($0.value)" }.joined(separator: "\n"))"
        }
        // result
        let msg_result = """
        Result:
            \(isSuccess ? "Success" : "Failure\nID: \(self.id) is in process")
        """
        // callback
        var msg_callback = """
        Return:
            \(medthod.description)
        """
        if let result = result {
            msg_callback += "\n\(result)"
        }
        // msg
        var msg = msg_id + "\n" + msg_try + "\n" + msg_result + "\n"
        if isSuccess {
            msg += msg_callback + "\n"
        }
        msg += "End"
        Log.info("\n\(msg)\n")
    }
    
    // 通用的操作执行函数
    private func executeOperation<T>(id: String, operation: () -> T) -> (isSuccess: Bool, result: T?) {
        if self.id != nil {
            return (false, nil)
        } else {
            let result = operation()
            return (true, result)
        }
    }
}


// MARK: - func
extension SFBleCentralManager {
    /// 检索外设
    public func retrievePeripherals(id: String, identifiers: [UUID]) -> [CBPeripheral] {
        // do
        let (isSuccess, result) = executeOperation(id: id) {
            return centralManager.retrievePeripherals(withIdentifiers: identifiers)
        }
        let peripherals = result ?? []
        // log
        var msg_peripherals = "peripherals=["
        for peripheral in peripherals {
            msg_peripherals.append(peripheral.sf.description)
        }
        msg_peripherals.append("]")
        logOperation(option: .retrievePeripherals,
                     id: id,
                     tag: SF_Tag_CentralManager_RetrievePeripherals,
                     params: ["identifiers": identifiers.description],
                     isSuccess: isSuccess, 
                     medthod: .immediate,
                     result: msg_peripherals)
        // notify
        var userInfo = [String: Any]()
        userInfo["isSuccess"] = isSuccess
        userInfo["central"] = centralManager
        userInfo["identifiers"] = identifiers
        userInfo["peripherals"] = peripherals
        NotificationCenter.default.post(name: SF_Notify_CentralManager_RetrievePeripherals, object: nil, userInfo: userInfo)
        return peripherals
    }
    
    /// 检索已连接的外设
    public func retrieveConnectedPeripherals(id: String, services: [CBUUID]) -> [CBPeripheral] {
        // do
        let (isSuccess, result) = executeOperation(id: id) {
            return centralManager.retrieveConnectedPeripherals(withServices: services)
        }
        let peripherals = result ?? []
        // log
        var msg_peripherals = "peripherals=["
        for peripheral in peripherals {
            msg_peripherals.append(peripheral.sf.description)
        }
        msg_peripherals.append("]")
        logOperation(option: .retrieveConnectedPeripherals,
                     id: id,
                     tag: SF_Tag_CentralManager_RetrieveConnectedPeripherals,
                     params: ["services": services.description],
                     isSuccess: isSuccess,
                     medthod: .immediate,
                     result: msg_peripherals)
        // notify
        var userInfo = [String: Any]()
        userInfo["isSuccess"] = isSuccess
        userInfo["central"] = centralManager
        userInfo["services"] = services
        userInfo["peripherals"] = peripherals
        NotificationCenter.default.post(name: SF_Notify_CentralManager_RetrieveConnectedPeripherals, object: nil, userInfo: userInfo)
        return peripherals
    }
    
    /// 开始扫描
    public func scanForPeripherals(id: String, services: [CBUUID]?, options: [String: Any]?) {
        // do
        let (isSuccess, result) = executeOperation(id: id) {
            centralManager.scanForPeripherals(withServices: services, options: options)
            return true
        }
        // log
        logOperation(option: .scanStart,
                     id: id,
                     tag: SF_Tag_CentralManager_Scan_Start,
                     params: ["services": services?.description ?? "nil", "options": options?.description ?? "nil"],
                     isSuccess: isSuccess,
                     medthod: .immediate)
        // notify
        var userInfo = [String: Any]()
        userInfo["isSuccess"] = isSuccess
        userInfo["central"] = centralManager
        if let services = services {
            userInfo["services"] = services
        }
        if let options = options {
            userInfo["options"] = options
        }
        NotificationCenter.default.post(name: SF_Notify_CentralManager_Scan_Start, object: nil, userInfo: userInfo)
    }
    
    /// 停止扫描
    public func stopScan(id: String) {
        // do
        let (isSuccess, result) = executeOperation(id: id) {
            centralManager.stopScan()
            return true
        }
        // log
        logOperation(option: .scanStop,
                     id: id,
                     tag: SF_Tag_CentralManager_Scan_Stop,
                     params: [:],
                     isSuccess: isSuccess,
                     medthod: .immediate)
        // notify
        var userInfo = [String: Any]()
        userInfo["isSuccess"] = isSuccess
        userInfo["central"] = centralManager
        NotificationCenter.default.post(name: SF_Notify_CentralManager_Scan_Stop, object: nil, userInfo: userInfo)
    }
    
    /// 连接外设
    public func connect(id: String, peripheral: CBPeripheral, options: [String: Any]?) {
        // do
        let (isSuccess, result) = executeOperation(id: id) {
            centralManager.connect(peripheral, options: options)
            return true
        }
        // log
        logOperation(option: .connectPeripheralStart,
                     id: id,
                     tag: SF_Tag_CentralManager_ConnectPeripheral_Start,
                     params: ["peripheral": peripheral.sf.description, "options": options?.description ?? "nil"],
                     isSuccess: isSuccess,
                     medthod: .immediate)
        // notify
        var userInfo = [String: Any]()
        userInfo["isSuccess"] = isSuccess
        userInfo["central"] = centralManager
        userInfo["peripheral"] = peripheral
        if let options = options {
            userInfo["options"] = options
        }
        NotificationCenter.default.post(name: SF_Notify_CentralManager_ConnectPeripheral_Start, object: nil, userInfo: userInfo)
    }
    
    /// 断开外设
    public func cancel(id: String, peripheral: CBPeripheral) {
        // do
        let (isSuccess, result) = executeOperation(id: id) {
            centralManager.cancelPeripheralConnection(peripheral)
            return true
        }
        // log
        logOperation(option: .disconnectPeripheralStart,
                     id: id,
                     tag: SF_Tag_CentralManager_DisconnectPeripheral_Start,
                     params: ["peripheral": peripheral.sf.description],
                     isSuccess: isSuccess,
                     medthod: .immediate)
        // notify
        var userInfo = [String: Any]()
        userInfo["isSuccess"] = isSuccess
        userInfo["central"] = centralManager
        userInfo["peripheral"] = peripheral
        NotificationCenter.default.post(name: SF_Notify_CentralManager_DisconnectPeripheral_Start, object: nil, userInfo: userInfo)
    }
    
    /// 注册连接事件
    @available(iOS 13.0, *)
    public func registerForConnectionEvents(id: String,     options: [CBConnectionEventMatchingOption : Any]?) {
        // do
        let (isSuccess, result) = executeOperation(id: id) {
            centralManager.registerForConnectionEvents(options: options)
            return true
        }
        // log
        logOperation(option: .connectionEventsRegister,
                     id: id,
                     tag: SF_Tag_CentralManager_ConnectionEvents_Register,
                     params: ["options": options?.description ?? "nil"],
                     isSuccess: isSuccess,
                     medthod: .immediate)
        // notify
        var userInfo = [String: Any]()
        userInfo["isSuccess"] = isSuccess
        userInfo["central"] = centralManager
        if let options = options {
            userInfo["options"] = options
        }
        NotificationCenter.default.post(name: SF_Notify_CentralManager_ConnectionEvents_Register, object: nil, userInfo: userInfo)
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
            let msg_tag = SF_Tag_CentralManager_State_DidUpdated
            let msg_central = "central=\(central.sf.description)"
            let msgs = [msg_tag, msg_central].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["central"] = centralManager
        NotificationCenter.default.post(name: SF_Notify_CentralManager_State_DidUpdated, object: nil, userInfo: userInfo)
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
        if logOption.contains(.willRestoreState) {
            let msg_tag = SF_Tag_CentralManager_WillRestoreState
            let msg_central = "central=\(central.sf.description)"
            let msg_dict = "dict=\(dict)"
            let msgs = [msg_tag, msg_central, msg_dict].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["central"] = centralManager
        userInfo["dict"] = dict
        NotificationCenter.default.post(name: SF_Notify_CentralManager_WillRestoreState, object: nil, userInfo: userInfo)
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
            let msg_tag = SF_Tag_CentralManager_DidDiscoverPeripheral
            let msg_central = "central=\(central.sf.description)"
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_advertisementData = "advertisementData=\(advertisementData)"
            let msg_RSSI = "RSSI=\(RSSI)"
            let msgs = [msg_tag, msg_central, msg_peripheral, msg_advertisementData, msg_RSSI].joined(separator: "\n")
            //            Log.info("\n\(msgs)\n")
            self.discoverLogger.log(peripheral: peripheral, RSSI: RSSI, msg: "\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["central"] = centralManager
        userInfo["peripheral"] = peripheral
        userInfo["advertisementData"] = advertisementData
        userInfo["RSSI"] = RSSI
        NotificationCenter.default.post(name: SF_Notify_CentralManager_DidDiscoverPeripheral, object: nil, userInfo: userInfo)
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
        
        //        """
        //        【连接回调】
        //        成功示例：
        //        2024/10/16 12:12:12.789 +12 [E] file func line
        //        Callback:
        //            SF_Tag_CentralManager_ConnectPeripheral_Success
        //            ID: SFSD44389S0JHK76T6Y
        //            central=xxx
        //            peripheral=xxx
        //        End
        //
        //
        //        失败示例：
        //        2024/10/16 12:12:12.789 +12 [E] file func line
        //        Callback:
        //            SF_Tag_CentralManager_ConnectPeripheral_Failure
        //            ID: SFSD44389S0JHK76T6Y
        //            central=xxx
        //            peripheral=xxx
        //            error=nil
        //        End
        //        """
        
        // log
        if logOption.contains(.connectPeripheralSuccess) {
            let msg_tag = SF_Tag_CentralManager_ConnectPeripheral_Success
            let msg_central = "central=\(central.sf.description)"
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msgs = [msg_tag, msg_central, msg_peripheral].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["central"] = centralManager
        userInfo["peripheral"] = peripheral
        NotificationCenter.default.post(name: SF_Notify_CentralManager_ConnectPeripheral_Success, object: nil, userInfo: userInfo)
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
            let msg_tag = SF_Tag_CentralManager_ConnectPeripheral_Failure
            let msg_central = "central=\(central.sf.description)"
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            let msgs = [msg_tag, msg_central, msg_peripheral, msg_error].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["central"] = centralManager
        userInfo["peripheral"] = peripheral
        if let error = error {
            userInfo["error"] = error
        }
        NotificationCenter.default.post(name: SF_Notify_CentralManager_ConnectPeripheral_Failure, object: nil, userInfo: userInfo)
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
            let msg_tag = SF_Tag_CentralManager_DisconnectPeripheral_Success
            let msg_central = "central=\(central.sf.description)"
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            let msgs = [msg_tag, msg_central, msg_peripheral, msg_error].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["central"] = centralManager
        userInfo["peripheral"] = peripheral
        if let error = error {
            userInfo["error"] = error
        }
        NotificationCenter.default.post(name: SF_Notify_CentralManager_DisconnectPeripheral_Success, object: nil, userInfo: userInfo)
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
            let msg_tag = SF_Tag_CentralManager_DisconnectPeripheralAutoReconnect_Success
            let msg_central = "central=\(central.sf.description)"
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_timestamp = "timestamp=\(timestamp)"
            let msg_isReconnecting = "isReconnecting=\(isReconnecting)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            let msgs = [msg_tag, msg_central, msg_peripheral, msg_timestamp, msg_isReconnecting, msg_error].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["central"] = centralManager
        userInfo["peripheral"] = peripheral
        userInfo["timestamp"] = timestamp
        userInfo["isReconnecting"] = isReconnecting
        if let error = error {
            userInfo["error"] = error
        }
        NotificationCenter.default.post(name: SF_Notify_CentralManager_DisconnectPeripheralAutoReconnect_Success, object: nil, userInfo: userInfo)
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
            let msg_tag = SF_Tag_CentralManager_ConnectionEvents_Occur
            let msg_central = "central=\(central.sf.description)"
            let msg_event = "event=\(event.sf.description)"
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msgs = [msg_tag, msg_central, msg_event, msg_peripheral].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["central"] = centralManager
        userInfo["event"] = event
        userInfo["peripheral"] = peripheral
        NotificationCenter.default.post(name: SF_Notify_CentralManager_ConnectionEvents_Occur, object: nil, userInfo: userInfo)
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
            let msg_tag = SF_Tag_CentralManager_ANCSAuthorization_DidUpdated
            let msg_central = "central=\(central.sf.description)"
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msgs = [msg_tag, msg_central, msg_peripheral].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["central"] = centralManager
        userInfo["peripheral"] = peripheral
        NotificationCenter.default.post(name: SF_Notify_CentralManager_ANCSAuthorization_DidUpdated, object: nil, userInfo: userInfo)
    }
}


