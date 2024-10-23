//
//  SFBleCentralManagerPlugin.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/23.
//

import Foundation
import CoreBluetooth

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


// MARK: - SFBleCentralManagerPlugin
public protocol SFBleCentralManagerPlugin {
    /// [Try] 检索外设
    func retrievePeripherals(id: UUID,  central: CBCentralManager, identifiers: [UUID], return peripherals: [CBPeripheral])
    
    /// [Try] 检索已连接的外设
    func retrieveConnectedPeripherals(id: UUID,  central: CBCentralManager, services: [CBUUID], return peripherals: [CBPeripheral])
    
    /// [Try] 开始扫描
    func scanForPeripherals(id: UUID,  central: CBCentralManager, services: [CBUUID]?, options: [String: Any]?)
    
    /// [Try] 停止扫描
    func stopScan(id: UUID,  central: CBCentralManager)
    
    /// [Try] 连接外设
    func connect(id: UUID,  central: CBCentralManager, peripheral: CBPeripheral, options: [String: Any]?)
    
    /// [Try] 断开外设
    func disconnect(id: UUID,  central: CBCentralManager, peripheral: CBPeripheral)
    
    /// [Try] 注册连接事件
    @available(iOS 13.0, *)
    func registerForConnectionEvents(id: UUID,  central: CBCentralManager, options: [CBConnectionEventMatchingOption : Any]?) 
    
    /// [Callback] 扫描状态更新
    func centralManagerDidUpdateIsScannig(id: UUID,  central: CBCentralManager, isScanning: Bool)
    
    /// [Callback] 蓝牙状态更新
    @available(iOS 5.0, *)
    func centralManagerDidUpdateState(id: UUID,  central: CBCentralManager)
    
    /// [Callback] 状态恢复
    @available(iOS 5.0, *)
    func centralManager(id: UUID,  central: CBCentralManager, willRestoreState dict: [String : Any])
    
    /// [Callback] 发现外设
    @available(iOS 5.0, *)
    func centralManager(id: UUID,  central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber)
    
    /// [Callback] 连接外设成功
    @available(iOS 5.0, *)
    func centralManager(id: UUID,  central: CBCentralManager, didConnect peripheral: CBPeripheral)
    
    /// [Callback] 连接外设失败
    @available(iOS 5.0, *)
    func centralManager(id: UUID,  central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: (any Error)?)
    
    /// [Callback] 断开外设成功
    @available(iOS 5.0, *)
    func centralManager(id: UUID,  central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: (any Error)?)
    
    /// [Callback] 断开后重连外设
    @available(iOS 5.0, *)
    func centralManager(id: UUID,  central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: (any Error)?)
    
    /// [Callback] 连接事件
    @available(iOS 13.0, *)
    func centralManager(id: UUID,  central: CBCentralManager, connectionEventDidOccur event: CBConnectionEvent, for peripheral: CBPeripheral)
    
    /// [Callback] ANCS
    @available(iOS 13.0, *)
    func centralManager(id: UUID,  central: CBCentralManager, didUpdateANCSAuthorizationFor peripheral: CBPeripheral)
}

extension SFBleCentralManagerPlugin {
    /// [Try] 检索外设
    func retrievePeripherals(id: UUID,  central: CBCentralManager, identifiers: [UUID], return peripherals: [CBPeripheral]) {}
    
    /// [Try] 检索已连接的外设
    func retrieveConnectedPeripherals(id: UUID,  central: CBCentralManager, services: [CBUUID], return peripherals: [CBPeripheral]) {}
    
    /// [Try] 开始扫描
    func scanForPeripherals(id: UUID,  central: CBCentralManager, services: [CBUUID]?, options: [String: Any]?) {}
    
    /// [Try] 停止扫描
    func stopScan(id: UUID,  central: CBCentralManager) {}
    
    /// [Try] 连接外设
    func connect(id: UUID,  central: CBCentralManager, peripheral: CBPeripheral, options: [String: Any]?) {}
    
    /// [Try] 断开外设
    func disconnect(id: UUID,  central: CBCentralManager, peripheral: CBPeripheral) {}
    
    /// [Try] 注册连接事件
    @available(iOS 13.0, *)
    func registerForConnectionEvents(id: UUID,  central: CBCentralManager, options: [CBConnectionEventMatchingOption : Any]?) {}
    
    /// [Callback] 扫描状态更新
    func centralManagerDidUpdateIsScannig(id: UUID,  central: CBCentralManager, isScanning: Bool) {}
    
    /// [Callback] 蓝牙状态更新
    @available(iOS 5.0, *)
    func centralManagerDidUpdateState(id: UUID,  central: CBCentralManager) {}
    
    /// [Callback] 状态恢复
    @available(iOS 5.0, *)
    func centralManager(id: UUID,  central: CBCentralManager, willRestoreState dict: [String : Any]) {}
    
    /// [Callback] 发现外设
    @available(iOS 5.0, *)
    func centralManager(id: UUID,  central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {}
    
    /// [Callback] 连接外设成功
    @available(iOS 5.0, *)
    func centralManager(id: UUID,  central: CBCentralManager, didConnect peripheral: CBPeripheral) {}
    
    /// [Callback] 连接外设失败
    @available(iOS 5.0, *)
    func centralManager(id: UUID,  central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: (any Error)?) {}
    
    /// [Callback] 断开外设成功
    @available(iOS 5.0, *)
    func centralManager(id: UUID,  central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: (any Error)?) {}
    
    /// [Callback] 断开后重连外设
    @available(iOS 5.0, *)
    func centralManager(id: UUID,  central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: (any Error)?) {}
    
    /// [Callback] 连接事件
    @available(iOS 13.0, *)
    func centralManager(id: UUID,  central: CBCentralManager, connectionEventDidOccur event: CBConnectionEvent, for peripheral: CBPeripheral) {}
    
    /// [Callback] ANCS
    @available(iOS 13.0, *)
    func centralManager(id: UUID,  central: CBCentralManager, didUpdateANCSAuthorizationFor peripheral: CBPeripheral) {}
}
