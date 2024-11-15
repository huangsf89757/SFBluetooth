//
//  SFBlePeripheralLogPlugin.swift
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

// MARK: - SFBlePeripheralLogOption
public struct SFBlePeripheralLogOption: OptionSet {
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let readRSSI = Self(rawValue: 1 << 0)
    public static let discoverServices = Self(rawValue: 1 << 1)
    public static let discoverIncludedServices = Self(rawValue: 1 << 2)
    public static let discoverCharacteristics = Self(rawValue: 1 << 3)
    public static let readCharacteristicValue = Self(rawValue: 1 << 4)
    public static let getMaximumWriteValueLength = Self(rawValue: 1 << 5)
    public static let writeCharacteristicValue = Self(rawValue: 1 << 6)
    public static let setCharacteristicNotificationState = Self(rawValue: 1 << 7)
    public static let discoverDescriptors = Self(rawValue: 1 << 8)
    public static let readDescriptorValue = Self(rawValue: 1 << 9)
    public static let writeDescriptorValue = Self(rawValue: 1 << 10)
    public static let openL2CAPChannel = Self(rawValue: 1 << 11)
    public static let didUpdateState = Self(rawValue: 1 << 12)
    public static let didUpdateName = Self(rawValue: 1 << 13)
    public static let didModifyServices = Self(rawValue: 1 << 14)
    public static let didUpdateRSSI = Self(rawValue: 1 << 15)
    public static let didReadRSSI = Self(rawValue: 1 << 16)
    public static let didDiscoverServices = Self(rawValue: 1 << 16)
    public static let didDiscoverIncludedServices = Self(rawValue: 1 << 18)
    public static let didDiscoverCharacteristics = Self(rawValue: 1 << 19)
    public static let didUpdateCharacteristicValue = Self(rawValue: 1 << 20)
    public static let didWriteCharacteristicValue = Self(rawValue: 1 << 21)
    public static let didUpdateCharacteristicNotificationState = Self(rawValue: 1 << 22)
    public static let didDiscoverDescriptors = Self(rawValue: 1 << 23)
    public static let didUpdateDescriptorValue = Self(rawValue: 1 << 24)
    public static let didWriteDescriptorValue = Self(rawValue: 1 << 25)
    public static let isReadyToSendWriteWithoutResponse = Self(rawValue: 1 << 26)
    public static let didOpenL2CAPChannel = Self(rawValue: 1 << 27)
    
    public static let all: Self = [
        .readRSSI,
        .discoverServices,
        .discoverIncludedServices,
        .discoverCharacteristics,
        .readCharacteristicValue,
        .getMaximumWriteValueLength,
        .writeCharacteristicValue,
        .setCharacteristicNotificationState,
        .discoverDescriptors,
        .readDescriptorValue,
        .writeDescriptorValue,
        .openL2CAPChannel,
        .didUpdateState,
        .didUpdateName,
        .didModifyServices,
        .didUpdateRSSI,
        .didReadRSSI,
        .didDiscoverServices,
        .didDiscoverIncludedServices,
        .didDiscoverCharacteristics,
        .didUpdateCharacteristicValue,
        .didWriteCharacteristicValue,
        .didUpdateCharacteristicNotificationState,
        .didDiscoverDescriptors,
        .didUpdateDescriptorValue,
        .didWriteDescriptorValue,
        .isReadyToSendWriteWithoutResponse,
        .didOpenL2CAPChannel,
    ]
    
    public var tag: String {
        var res = [String]()
        if self.contains(.readRSSI) {
            res.append("SF_Peripheral_ReadRSSI")
        }
        if self.contains(.discoverServices) {
            res.append("SF_Peripheral_DiscoverServices")
        }
        if self.contains(.discoverIncludedServices) {
            res.append("SF_Peripheral_DiscoverIncludedServices")
        }
        if self.contains(.discoverCharacteristics) {
            res.append("SF_Peripheral_DiscoverCharacteristics")
        }
        if self.contains(.readCharacteristicValue) {
            res.append("SF_Peripheral_ReadCharacteristicValue")
        }
        if self.contains(.getMaximumWriteValueLength) {
            res.append("SF_Peripheral_GetMaximumWriteValueLength")
        }
        if self.contains(.writeCharacteristicValue) {
            res.append("SF_Peripheral_WriteCharacteristicValue")
        }
        if self.contains(.setCharacteristicNotificationState) {
            res.append("SF_Peripheral_SetCharacteristicNotificationState")
        }
        if self.contains(.discoverDescriptors) {
            res.append("SF_Peripheral_DiscoverDescriptors")
        }
        if self.contains(.readDescriptorValue) {
            res.append("SF_Peripheral_ReadDescriptorValue")
        }
        if self.contains(.writeDescriptorValue) {
            res.append("SF_Peripheral_WriteDescriptorValue")
        }
        if self.contains(.openL2CAPChannel) {
            res.append("SF_Peripheral_OpenL2CAPChannel")
        }
        if self.contains(.didUpdateState) {
            res.append("SF_Peripheral_DidUpdateState")
        }
        if self.contains(.didUpdateName) {
            res.append("SF_Peripheral_DidUpdateName")
        }
        if self.contains(.didModifyServices) {
            res.append("SF_Peripheral_DidModifyServices")
        }
        if self.contains(.didUpdateRSSI) {
            res.append("SF_Peripheral_DidUpdateRSSI")
        }
        if self.contains(.didReadRSSI) {
            res.append("SF_Peripheral_DidReadRSSI")
        }
        if self.contains(.didDiscoverServices) {
            res.append("SF_Peripheral_DidDiscoverServices")
        }
        if self.contains(.didDiscoverIncludedServices) {
            res.append("SF_Peripheral_DidDiscoverIncludedServices")
        }
        if self.contains(.didDiscoverCharacteristics) {
            res.append("SF_Peripheral_DidDiscoverCharacteristics")
        }
        if self.contains(.didUpdateCharacteristicValue) {
            res.append("SF_Peripheral_DidUpdateCharacteristicValue")
        }
        if self.contains(.didWriteCharacteristicValue) {
            res.append("SF_Peripheral_DidWriteCharacteristicValue")
        }
        if self.contains(.didUpdateCharacteristicNotificationState) {
            res.append("SF_Peripheral_DidUpdateCharacteristicNotificationState")
        }
        if self.contains(.didDiscoverDescriptors) {
            res.append("SF_Peripheral_DidDiscoverDescriptors")
        }
        if self.contains(.didUpdateDescriptorValue) {
            res.append("SF_Peripheral_DidUpdateDescriptorValue")
        }
        if self.contains(.didWriteDescriptorValue) {
            res.append("SF_Peripheral_DidWriteDescriptorValue")
        }
        if self.contains(.isReadyToSendWriteWithoutResponse) {
            res.append("SF_Peripheral_IsReadyToSendWriteWithoutResponse")
        }
        if self.contains(.didOpenL2CAPChannel) {
            res.append("SF_Peripheral_DidOpenL2CAPChannel")
        }
        return res.joined(separator: " ,")
    }
}


// MARK: - SFBlePeripheralLogPlugin
public class SFBlePeripheralLogPlugin {
    public var opts: SFBlePeripheralLogOption = .all
}


// MARK: - SFBlePeripheralPlugin
extension SFBlePeripheralLogPlugin: SFBlePeripheralPlugin {
    public func readRSSI(peripheral: CBPeripheral) {
        let opt: SFBlePeripheralLogOption = .readRSSI
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        Log.bleTry(tag: opt.tag,
                   msgs: [msg_peripheral],
                   result: nil)
    }
    
    public func discoverServices(peripheral: CBPeripheral, serviceUUIDs: [CBUUID]?) {
        let opt: SFBlePeripheralLogOption = .discoverServices
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        var msg_serviceUUIDs = "serviceUUIDs=nil"
        if let serviceUUIDs = serviceUUIDs {
            msg_serviceUUIDs = "serviceUUIDs=\(serviceUUIDs)"
        }
        Log.bleTry(tag: opt.tag,
                   msgs: [msg_peripheral, msg_serviceUUIDs],
                   result: nil)
    }
    
    public func discoverIncludedServices(peripheral: CBPeripheral, includedServiceUUIDs: [CBUUID]?, service: CBService) {
        let opt: SFBlePeripheralLogOption = .discoverIncludedServices
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_service = "service=\(service.sf.description)"
        var msg_includedServiceUUIDs = "includedServiceUUIDs=nil"
        if let includedServiceUUIDs = includedServiceUUIDs {
            msg_includedServiceUUIDs = "includedServiceUUIDs=\(includedServiceUUIDs)"
        }
        Log.bleTry(tag: opt.tag,
                   msgs: [msg_peripheral, msg_service, msg_includedServiceUUIDs],
                   result: nil)
    }
    
    public func discoverCharacteristics(peripheral: CBPeripheral, characteristicUUIDs: [CBUUID]?, service: CBService) {
        let opt: SFBlePeripheralLogOption = .discoverCharacteristics
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_service = "service=\(service.sf.description)"
        var msg_characteristicUUIDs = "characteristicUUIDs=nil"
        if let characteristicUUIDs = characteristicUUIDs {
            msg_characteristicUUIDs = "characteristicUUIDs=\(characteristicUUIDs)"
        }
        Log.bleTry(tag: opt.tag,
                   msgs: [msg_peripheral, msg_service, msg_characteristicUUIDs],
                   result: nil)
    }
    
    public func readCharacteristicValue(peripheral: CBPeripheral, characteristic: CBCharacteristic) {
        let opt: SFBlePeripheralLogOption = .readCharacteristicValue
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_characteristic = "characteristic=\(characteristic.sf.description)"
        Log.bleTry(tag: opt.tag,
                   msgs: [msg_peripheral, msg_characteristic],
                   result: nil)
    }
    
    @available(iOS 9.0, *)
    public func getMaximumWriteValueLength(peripheral: CBPeripheral, type: CBCharacteristicWriteType, length: Int) {
        let opt: SFBlePeripheralLogOption = .getMaximumWriteValueLength
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_type = "type=\(type.sf.description)"
        let msg_length = "length=\(length)"
        Log.bleTry(tag: opt.tag,
                   msgs: [msg_peripheral, msg_type],
                   result: msg_length)
    }
    
    public func writeCharacteristicValue(peripheral: CBPeripheral, data: Data, characteristic: CBCharacteristic, type: CBCharacteristicWriteType) {
        let opt: SFBlePeripheralLogOption = .writeCharacteristicValue
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_characteristic = "characteristic=\(characteristic.sf.description)"
        let msg_type = "type=\(type.sf.description)"
        let msg_data = "data=\(data.sf.toHex())"
        Log.bleTry(tag: opt.tag,
                   msgs: [msg_peripheral, msg_characteristic, msg_type, msg_data],
                   result: nil)
    }
    
    public func setCharacteristicNotificationState(peripheral: CBPeripheral, enabled: Bool, characteristic: CBCharacteristic) {
        let opt: SFBlePeripheralLogOption = .setCharacteristicNotificationState
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_characteristic = "characteristic=\(characteristic.sf.description)"
        let msg_enabled = "enabled=\(enabled)"
        Log.bleTry(tag: opt.tag,
                   msgs: [msg_peripheral, msg_characteristic, msg_enabled],
                   result: nil)
    }
    
    public func discoverDescriptors(peripheral: CBPeripheral, characteristic: CBCharacteristic) {
        let opt: SFBlePeripheralLogOption = .discoverDescriptors
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_characteristic = "characteristic=\(characteristic.sf.description)"
        Log.bleTry(tag: opt.tag,
                   msgs: [msg_peripheral, msg_characteristic],
                   result: nil)
    }
    
    public func readDescriptorValue(peripheral: CBPeripheral, descriptor: CBDescriptor) {
        let opt: SFBlePeripheralLogOption = .readDescriptorValue
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_descriptor = "descriptor=\(descriptor.sf.description)"
        Log.bleTry(tag: opt.tag,
                   msgs: [msg_peripheral, msg_descriptor],
                   result: nil)
    }
    
    public func writeDescriptorValue(peripheral: CBPeripheral, data: Data, descriptor: CBDescriptor) {
        let opt: SFBlePeripheralLogOption = .writeDescriptorValue
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_descriptor = "descriptor=\(descriptor.sf.description)"
        let msg_data = "data=\(data.sf.toHex())"
        Log.bleTry(tag: opt.tag,
                   msgs: [msg_peripheral, msg_descriptor, msg_data],
                   result: nil)
    }
    
    @available(iOS 11.0, *)
    public func openL2CAPChannel(peripheral: CBPeripheral, PSM: CBL2CAPPSM) {
        let opt: SFBlePeripheralLogOption = .openL2CAPChannel
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_PSM = "PSM=\(PSM)"
        Log.bleTry(tag: opt.tag,
                   msgs: [msg_peripheral, msg_PSM],
                   result: nil)
    }
    
    public func didUpdateState(peripheral: CBPeripheral, state: CBPeripheralState) {
        let opt: SFBlePeripheralLogOption = .didUpdateState
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_state = "state=\(state.sf.description)"
        Log.bleCallback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_state])
    }
    
    @available(iOS 6.0, *)
    public func didUpdateName(peripheral: CBPeripheral, name: String?) {
        let opt: SFBlePeripheralLogOption = .didUpdateName
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_name = "name=\(name)"
        Log.bleCallback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_name])
    }
    
    @available(iOS 7.0, *)
    public func didModifyServices(peripheral: CBPeripheral, invalidatedServices: [CBService]) {
        let opt: SFBlePeripheralLogOption = .didModifyServices
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        var msg_invalidatedServices = "invalidatedServices=["
        for invalidatedService in invalidatedServices {
            msg_invalidatedServices.append(invalidatedService.sf.description)
        }
        msg_invalidatedServices.append("]")
        Log.bleCallback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_invalidatedServices])
    }
    
    @available(iOS, introduced: 5.0, deprecated: 8.0)
    public func didUpdateRSSI(peripheral: CBPeripheral, RSSI: NSNumber?, error: (any Error)?) {
        let opt: SFBlePeripheralLogOption = .didUpdateRSSI
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_RSSI = "RSSI=\(RSSI)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_RSSI, msg_error])
    }
    
    @available(iOS 8.0, *)
    public func didReadRSSI(peripheral: CBPeripheral, RSSI: NSNumber, error: (any Error)?) {
        let opt: SFBlePeripheralLogOption = .didReadRSSI
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_RSSI = "RSSI=\(RSSI)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_RSSI, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func didDiscoverServices(peripheral: CBPeripheral, error: (any Error)?) {
        let opt: SFBlePeripheralLogOption = .didDiscoverServices
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func didDiscoverIncludedServices(peripheral: CBPeripheral, service: CBService, error: (any Error)?) {
        let opt: SFBlePeripheralLogOption = .didDiscoverIncludedServices
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_service = "service=\(service.sf.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_service, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func didDiscoverCharacteristics(peripheral: CBPeripheral, service: CBService, error: (any Error)?) {
        let opt: SFBlePeripheralLogOption = .didDiscoverCharacteristics
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_service = "service=\(service.sf.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_service, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func didUpdateCharacteristicValue(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: (any Error)?) {
        let opt: SFBlePeripheralLogOption = .didUpdateCharacteristicValue
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_characteristic = "characteristic=\(characteristic.sf.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_characteristic, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func didWriteCharacteristicValue(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: (any Error)?) {
        let opt: SFBlePeripheralLogOption = .didWriteCharacteristicValue
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_characteristic = "characteristic=\(characteristic.sf.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_characteristic, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func didUpdateCharacteristicNotificationState(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: (any Error)?) {
        let opt: SFBlePeripheralLogOption = .didUpdateCharacteristicNotificationState
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_characteristic = "characteristic=\(characteristic.sf.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_characteristic, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func didDiscoverDescriptors(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: (any Error)?) {
        let opt: SFBlePeripheralLogOption = .didDiscoverDescriptors
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_characteristic = "characteristic=\(characteristic.sf.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_characteristic, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func didUpdateDescriptorValue(peripheral: CBPeripheral, descriptor: CBDescriptor, error: (any Error)?) {
        let opt: SFBlePeripheralLogOption = .didUpdateDescriptorValue
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_descriptor = "descriptor=\(descriptor.sf.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_descriptor, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func didWriteDescriptorValue(peripheral: CBPeripheral, descriptor: CBDescriptor, error: (any Error)?) {
        let opt: SFBlePeripheralLogOption = .didWriteDescriptorValue
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_descriptor = "descriptor=\(descriptor.sf.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_descriptor, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func isReadyToSendWriteWithoutResponse(peripheral: CBPeripheral) {
        let opt: SFBlePeripheralLogOption = .isReadyToSendWriteWithoutResponse
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        Log.bleCallback(tag: opt.tag,
                        msgs: [msg_peripheral])
    }
    
    @available(iOS 11.0, *)
    public func didOpenL2CAPChannel(peripheral: CBPeripheral, channel: CBL2CAPChannel?, error: (any Error)?) {
        let opt: SFBlePeripheralLogOption = .didOpenL2CAPChannel
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        var msg_channel = "channel=nil"
        if let channel = channel {
            msg_channel = "channel=\(channel.description)"
        }
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_channel, msg_error])
    }
}
