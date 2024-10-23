//
//  SFBleCentralManagerPlugin.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/23.
//

import Foundation
import CoreBluetooth

// MARK: - Tag
public let SF_Tag_CentralManager_DidUpdate_IsScanning =                         "Tag_CentralManager_DidUpdate_IsScanning"
public let SF_Tag_CentralManager_DidUpdate_State =                              "Tag_CentralManager_DidUpdate_State"
public let SF_Tag_CentralManager_DidUpdate_ANCSAuthorization =                  "Tag_CentralManager_WillRestoreState"
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


// MARK: - SFBleCentralManagerPlugin
public protocol SFBleCentralManagerPlugin {
    func centralManager(_ central: CBCentralManager, retrievePeripherals id: UUID, identifiers: [UUID], return peripherals: [CBPeripheral])
    
    func centralManager(_ central: CBCentralManager, retrieveConnectedPeripherals id: UUID, services: [CBUUID], return peripherals: [CBPeripheral])
    
    func centralManager(_ central: CBCentralManager, scanForPeripherals id: UUID, services: [CBUUID]?, options: [String: Any]?)
    
    func centralManager(_ central: CBCentralManager, stopScan id: UUID)
    
    func centralManager(_ central: CBCentralManager, connect id: UUID, peripheral: CBPeripheral, options: [String: Any]?)
    
    func centralManager(_ central: CBCentralManager, disconnect id: UUID, peripheral: CBPeripheral)
    
    @available(iOS 13.0, *)
    func centralManager(_ central: CBCentralManager, registerForConnectionEvents id: UUID, options: [CBConnectionEventMatchingOption : Any]?)
    
    func centralManager(_ central: CBCentralManager, didUpdateIsScannig id: UUID, isScanning: Bool)
    
    @available(iOS 5.0, *)
    func centralManager(_ central: CBCentralManager, didUpdateState id: UUID)
    
    @available(iOS 5.0, *)
    func centralManager(_ central: CBCentralManager, willRestoreState id: UUID, dict: [String : Any])
    
    @available(iOS 5.0, *)
    func centralManager(_ central: CBCentralManager, didDiscover id: UUID, peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber)
    
    @available(iOS 5.0, *)
    func centralManager(_ central: CBCentralManager, didConnect id: UUID, peripheral: CBPeripheral)
    
    @available(iOS 5.0, *)
    func centralManager(_ central: CBCentralManager, didFailToConnect id: UUID, peripheral: CBPeripheral, error: (any Error)?)
    
    @available(iOS 5.0, *)
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral id: UUID, peripheral: CBPeripheral, error: (any Error)?)
    
    @available(iOS 5.0, *)
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral id: UUID, peripheral: CBPeripheral, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: (any Error)?)
    
    @available(iOS 13.0, *)
    func centralManager(_ central: CBCentralManager, connectionEventDidOccur id: UUID, event: CBConnectionEvent, for peripheral: CBPeripheral)
    
    @available(iOS 13.0, *)
    func centralManager(_ central: CBCentralManager, didUpdateANCSAuthorization id: UUID, for peripheral: CBPeripheral)
}

extension SFBleCentralManagerPlugin {
    func centralManager(_ central: CBCentralManager, retrievePeripherals id: UUID, identifiers: [UUID], return peripherals: [CBPeripheral]) {}
    
    func centralManager(_ central: CBCentralManager, retrieveConnectedPeripherals id: UUID, services: [CBUUID], return peripherals: [CBPeripheral]) {}
    
    func centralManager(_ central: CBCentralManager, scanForPeripherals id: UUID, services: [CBUUID]?, options: [String: Any]?) {}
    
    func centralManager(_ central: CBCentralManager, stopScan id: UUID) {}
    
    func centralManager(_ central: CBCentralManager, connect id: UUID, peripheral: CBPeripheral, options: [String: Any]?) {}
    
    func centralManager(_ central: CBCentralManager, disconnect id: UUID, peripheral: CBPeripheral) {}
    
    @available(iOS 13.0, *)
    func centralManager(_ central: CBCentralManager, registerForConnectionEvents id: UUID, options: [CBConnectionEventMatchingOption : Any]?) {}
    
    func centralManager(_ central: CBCentralManager, didUpdateIsScannig id: UUID, isScanning: Bool) {}
    
    @available(iOS 5.0, *)
    func centralManager(_ central: CBCentralManager, didUpdateState id: UUID) {}
    
    @available(iOS 5.0, *)
    func centralManager(_ central: CBCentralManager, willRestoreState id: UUID, dict: [String : Any]) {}
    
    @available(iOS 5.0, *)
    func centralManager(_ central: CBCentralManager, didDiscover id: UUID, peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {}
    
    @available(iOS 5.0, *)
    func centralManager(_ central: CBCentralManager, didConnect id: UUID, peripheral: CBPeripheral) {}
    
    @available(iOS 5.0, *)
    func centralManager(_ central: CBCentralManager, didFailToConnect id: UUID, peripheral: CBPeripheral, error: (any Error)?) {}
    
    @available(iOS 5.0, *)
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral id: UUID, peripheral: CBPeripheral, error: (any Error)?) {}
    
    @available(iOS 5.0, *)
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral id: UUID, peripheral: CBPeripheral, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: (any Error)?) {}
    
    @available(iOS 13.0, *)
    func centralManager(_ central: CBCentralManager, connectionEventDidOccur id: UUID, event: CBConnectionEvent, for peripheral: CBPeripheral) {}
    
    @available(iOS 13.0, *)
    func centralManager(_ central: CBCentralManager, didUpdateANCSAuthorization id: UUID, for peripheral: CBPeripheral) {}
}
