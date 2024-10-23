//
//  SFBleCentralManagerLogPlugin.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/23.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger

// MARK: - SFBleCentralManageroption
public struct SFBleCentralManageroption: OptionSet {
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let isScanningDidChanged =                        SFBleCentralManageroption(rawValue: 1 << 0)
    public static let stateDidUpdated =                             SFBleCentralManageroption(rawValue: 1 << 1)
    public static let ANCSAuthorizationDidUpdated =                 SFBleCentralManageroption(rawValue: 1 << 2)
    public static let willRestoreState =                            SFBleCentralManageroption(rawValue: 1 << 3)
    public static let retrievePeripherals =                         SFBleCentralManageroption(rawValue: 1 << 4)
    public static let retrieveConnectedPeripherals =                SFBleCentralManageroption(rawValue: 1 << 5)
    public static let scanStart =                                   SFBleCentralManageroption(rawValue: 1 << 6)
    public static let scanStop =                                    SFBleCentralManageroption(rawValue: 1 << 7)
    public static let didDiscoverPeripheral =                       SFBleCentralManageroption(rawValue: 1 << 8)
    public static let connectPeripheralStart =                      SFBleCentralManageroption(rawValue: 1 << 9)
    public static let connectPeripheralSuccess =                    SFBleCentralManageroption(rawValue: 1 << 10)
    public static let connectPeripheralFailure =                    SFBleCentralManageroption(rawValue: 1 << 11)
    public static let disconnectPeripheralStart =                   SFBleCentralManageroption(rawValue: 1 << 12)
    public static let disconnectPeripheralSuccess =                 SFBleCentralManageroption(rawValue: 1 << 13)
    public static let disconnectPeripheralAutoReconnectSuccess =    SFBleCentralManageroption(rawValue: 1 << 14)
    public static let connectionEventsRegister =                    SFBleCentralManageroption(rawValue: 1 << 15)
    public static let connectionEventsOccur =                       SFBleCentralManageroption(rawValue: 1 << 16)
    
    public static let all: SFBleCentralManageroption = [.isScanningDidChanged, .stateDidUpdated, .ANCSAuthorizationDidUpdated, .willRestoreState, .retrievePeripherals, .retrieveConnectedPeripherals, .scanStart, .scanStop, .didDiscoverPeripheral, .connectPeripheralStart, .connectPeripheralSuccess, .connectPeripheralFailure, .disconnectPeripheralStart, .disconnectPeripheralSuccess, .disconnectPeripheralAutoReconnectSuccess, .connectionEventsRegister, .connectionEventsOccur]
}


// MARK: - SFBleCentralManagerLogPlugin
public class SFBleCentralManagerLogPlugin: SFBleCentralManagerPlugin {
    // MARK: var
    public var option: SFBleCentralManageroption = .all
    
    // MARK: func
    /// [Try] 检索外设
    public func retrievePeripherals(id: UUID,  central: CBCentralManager, identifiers: [UUID], return peripherals: [CBPeripheral]) {
        if option.contains(.retrievePeripherals) {
            let msg_centralManager = "centralManager=\(central.sf.description)"
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
            Log.bleTry(id: id, tag: SF_Tag_CentralManager_RetrievePeripherals,
                   msgs: [msg_centralManager, msg_identifiers],
                   result: msg_peripherals)
        }
    }
    
    /// [Try] 检索已连接的外设
    public func retrieveConnectedPeripherals(id: UUID,  central: CBCentralManager, services: [CBUUID], return peripherals: [CBPeripheral]) {
        if option.contains(.retrieveConnectedPeripherals) {
            let msg_centralManager = "centralManager=\(central.sf.description)"
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
            Log.bleTry(id: id, tag: SF_Tag_CentralManager_RetrieveConnectedPeripherals,
                   msgs: [msg_centralManager, msg_services],
                   result: msg_peripherals)
        }
    }
    
    /// [Try] 开始扫描
    public func scanForPeripherals(id: UUID,  central: CBCentralManager, services: [CBUUID]?, options: [String: Any]?) {
        if option.contains(.scanStart) {
            let msg_centralManager = "centralManager=\(central.sf.description)"
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
            Log.bleTry(id: id, tag: SF_Tag_CentralManager_Scan_Start,
                   msgs: [msg_centralManager, msg_services, msg_options],
                   result: nil)
        }
    }
    
    /// [Try] 停止扫描
    public func stopScan(id: UUID,  central: CBCentralManager) {
        if option.contains(.scanStop) {
            let msg_centralManager = "centralManager=\(central.sf.description)"
            Log.bleTry(id: id, tag: SF_Tag_CentralManager_Scan_Stop,
                   msgs: [msg_centralManager, ],
                   result: nil)
        }
    }
    
    /// [Try] 连接外设
    public func connect(id: UUID,  central: CBCentralManager, peripheral: CBPeripheral, options: [String: Any]?) {
        if option.contains(.connectPeripheralStart) {
            let msg_centralManager = "centralManager=\(central.sf.description)"
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            var msg_options = "options=nil"
            if let options = options {
                msg_options = "options=\(options)"
            }
            Log.bleTry(id: id, tag: SF_Tag_CentralManager_ConnectPeripheral_Start,
                   msgs: [msg_centralManager, msg_peripheral, msg_options],
                   result: nil)
        }
    }
    
    /// [Try] 断开外设
    public func disconnect(id: UUID,  central: CBCentralManager, peripheral: CBPeripheral) {
        if option.contains(.disconnectPeripheralStart) {
            let msg_centralManager = "centralManager=\(central.sf.description)"
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            Log.bleTry(id: id, tag: SF_Tag_CentralManager_DisconnectPeripheral_Start,
                   msgs: [msg_centralManager, msg_peripheral],
                   result: nil)
        }
    }
    
    /// [Try] 注册连接事件
    @available(iOS 13.0, *)
    public func registerForConnectionEvents(id: UUID,  central: CBCentralManager, options: [CBConnectionEventMatchingOption : Any]?) {
        if option.contains(.connectionEventsRegister) {
            let msg_centralManager = "centralManager=\(central.sf.description)"
            var msg_options = "options=nil"
            if let options = options {
                msg_options = "options=\(options)"
            }
            Log.bleTry(id: id, tag: SF_Tag_CentralManager_ConnectionEvents_Register,
                   msgs: [msg_centralManager, msg_options],
                   result: nil)
        }
    }
    
    /// [Callback] 扫描状态更新
    public func centralManagerDidUpdateIsScannig(id: UUID,  central: CBCentralManager, isScanning: Bool) {
        if option.contains(.isScanningDidChanged) {
            let msg_centralManager = "centralManager=\(central.sf.description)"
            let msg_isScanning = "isScanning=\(isScanning)"
            Log.bleCallback(id: id, tag: SF_Tag_CentralManager_IsScanning_DidUpdated,
                   msgs: [msg_centralManager, msg_isScanning])
        }
    }
    
    /// [Callback] 蓝牙状态更新
    @available(iOS 5.0, *)
    public func centralManagerDidUpdateState(id: UUID,  central: CBCentralManager) {
        if option.contains(.stateDidUpdated) {
            let msg_centralManager = "centralManager=\(central.sf.description)"
            Log.bleCallback(id: id, tag: SF_Tag_CentralManager_State_DidUpdated,
                        msgs: [msg_centralManager, ])
        }
    }
    
    /// [Callback] 状态恢复
    @available(iOS 5.0, *)
    public func centralManager(id: UUID,  central: CBCentralManager, willRestoreState dict: [String : Any]) {
        if option.contains(.stateDidUpdated) {
            let msg_centralManager = "centralManager=\(central.sf.description)"
            let msg_dict = "dict=\(dict)"
            Log.bleCallback(id: id, tag: SF_Tag_CentralManager_WillRestoreState,
                        msgs: [msg_centralManager, msg_dict])
        }
    }
    
    /// [Callback] 发现外设
    @available(iOS 5.0, *)
    public func centralManager(id: UUID,  central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if option.contains(.didDiscoverPeripheral) {
            let msg_centralManager = "centralManager=\(central.sf.description)"
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_advertisementData = "advertisementData=\(advertisementData)"
            let msg_RSSI = "RSSI=\(RSSI)"
            Log.bleCallback(id: id, tag: SF_Tag_CentralManager_DidDiscoverPeripheral,
                        msgs: [msg_centralManager, msg_peripheral, msg_advertisementData, msg_RSSI])
            
        }
    }
    
    /// [Callback] 连接外设成功
    @available(iOS 5.0, *)
    public func centralManager(id: UUID,  central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        if option.contains(.connectPeripheralSuccess) {
            let msg_centralManager = "centralManager=\(central.sf.description)"
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            Log.bleCallback(id: id, tag: SF_Tag_CentralManager_ConnectPeripheral_Success,
                        msgs: [msg_centralManager, msg_peripheral])
        }
    }
    
    /// [Callback] 连接外设失败
    @available(iOS 5.0, *)
    public func centralManager(id: UUID,  central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: (any Error)?) {
        if option.contains(.connectPeripheralFailure) {
            let msg_centralManager = "centralManager=\(central.sf.description)"
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            Log.bleCallback(id: id, tag: SF_Tag_CentralManager_ConnectPeripheral_Failure,
                        msgs: [msg_centralManager, msg_peripheral, msg_error])
        }
    }
    
    /// [Callback] 断开外设成功
    @available(iOS 5.0, *)
    public func centralManager(id: UUID,  central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: (any Error)?) {
        if option.contains(.disconnectPeripheralSuccess) {
            let msg_centralManager = "centralManager=\(central.sf.description)"
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            Log.bleCallback(id: id, tag: SF_Tag_CentralManager_DisconnectPeripheral_Success,
                        msgs: [msg_centralManager, msg_peripheral, msg_error])
        }
    }
    
    /// [Callback] 断开后重连外设
    @available(iOS 5.0, *)
    public func centralManager(id: UUID,  central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: (any Error)?) {
        if option.contains(.disconnectPeripheralAutoReconnectSuccess) {
            let msg_centralManager = "centralManager=\(central.sf.description)"
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_timestamp = "timestamp=\(timestamp)"
            let msg_isReconnecting = "isReconnecting=\(isReconnecting)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            Log.bleCallback(id: id, tag: SF_Tag_CentralManager_DisconnectPeripheralAutoReconnect_Success,
                        msgs: [msg_centralManager, msg_peripheral, msg_timestamp, msg_isReconnecting, msg_error])
        }
    }
    
    /// [Callback] 连接事件
    @available(iOS 13.0, *)
    public func centralManager(id: UUID,  central: CBCentralManager, connectionEventDidOccur event: CBConnectionEvent, for peripheral: CBPeripheral) {
        if option.contains(.connectionEventsOccur) {
            let msg_centralManager = "centralManager=\(central.sf.description)"
            let msg_event = "event=\(event.sf.description)"
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            Log.bleCallback(id: id, tag: SF_Tag_CentralManager_ConnectionEvents_Occur,
                        msgs: [msg_centralManager, msg_event, msg_peripheral])
        }
    }
    
    /// [Callback] ANCS
    @available(iOS 13.0, *)
    public func centralManager(id: UUID,  central: CBCentralManager, didUpdateANCSAuthorizationFor peripheral: CBPeripheral) {
        if option.contains(.ANCSAuthorizationDidUpdated) {
            let msg_centralManager = "centralManager=\(central.sf.description)"
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            Log.bleCallback(id: id, tag: SF_Tag_CentralManager_ANCSAuthorization_DidUpdated,
                        msgs: [msg_centralManager, msg_peripheral])
        }
    }
}
