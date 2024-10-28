////
////  SFBleCmdExample.swift
////  SFBluetooth
////
////  Created by hsf on 2024/10/28.
////
//
//import Foundation
//import CoreBluetooth
//
//class BLEManager {
//    private let bleCentralManager: SFBleCentralManager
//    private var blePeripheral: SFBlePeripheral?
//    
//    // 服务和特征值 UUID
//    private let serviceUUID = CBUUID(string: "YOUR_SERVICE_UUID")
//    private let characteristicUUID = CBUUID(string: "YOUR_CHARACTERISTIC_UUID")
//    
//    init() {
//        self.bleCentralManager = SFBleCentralManager(queue: <#dispatch_queue_t?#>, options: <#[String : Any]?#>)
//    }
//    
//    // MARK: - 回调方式示例
//    func connectDeviceWithCallback(deviceName: String) {
//        // 1. 扫描设备
//        let scanCmd = SFBleStartScanCmd(bleCentralManager: <#T##SFBleCentralManager#>)
//        let scanCmd = SFBleStartScanCmd(
//            bleCentralManager: centralManager,
//            timeout: 10,
//            filter: { peripheral in
//                return peripheral.name == deviceName
//            },
//            success: { [weak self] data, _ in
//                guard let peripheral = (data as? [SFBlePeripheral])?.first else {
//                    print("未找到目标设备")
//                    return
//                }
//                self?.peripheral = peripheral
//                // 2. 连接设备
//                self?.connectPeripheral(peripheral)
//            },
//            failure: { error in
//                print("扫描失败：\(error)")
//            }
//        )
//        scanCmd.execute()
//    }
//    
//    private func connectPeripheral(_ peripheral: SFBlePeripheral) {
//        let connectCmd = SFBleConnectPeripheralCmd(
//            bleCentralManager: centralManager,
//            blePeripheral: peripheral,
//            success: { [weak self] _, _ in
//                print("连接成功")
//                // 3. 发现服务
//                self?.discoverServices(peripheral)
//            },
//            failure: { error in
//                print("连接失败：\(error)")
//            }
//        )
//        connectCmd.execute()
//    }
//    
//    private func discoverServices(_ peripheral: SFBlePeripheral) {
//        let discoverCmd = SFBleDiscoverServicesCmd(
//            bleCentralManager: centralManager,
//            blePeripheral: peripheral,
//            services: [serviceUUID],
//            success: { [weak self] _, _ in
//                print("发现服务")
//                // 4. 读取特征值
//                self?.readCharacteristic(peripheral)
//            },
//            failure: { error in
//                print("发现服务失败：\(error)")
//            }
//        )
//        discoverCmd.execute()
//    }
//    
//    private func readCharacteristic(_ peripheral: SFBlePeripheral) {
//        guard let characteristic = peripheral.characteristic(uuid: characteristicUUID) else {
//            print("未找到目标特征值")
//            return
//        }
//        
//        let readCmd = SFBleReadCharacteristicValueCmd(
//            bleCentralManager: centralManager,
//            blePeripheral: peripheral,
//            characteristic: characteristic,
//            success: { data, _ in
//                if let value = data as? Data {
//                    print("读取成功：\(value)")
//                }
//            },
//            failure: { error in
//                print("读取失败：\(error)")
//            }
//        )
//        readCmd.execute()
//    }
//    
//    // MARK: - Async/Await 方式示例
//    func connectDeviceAsync(deviceName: String) async throws {
//        // 1. 扫描设备
//        let scanCmd = SFBleScanPeripheralCmd(
//            bleCentralManager: centralManager,
//            timeout: 10,
//            filter: { peripheral in
//                return peripheral.name == deviceName
//            }
//        )
//        
//        let scanResult = try await scanCmd.executeAsync()
//        guard let peripheral = (scanResult.data as? [SFBlePeripheral])?.first else {
//            throw SFBleCmdError.client(.scan(.timeout))
//        }
//        self.peripheral = peripheral
//        
//        // 2. 连接设备
//        let connectCmd = SFBleConnectPeripheralCmd(
//            bleCentralManager: centralManager,
//            blePeripheral: peripheral
//        )
//        try await connectCmd.executeAsync()
//        
//        // 3. 发现服务
//        let discoverCmd = SFBleDiscoverServicesCmd(
//            bleCentralManager: centralManager,
//            blePeripheral: peripheral,
//            services: [serviceUUID]
//        )
//        try await discoverCmd.executeAsync()
//        
//        // 4. 读取特征值
//        guard let characteristic = peripheral.characteristic(uuid: characteristicUUID) else {
//            throw SFBleCmdError.client(.peripheral(.characteristic(.notFound)))
//        }
//        
//        let readCmd = SFBleReadCharacteristicValueCmd(
//            bleCentralManager: centralManager,
//            blePeripheral: peripheral,
//            characteristic: characteristic
//        )
//        let readResult = try await readCmd.executeAsync()
//        
//        if let value = readResult.data as? Data {
//            print("读取成功：\(value)")
//        }
//    }
//}
//
//// MARK: - 使用示例
//// 1. 回调方式使用
//let manager = BLEManager()
//manager.connectDeviceWithCallback(deviceName: "MyDevice")
//
//// 2. Async/Await 方式使用
//Task {
//    do {
//        let manager = BLEManager()
//        try await manager.connectDeviceAsync(deviceName: "MyDevice")
//    } catch {
//        print("操作失败：\(error)")
//    }
//}
