//
//  SFCentralManagerPlugin.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/23.
//

import Foundation
import CoreBluetooth

// MARK: - SFCentralManagerPlugin
public protocol SFCentralManagerPlugin {
    func retrievePeripherals(central: CBCentralManager, identifiers: [UUID], peripherals: [CBPeripheral])
    
    func retrieveConnectedPeripherals(central: CBCentralManager, services: [CBUUID], peripherals: [CBPeripheral])
    
    func scanForPeripherals(central: CBCentralManager, services: [CBUUID]?, options: [String: Any]?)
    
    func stopScan(central: CBCentralManager)
    
    func connectPeripheral(central: CBCentralManager, peripheral: CBPeripheral, options: [String: Any]?)
    
    func disconnectPeripheral(central: CBCentralManager, peripheral: CBPeripheral)
    
    func registerForConnectionEvents(central: CBCentralManager, options: [CBConnectionEventMatchingOption : Any]?)
    
    func didUpdateIsScannig(central: CBCentralManager, isScanning: Bool)
    
    func didUpdateState(central: CBCentralManager, state: CBManagerState)
    
    func willRestoreState(central: CBCentralManager, dict: [String : Any])
    
    func didDiscoverPeripheral(central: CBCentralManager, peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber)
    
    func didConnectPeripheral(central: CBCentralManager, peripheral: CBPeripheral)
    
    func didFailToConnectPeripheral(central: CBCentralManager, peripheral: CBPeripheral, error: (any Error)?)
    
    func didDisconnectPeripheral(central: CBCentralManager, peripheral: CBPeripheral, error: (any Error)?)
    
    func didDisconnectPeripheralThenTryReconnect(central: CBCentralManager, peripheral: CBPeripheral, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: (any Error)?)
    
    func didOccurConnectionEvent(central: CBCentralManager, event: CBConnectionEvent, peripheral: CBPeripheral)
    
    func didUpdateANCSAuthorization(central: CBCentralManager, peripheral: CBPeripheral)
}

extension SFCentralManagerPlugin {
    func retrievePeripherals(central: CBCentralManager, identifiers: [UUID], peripherals: [CBPeripheral]) {}
    
    func retrieveConnectedPeripherals(central: CBCentralManager, services: [CBUUID], peripherals: [CBPeripheral]) {}
    
    func scanForPeripherals(central: CBCentralManager, services: [CBUUID]?, options: [String: Any]?) {}
    
    func stopScan(central: CBCentralManager) {}
    
    func connectPeripheral(central: CBCentralManager, peripheral: CBPeripheral, options: [String: Any]?) {}
    
    func disconnectPeripheral(central: CBCentralManager, peripheral: CBPeripheral) {}
    
    func registerForConnectionEvents(central: CBCentralManager, options: [CBConnectionEventMatchingOption : Any]?) {}
    
    func didUpdateIsScannig(central: CBCentralManager, isScanning: Bool) {}
    
    func didUpdateState(central: CBCentralManager, state: CBManagerState) {}
    
    func willRestoreState(central: CBCentralManager, dict: [String : Any]) {}
    
    func didDiscoverPeripheral(central: CBCentralManager, peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {}
    
    func didConnectPeripheral(central: CBCentralManager, peripheral: CBPeripheral) {}
    
    func didFailToConnectPeripheral(central: CBCentralManager, peripheral: CBPeripheral, error: (any Error)?) {}
    
    func didDisconnectPeripheral(central: CBCentralManager, peripheral: CBPeripheral, error: (any Error)?) {}
    
    func didDisconnectPeripheralThenTryReconnect(central: CBCentralManager, peripheral: CBPeripheral, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: (any Error)?) {}
    
    func didOccurConnectionEvent(central: CBCentralManager, event: CBConnectionEvent, peripheral: CBPeripheral) {}
    
    func didUpdateANCSAuthorization(central: CBCentralManager, peripheral: CBPeripheral) {}
}
