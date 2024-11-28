//
//  SFCentralManagerLogPlugin.swift
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

// MARK: - SFCentralManagerLogOption
public struct SFCentralManagerLogOption: OptionSet {
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let retrievePeripherals = Self(rawValue: 1 << 0)
    public static let retrieveConnectedPeripherals = Self(rawValue: 1 << 1)
    public static let scanForPeripherals = Self(rawValue: 1 << 2)
    public static let stopScan = Self(rawValue: 1 << 3)
    public static let connectPeripheral = Self(rawValue: 1 << 4)
    public static let disconnectPeripheral = Self(rawValue: 1 << 5)
    public static let registerForConnectionEvents = Self(rawValue: 1 << 6)
    public static let didUpdateIsScannig = Self(rawValue: 1 << 7)
    public static let didUpdateState = Self(rawValue: 1 << 8)
    public static let willRestoreState = Self(rawValue: 1 << 9)
    public static let didDiscoverPeripheral = Self(rawValue: 1 << 10)
    public static let didConnectPeripheral = Self(rawValue: 1 << 11)
    public static let didFailToConnectPeripheral = Self(rawValue: 1 << 12)
    public static let didDisconnectPeripheral = Self(rawValue: 1 << 13)
    public static let didDisconnectPeripheralThenTryReconnect = Self(rawValue: 1 << 14)
    public static let didOccurConnectionEvent = Self(rawValue: 1 << 15)
    public static let didUpdateANCSAuthorization = Self(rawValue: 1 << 16)
    
    public static let all: Self = [
        .retrievePeripherals,
        .retrieveConnectedPeripherals,
        .scanForPeripherals,
        .stopScan,
        .connectPeripheral,
        .disconnectPeripheral,
        .registerForConnectionEvents,
        .didUpdateIsScannig,
        .didUpdateState,
        .willRestoreState,
        .didDiscoverPeripheral,
        .didConnectPeripheral,
        .didFailToConnectPeripheral,
        .didDisconnectPeripheral,
        .didDisconnectPeripheralThenTryReconnect,
        .didOccurConnectionEvent,
        .didUpdateANCSAuthorization,
    ]
    
    public var tag: String {
        var res = [String]()
        if self.contains(.retrievePeripherals) {
            res.append("SF_CentralManager_retrievePeripherals")
        }
        if self.contains(.retrieveConnectedPeripherals) {
            res.append("SF_CentralManager_retrieveConnectedPeripherals")
        }
        if self.contains(.scanForPeripherals) {
            res.append("SF_CentralManager_scanForPeripherals")
        }
        if self.contains(.stopScan) {
            res.append("SF_CentralManager_stopScan")
        }
        if self.contains(.connectPeripheral) {
            res.append("SF_CentralManager_connectPeripheral")
        }
        if self.contains(.disconnectPeripheral) {
            res.append("SF_CentralManager_disconnectPeripheral")
        }
        if self.contains(.registerForConnectionEvents) {
            res.append("SF_CentralManager_registerForConnectionEvents")
        }
        if self.contains(.didUpdateIsScannig) {
            res.append("SF_CentralManager_didUpdateIsScannig")
        }
        if self.contains(.didUpdateState) {
            res.append("SF_CentralManager_didUpdateState")
        }
        if self.contains(.willRestoreState) {
            res.append("SF_CentralManager_willRestoreState")
        }
        if self.contains(.didDiscoverPeripheral) {
            res.append("SF_CentralManager_didDiscoverPeripheral")
        }
        if self.contains(.didConnectPeripheral) {
            res.append("SF_CentralManager_didConnectPeripheral")
        }
        if self.contains(.didFailToConnectPeripheral) {
            res.append("SF_CentralManager_didFailToConnectPeripheral")
        }
        if self.contains(.didDisconnectPeripheral) {
            res.append("SF_CentralManager_didDisconnectPeripheral")
        }
        if self.contains(.didDisconnectPeripheralThenTryReconnect) {
            res.append("SF_CentralManager_didDisconnectPeripheralThenTryReconnect")
        }
        if self.contains(.didOccurConnectionEvent) {
            res.append("SF_CentralManager_didOccurConnectionEvent")
        }
        if self.contains(.didUpdateANCSAuthorization) {
            res.append("SF_CentralManager_didUpdateANCSAuthorization")
        }
        return res.joined(separator: " ,")
    }
}


// MARK: - SFCentralManagerLogPlugin
public class SFCentralManagerLogPlugin {
    public var opts: SFCentralManagerLogOption = .all
    public private(set) var logSummary: SFBleDiscoverLogSummary?
}


// MARK: - SFCentralManagerPlugin
extension SFCentralManagerLogPlugin: SFCentralManagerPlugin {
    public func retrievePeripherals(central: CBCentralManager, identifiers: [UUID], peripherals: [CBPeripheral]) {
        let opt: SFCentralManagerLogOption = .retrievePeripherals
        guard opts.contains(opt) else { return }
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
        SFLogger.bleTry(tag: opt.tag,
                   msgs: [msg_centralManager, msg_identifiers],
                   result: msg_peripherals)
    }
    
    public func retrieveConnectedPeripherals(central: CBCentralManager, services: [CBUUID], peripherals: [CBPeripheral]) {
        let opt: SFCentralManagerLogOption = .retrieveConnectedPeripherals
        guard opts.contains(opt) else { return }
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
        SFLogger.bleTry(tag: opt.tag,
                   msgs: [msg_centralManager, msg_services],
                   result: msg_peripherals)
    }
    
    public func scanForPeripherals(central: CBCentralManager, services: [CBUUID]?, options: [String: Any]?) {
        let opt: SFCentralManagerLogOption = .scanForPeripherals
        guard opts.contains(opt) else { return }
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
        SFLogger.bleTry(tag: opt.tag,
                   msgs: [msg_centralManager, msg_services, msg_options],
                   result: nil)
    }
    
    public func stopScan(central: CBCentralManager) {
        let opt: SFCentralManagerLogOption = .stopScan
        guard opts.contains(opt) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        SFLogger.bleTry(tag: opt.tag,
                   msgs: [msg_centralManager, ],
                   result: nil)
    }
    
    public func connectPeripheral(central: CBCentralManager, peripheral: CBPeripheral, options: [String: Any]?) {
        let opt: SFCentralManagerLogOption = .connectPeripheral
        guard opts.contains(opt) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        var msg_options = "options=nil"
        if let options = options {
            msg_options = "options=\(options)"
        }
        SFLogger.bleTry(tag: opt.tag,
                   msgs: [msg_centralManager, msg_peripheral, msg_options],
                   result: nil)
    }
    
    public func disconnectPeripheral(central: CBCentralManager, peripheral: CBPeripheral) {
        let opt: SFCentralManagerLogOption = .disconnectPeripheral
        guard opts.contains(opt) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        SFLogger.bleTry(tag: opt.tag,
                   msgs: [msg_centralManager, msg_peripheral],
                   result: nil)
    }
    
    @available(iOS 13.0, *)
    public func registerForConnectionEvents(central: CBCentralManager, options: [CBConnectionEventMatchingOption : Any]?) {
        let opt: SFCentralManagerLogOption = .registerForConnectionEvents
        guard opts.contains(opt) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        var msg_options = "options=nil"
        if let options = options {
            msg_options = "options=\(options)"
        }
        SFLogger.bleTry(tag: opt.tag,
                   msgs: [msg_centralManager, msg_options],
                   result: nil)
    }
    
    public func didUpdateIsScannig(central: CBCentralManager, isScanning: Bool) {
        let opt: SFCentralManagerLogOption = .didUpdateIsScannig
        guard opts.contains(opt) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        let msg_isScanning = "isScanning=\(isScanning)"
        SFLogger.bleCallback(tag: opt.tag,
                        msgs: [msg_centralManager, msg_isScanning])
    }
    
    @available(iOS 5.0, *)
    public func didUpdateState(central: CBCentralManager, state: CBManagerState) {
        let opt: SFCentralManagerLogOption = .didUpdateState
        guard opts.contains(opt) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        SFLogger.bleCallback(tag: opt.tag,
                        msgs: [msg_centralManager, ])
    }
    
    @available(iOS 5.0, *)
    public func willRestoreState(central: CBCentralManager, dict: [String : Any]) {
        let opt: SFCentralManagerLogOption = .willRestoreState
        guard opts.contains(opt) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        let msg_dict = "dict=\(dict)"
        SFLogger.bleCallback(tag: opt.tag,
                        msgs: [msg_centralManager, msg_dict])
    }
    
    @available(iOS 5.0, *)
    public func didDiscoverPeripheral(central: CBCentralManager, peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let opt: SFCentralManagerLogOption = .didDiscoverPeripheral
        guard opts.contains(opt) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_advertisementData = "advertisementData=\(advertisementData)"
        let msg_RSSI = "RSSI=\(RSSI)"
//        SFLogger.bleCallback(tag: opt.tag,
//                        msgs: [msg_centralManager, msg_peripheral, msg_advertisementData, msg_RSSI])
        let logSummary = self.logSummary ?? SFBleDiscoverLogSummary(tag: opt.tag)
        logSummary.update(log: SFBleDiscoverLog(time: Date(), peripheral: peripheral, advertisementData: advertisementData, rssi: RSSI))
    }
    
    @available(iOS 5.0, *)
    public func didConnectPeripheral(central: CBCentralManager, peripheral: CBPeripheral) {
        let opt: SFCentralManagerLogOption = .didConnectPeripheral
        guard opts.contains(opt) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        SFLogger.bleCallback(tag: opt.tag,
                        msgs: [msg_centralManager, msg_peripheral])
    }
    
    @available(iOS 5.0, *)
    public func didFailToConnectPeripheral(central: CBCentralManager, peripheral: CBPeripheral, error: (any Error)?) {
        let opt: SFCentralManagerLogOption = .didFailToConnectPeripheral
        guard opts.contains(opt) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        SFLogger.bleCallback(tag: opt.tag,
                        msgs: [msg_centralManager, msg_peripheral, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func didDisconnectPeripheral(central: CBCentralManager, peripheral: CBPeripheral, error: (any Error)?) {
        let opt: SFCentralManagerLogOption = .didDisconnectPeripheral
        guard opts.contains(opt) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        SFLogger.bleCallback(tag: opt.tag,
                        msgs: [msg_centralManager, msg_peripheral, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func didDisconnectPeripheralThenTryReconnect(central: CBCentralManager, peripheral: CBPeripheral, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: (any Error)?) {
        let opt: SFCentralManagerLogOption = .didDisconnectPeripheral
        guard opts.contains(opt) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_timestamp = "timestamp=\(timestamp)"
        let msg_isReconnecting = "isReconnecting=\(isReconnecting)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        SFLogger.bleCallback(tag: opt.tag,
                        msgs: [msg_centralManager, msg_peripheral, msg_timestamp, msg_isReconnecting, msg_error])
    }
    
    @available(iOS 13.0, *)
    public func didOccurConnectionEvent(central: CBCentralManager, event: CBConnectionEvent, peripheral: CBPeripheral) {
        let opt: SFCentralManagerLogOption = .didOccurConnectionEvent
        guard opts.contains(opt) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        let msg_event = "event=\(event.sf.description)"
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        SFLogger.bleCallback(tag: opt.tag,
                        msgs: [msg_centralManager, msg_event, msg_peripheral])
    }
    
    @available(iOS 13.0, *)
    public func didUpdateANCSAuthorization(central: CBCentralManager, peripheral: CBPeripheral) {
        let opt: SFCentralManagerLogOption = .didUpdateANCSAuthorization
        guard opts.contains(opt) else { return }
        let msg_centralManager = "centralManager=\(central.sf.description)"
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        SFLogger.bleCallback(tag: opt.tag,
                        msgs: [msg_centralManager, msg_peripheral])
    }
}
