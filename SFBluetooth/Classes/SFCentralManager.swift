//
//  SFCentralManager.swift
//  SFBluetooth
//
//  Created by hsf on 2024/8/20.
//

import Foundation
import CoreBluetooth
// Server
import SFLogger

// MARK: - SFCentralManager
public class SFCentralManager: NSObject {
    // MARK: var
    public private(set) var centralManager: CBCentralManager!
    public var isLogEnable = true
    
    // MARK: block
    public var didChangedIsScanningBlock: ((CBCentralManager, Bool) -> ())?
    public var didUpdateStateBlock: ((CBCentralManager) -> ())?
    public var willRestoreStateBlock: ((CBCentralManager, [String : Any]) -> ())?
    public var didDiscoverPeripheralBlock: ((CBCentralManager, CBPeripheral, [String : Any], NSNumber) -> ())?
    public var didConnectPeripheralBlock: ((CBCentralManager, CBPeripheral) -> ())?
    public var didFailToConnectPeripheralBlock: ((CBCentralManager, CBPeripheral, (any Error)?) -> ())?
    public var didDisconnectPeripheralBlock: ((CBCentralManager, CBPeripheral, (any Error)?) -> ())?
    public var didDisconnectPeripheralAutoReconnectBlock: ((CBCentralManager, CBPeripheral, CFAbsoluteTime, Bool, (any Error)?) -> ())?
    public var connectionEventDidOccurBlock: ((CBCentralManager, CBConnectionEvent, CBPeripheral) -> ())?
    public var didUpdateANCSAuthorizationForPeripheralBlock: ((CBCentralManager, CBPeripheral) -> ())?
    
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
extension SFCentralManager {
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let centralManager = object as? CBCentralManager, centralManager == self.centralManager {
            if keyPath == "isScanning", let isScanning = change?[.newKey] as? Bool {
                if isLogEnable {
                    Log.info("central=\(centralManager) isScanning=\(isScanning)")
                }
                didChangedIsScanningBlock?(centralManager, isScanning)
                return
            }
            return
        }
    }
}

// MARK: - func
extension SFCentralManager {
    /// 检索外设
    public func retrievePeripherals(identifiers: [UUID]) -> [CBPeripheral] {
        let peripherals = centralManager.retrievePeripherals(withIdentifiers: identifiers)
        if isLogEnable {
            Log.info("central=\(centralManager) identifiers=\(identifiers) [return] peripherals=\(peripherals)")
        }
        return peripherals
    }
    
    /// 检索已连接的外设
    public func retrieveConnectedPeripherals(services: [CBUUID]) -> [CBPeripheral] {
        let peripherals = centralManager.retrieveConnectedPeripherals(withServices: services)
        if isLogEnable {
            Log.info("central=\(centralManager) services=\(services) [return] peripherals=\(peripherals)")
        }
        return peripherals
    }
    
    /// 开始扫描
    public func scanForPeripherals(services: [CBUUID]?, options: [String: Any]?) {
        centralManager.scanForPeripherals(withServices: services, options: options)
        if isLogEnable {
            Log.info("central=\(centralManager) services=\(services) options=\(options)")
        }
    }
    
    /// 停止扫描
    public func stopScan() {
        centralManager.stopScan()
        if isLogEnable {
            Log.info("central=\(centralManager)")
        }
    }
    
    /// 连接外设
    public func connect(peripheral: CBPeripheral, options: [String: Any]?) {
        centralManager.connect(peripheral, options: options)
        if isLogEnable {
            Log.info("central=\(centralManager) peripheral=\(peripheral) options=\(options)")
        }
    }
    
    /// 断开外设
    public func cancel(peripheral: CBPeripheral) {
        centralManager.cancelPeripheralConnection(peripheral)
        if isLogEnable {
            Log.info("central=\(centralManager) peripheral=\(peripheral)")
        }
    }
    
    /// 注册连接事件
    @available(iOS 13.0, *)
    public func registerForConnectionEvents(options: [CBConnectionEventMatchingOption : Any]?) {
        centralManager.registerForConnectionEvents(options: options)
        if isLogEnable {
            Log.info("central=\(centralManager) options=\(options)")
        }
    }
}

// MARK: - CBCentralManagerDelegate
extension SFCentralManager: CBCentralManagerDelegate {
    
    
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
        if isLogEnable {
            Log.info("central=\(central)")
        }
        didUpdateStateBlock?(central)
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
        if isLogEnable {
            Log.info("central=\(central) dict=\(dict)")
        }
        willRestoreStateBlock?(central, dict)
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
        if isLogEnable {
            Log.info("central=\(central) peripheral=\(peripheral) advertisementData=\(advertisementData) RSSI=\(RSSI)")
        }
        didDiscoverPeripheralBlock?(central, peripheral, advertisementData, RSSI)
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
        if isLogEnable {
            Log.info("central=\(central) peripheral=\(peripheral)")
        }
        didConnectPeripheralBlock?(central, peripheral)
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
        if isLogEnable {
            Log.info("central=\(central) peripheral=\(peripheral) error=\(error?.localizedDescription ?? "nil")")
        }
        didFailToConnectPeripheralBlock?(central, peripheral, error)
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
        if isLogEnable {
            Log.info("central=\(central) peripheral=\(peripheral) error=\(error?.localizedDescription ?? "nil")")
        }
        didDisconnectPeripheralBlock?(central, peripheral, error)
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
        if isLogEnable {
            Log.info("central=\(central) peripheral=\(peripheral) timestamp=\(timestamp) isReconnecting=\(isReconnecting) error=\(error?.localizedDescription ?? "nil")")
        }
        didDisconnectPeripheralAutoReconnectBlock?(central, peripheral, timestamp, isReconnecting, error)
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
        if isLogEnable {
            Log.info("central=\(central) event=\(event) peripheral=\(peripheral)")
        }
        connectionEventDidOccurBlock?(central, event, peripheral)
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
        if isLogEnable {
            Log.info("central=\(central) peripheral=\(peripheral)")
        }
        didUpdateANCSAuthorizationForPeripheralBlock?(central, peripheral)
    }
}
