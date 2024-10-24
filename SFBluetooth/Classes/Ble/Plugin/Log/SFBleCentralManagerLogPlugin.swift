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

// MARK: - SFBleCentralManagerLogOption
public struct SFBleCentralManagerLogOption: OptionSet {
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let isScanningDidChanged =                        Self(rawValue: 1 << 0)
    public static let stateDidUpdated =                             Self(rawValue: 1 << 1)
    public static let ANCSAuthorizationDidUpdated =                 Self(rawValue: 1 << 2)
    public static let willRestoreState =                            Self(rawValue: 1 << 3)
    public static let retrievePeripherals =                         Self(rawValue: 1 << 4)
    public static let retrieveConnectedPeripherals =                Self(rawValue: 1 << 5)
    public static let scanStart =                                   Self(rawValue: 1 << 6)
    public static let scanStop =                                    Self(rawValue: 1 << 7)
    public static let didDiscoverPeripheral =                       Self(rawValue: 1 << 8)
    public static let connectPeripheralStart =                      Self(rawValue: 1 << 9)
    public static let connectPeripheralSuccess =                    Self(rawValue: 1 << 10)
    public static let connectPeripheralFailure =                    Self(rawValue: 1 << 11)
    public static let disconnectPeripheralStart =                   Self(rawValue: 1 << 12)
    public static let disconnectPeripheralSuccess =                 Self(rawValue: 1 << 13)
    public static let disconnectPeripheralAutoReconnectSuccess =    Self(rawValue: 1 << 14)
    public static let connectionEventsRegister =                    Self(rawValue: 1 << 15)
    public static let connectionEventsOccur =                       Self(rawValue: 1 << 16)
    
    public static let all: Self = [.isScanningDidChanged, .stateDidUpdated, .ANCSAuthorizationDidUpdated, .willRestoreState, .retrievePeripherals, .retrieveConnectedPeripherals, .scanStart, .scanStop, .didDiscoverPeripheral, .connectPeripheralStart, .connectPeripheralSuccess, .connectPeripheralFailure, .disconnectPeripheralStart, .disconnectPeripheralSuccess, .disconnectPeripheralAutoReconnectSuccess, .connectionEventsRegister, .connectionEventsOccur]
}


// MARK: - SFBleCentralManagerLogPlugin
public class SFBleCentralManagerLogPlugin {
    public var option: SFBleCentralManagerLogOption = .all
}


// MARK: - SFBleCentralManagerPlugin
extension SFBleCentralManagerLogPlugin: SFBleCentralManagerPlugin {
    public func centralManager(_ central: CBCentralManager, retrievePeripherals id: UUID, identifiers: [UUID], return peripherals: [CBPeripheral]) {
        guard option.contains(.retrievePeripherals) else { return }
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
    
    public func centralManager(_ central: CBCentralManager, retrieveConnectedPeripherals id: UUID, services: [CBUUID], return peripherals: [CBPeripheral]) {
        guard option.contains(.retrieveConnectedPeripherals) else { return }
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
    
    public func centralManager(_ central: CBCentralManager, scanForPeripherals id: UUID, services: [CBUUID]?, options: [String: Any]?) {
        guard option.contains(.scanStart) else { return }
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
    
    public func centralManager(_ central: CBCentralManager, stopScan id: UUID) {
        guard option.contains(.scanStop) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        Log.bleTry(id: id, tag: SF_Tag_CentralManager_Scan_Stop,
                   msgs: [msg_centralManager, ],
                   result: nil)
    }
    
    public func centralManager(_ central: CBCentralManager, connect id: UUID, peripheral: CBPeripheral, options: [String: Any]?) {
        guard option.contains(.connectPeripheralStart) else { return }
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
    
    public func centralManager(_ central: CBCentralManager, disconnect id: UUID, peripheral: CBPeripheral) {
        guard option.contains(.disconnectPeripheralStart) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        Log.bleTry(id: id, tag: SF_Tag_CentralManager_DisconnectPeripheral_Start,
                   msgs: [msg_centralManager, msg_peripheral],
                   result: nil)
    }
    
    @available(iOS 13.0, *)
    public func centralManager(_ central: CBCentralManager, registerForConnectionEvents id: UUID, options: [CBConnectionEventMatchingOption : Any]?) {
        guard option.contains(.connectionEventsRegister) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        var msg_options = "options=nil"
        if let options = options {
            msg_options = "options=\(options)"
        }
        Log.bleTry(id: id, tag: SF_Tag_CentralManager_ConnectionEvents_Register,
                   msgs: [msg_centralManager, msg_options],
                   result: nil)
    }
    
    public func centralManager(_ central: CBCentralManager, didUpdateIsScannig id: UUID, isScanning: Bool) {
        guard option.contains(.isScanningDidChanged) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        let msg_isScanning = "isScanning=\(isScanning)"
        Log.bleCallback(id: id, tag: SF_Tag_CentralManager_DidUpdate_IsScanning,
                        msgs: [msg_centralManager, msg_isScanning])
    }
    
    @available(iOS 5.0, *)
    public func centralManager(_ central: CBCentralManager, didUpdateState id: UUID) {
        guard option.contains(.stateDidUpdated) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        Log.bleCallback(id: id, tag: SF_Tag_CentralManager_DidUpdate_State,
                        msgs: [msg_centralManager, ])
    }
    
    @available(iOS 5.0, *)
    public func centralManager(_ central: CBCentralManager, willRestoreState id: UUID, dict: [String : Any]) {
        guard option.contains(.stateDidUpdated) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        let msg_dict = "dict=\(dict)"
        Log.bleCallback(id: id, tag: SF_Tag_CentralManager_WillRestoreState,
                        msgs: [msg_centralManager, msg_dict])
    }
    
    @available(iOS 5.0, *)
    public func centralManager(_ central: CBCentralManager, didDiscover id: UUID, peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        guard option.contains(.didDiscoverPeripheral) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_advertisementData = "advertisementData=\(advertisementData)"
        let msg_RSSI = "RSSI=\(RSSI)"
        Log.bleCallback(id: id, tag: SF_Tag_CentralManager_DidDiscoverPeripheral,
                        msgs: [msg_centralManager, msg_peripheral, msg_advertisementData, msg_RSSI])
        
    }
    
    @available(iOS 5.0, *)
    public func centralManager(_ central: CBCentralManager, didConnect id: UUID, peripheral: CBPeripheral) {
        guard option.contains(.connectPeripheralSuccess) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        Log.bleCallback(id: id, tag: SF_Tag_CentralManager_ConnectPeripheral_Success,
                        msgs: [msg_centralManager, msg_peripheral])
    }
    
    @available(iOS 5.0, *)
    public func centralManager(_ central: CBCentralManager, didFailToConnect id: UUID, peripheral: CBPeripheral, error: (any Error)?) {
        guard option.contains(.connectPeripheralFailure) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(id: id, tag: SF_Tag_CentralManager_ConnectPeripheral_Failure,
                        msgs: [msg_centralManager, msg_peripheral, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func centralManager(_ central: CBCentralManager, didDisconnectPeripheral id: UUID, peripheral: CBPeripheral, error: (any Error)?) {
        guard option.contains(.disconnectPeripheralSuccess) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(id: id, tag: SF_Tag_CentralManager_DisconnectPeripheral_Success,
                        msgs: [msg_centralManager, msg_peripheral, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func centralManager(_ central: CBCentralManager, didDisconnectPeripheral id: UUID, peripheral: CBPeripheral, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: (any Error)?) {
        guard option.contains(.disconnectPeripheralAutoReconnectSuccess) else { return }
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
    
    @available(iOS 13.0, *)
    public func centralManager(_ central: CBCentralManager, connectionEventDidOccur id: UUID, event: CBConnectionEvent, for peripheral: CBPeripheral) {
        guard option.contains(.connectionEventsOccur) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        let msg_event = "event=\(event.sf.description)"
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        Log.bleCallback(id: id, tag: SF_Tag_CentralManager_ConnectionEvents_Occur,
                        msgs: [msg_centralManager, msg_event, msg_peripheral])
    }
    
    @available(iOS 13.0, *)
    public func centralManager(_ central: CBCentralManager, didUpdateANCSAuthorization id: UUID, for peripheral: CBPeripheral) {
        guard option.contains(.ANCSAuthorizationDidUpdated) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        Log.bleCallback(id: id, tag: SF_Tag_CentralManager_WillRestoreState,
                        msgs: [msg_centralManager, msg_peripheral])
    }
}
