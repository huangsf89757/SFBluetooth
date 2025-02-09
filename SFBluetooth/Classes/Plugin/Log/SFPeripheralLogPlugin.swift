//
//  SFPeripheralLogPlugin.swift
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

// MARK: - SFPeripheralLogOption
public struct SFPeripheralLogOption: OptionSet {
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


// MARK: - SFPeripheralLogPlugin
public class SFPeripheralLogPlugin {
    public var opts: SFPeripheralLogOption = .all
}


// MARK: - SFPeripheralPlugin
extension SFPeripheralLogPlugin: SFPeripheralPlugin {
    public func readRSSI(peripheral: CBPeripheral) {
        let opt: SFPeripheralLogOption = .readRSSI
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        SFBleLogger.tryDo(tag: opt.tag,
                   msgs: [msg_peripheral],
                   result: nil)
    }
    
    public func discoverServices(peripheral: CBPeripheral, serviceUUIDs: [CBUUID]?) {
        let opt: SFPeripheralLogOption = .discoverServices
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        var msg_serviceUUIDs = "serviceUUIDs=nil"
        if let serviceUUIDs = serviceUUIDs {
            msg_serviceUUIDs = "serviceUUIDs=\(serviceUUIDs)"
        }
        SFBleLogger.tryDo(tag: opt.tag,
                   msgs: [msg_peripheral, msg_serviceUUIDs],
                   result: nil)
    }
    
    public func discoverIncludedServices(peripheral: CBPeripheral, includedServiceUUIDs: [CBUUID]?, service: CBService) {
        let opt: SFPeripheralLogOption = .discoverIncludedServices
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        let msg_service = "service=\(service.description)"
        var msg_includedServiceUUIDs = "includedServiceUUIDs=nil"
        if let includedServiceUUIDs = includedServiceUUIDs {
            msg_includedServiceUUIDs = "includedServiceUUIDs=\(includedServiceUUIDs)"
        }
        SFBleLogger.tryDo(tag: opt.tag,
                   msgs: [msg_peripheral, msg_service, msg_includedServiceUUIDs],
                   result: nil)
    }
    
    public func discoverCharacteristics(peripheral: CBPeripheral, characteristicUUIDs: [CBUUID]?, service: CBService) {
        let opt: SFPeripheralLogOption = .discoverCharacteristics
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        let msg_service = "service=\(service.description)"
        var msg_characteristicUUIDs = "characteristicUUIDs=nil"
        if let characteristicUUIDs = characteristicUUIDs {
            msg_characteristicUUIDs = "characteristicUUIDs=\(characteristicUUIDs)"
        }
        SFBleLogger.tryDo(tag: opt.tag,
                   msgs: [msg_peripheral, msg_service, msg_characteristicUUIDs],
                   result: nil)
    }
    
    public func readCharacteristicValue(peripheral: CBPeripheral, characteristic: CBCharacteristic) {
        let opt: SFPeripheralLogOption = .readCharacteristicValue
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        let msg_characteristic = "characteristic=\(characteristic.description)"
        SFBleLogger.tryDo(tag: opt.tag,
                   msgs: [msg_peripheral, msg_characteristic],
                   result: nil)
    }
    
    @available(iOS 9.0, *)
    public func getMaximumWriteValueLength(peripheral: CBPeripheral, type: CBCharacteristicWriteType, length: Int) {
        let opt: SFPeripheralLogOption = .getMaximumWriteValueLength
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        let msg_type = "type=\(type.description)"
        let msg_length = "length=\(length)"
        SFBleLogger.tryDo(tag: opt.tag,
                   msgs: [msg_peripheral, msg_type],
                   result: msg_length)
    }
    
    public func writeCharacteristicValue(peripheral: CBPeripheral, data: Data, characteristic: CBCharacteristic, type: CBCharacteristicWriteType) {
        let opt: SFPeripheralLogOption = .writeCharacteristicValue
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        let msg_characteristic = "characteristic=\(characteristic.description)"
        let msg_type = "type=\(type.description)"
        let msg_data = "data=\(data.sf.toHex())"
        SFBleLogger.tryDo(tag: opt.tag,
                   msgs: [msg_peripheral, msg_characteristic, msg_type, msg_data],
                   result: nil)
    }
    
    public func setCharacteristicNotificationState(peripheral: CBPeripheral, enabled: Bool, characteristic: CBCharacteristic) {
        let opt: SFPeripheralLogOption = .setCharacteristicNotificationState
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        let msg_characteristic = "characteristic=\(characteristic.description)"
        let msg_enabled = "enabled=\(enabled)"
        SFBleLogger.tryDo(tag: opt.tag,
                   msgs: [msg_peripheral, msg_characteristic, msg_enabled],
                   result: nil)
    }
    
    public func discoverDescriptors(peripheral: CBPeripheral, characteristic: CBCharacteristic) {
        let opt: SFPeripheralLogOption = .discoverDescriptors
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        let msg_characteristic = "characteristic=\(characteristic.description)"
        SFBleLogger.tryDo(tag: opt.tag,
                   msgs: [msg_peripheral, msg_characteristic],
                   result: nil)
    }
    
    public func readDescriptorValue(peripheral: CBPeripheral, descriptor: CBDescriptor) {
        let opt: SFPeripheralLogOption = .readDescriptorValue
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        let msg_descriptor = "descriptor=\(descriptor.description)"
        SFBleLogger.tryDo(tag: opt.tag,
                   msgs: [msg_peripheral, msg_descriptor],
                   result: nil)
    }
    
    public func writeDescriptorValue(peripheral: CBPeripheral, data: Data, descriptor: CBDescriptor) {
        let opt: SFPeripheralLogOption = .writeDescriptorValue
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        let msg_descriptor = "descriptor=\(descriptor.description)"
        let msg_data = "data=\(data.sf.toHex())"
        SFBleLogger.tryDo(tag: opt.tag,
                   msgs: [msg_peripheral, msg_descriptor, msg_data],
                   result: nil)
    }
    
    @available(iOS 11.0, *)
    public func openL2CAPChannel(peripheral: CBPeripheral, PSM: CBL2CAPPSM) {
        let opt: SFPeripheralLogOption = .openL2CAPChannel
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        let msg_PSM = "PSM=\(PSM)"
        SFBleLogger.tryDo(tag: opt.tag,
                   msgs: [msg_peripheral, msg_PSM],
                   result: nil)
    }
    
    public func didUpdateState(peripheral: CBPeripheral, state: CBPeripheralState) {
        let opt: SFPeripheralLogOption = .didUpdateState
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        let msg_state = "state=\(state.description)"
        SFBleLogger.callback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_state])
    }
    
    @available(iOS 6.0, *)
    public func didUpdateName(peripheral: CBPeripheral, name: String?) {
        let opt: SFPeripheralLogOption = .didUpdateName
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        let msg_name = "name=\(name)"
        SFBleLogger.callback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_name])
    }
    
    @available(iOS 7.0, *)
    public func didModifyServices(peripheral: CBPeripheral, invalidatedServices: [CBService]) {
        let opt: SFPeripheralLogOption = .didModifyServices
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        var msg_invalidatedServices = "invalidatedServices=["
        for invalidatedService in invalidatedServices {
            msg_invalidatedServices.append(invalidatedService.description)
        }
        msg_invalidatedServices.append("]")
        SFBleLogger.callback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_invalidatedServices])
    }
    
    @available(iOS, introduced: 5.0, deprecated: 8.0)
    public func didUpdateRSSI(peripheral: CBPeripheral, RSSI: NSNumber?, error: (any Error)?) {
        let opt: SFPeripheralLogOption = .didUpdateRSSI
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        let msg_RSSI = "RSSI=\(RSSI)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        SFBleLogger.callback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_RSSI, msg_error])
    }
    
    @available(iOS 8.0, *)
    public func didReadRSSI(peripheral: CBPeripheral, RSSI: NSNumber, error: (any Error)?) {
        let opt: SFPeripheralLogOption = .didReadRSSI
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        let msg_RSSI = "RSSI=\(RSSI)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        SFBleLogger.callback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_RSSI, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func didDiscoverServices(peripheral: CBPeripheral, error: (any Error)?) {
        let opt: SFPeripheralLogOption = .didDiscoverServices
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        SFBleLogger.callback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func didDiscoverIncludedServices(peripheral: CBPeripheral, service: CBService, error: (any Error)?) {
        let opt: SFPeripheralLogOption = .didDiscoverIncludedServices
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        let msg_service = "service=\(service.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        SFBleLogger.callback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_service, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func didDiscoverCharacteristics(peripheral: CBPeripheral, service: CBService, error: (any Error)?) {
        let opt: SFPeripheralLogOption = .didDiscoverCharacteristics
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        let msg_service = "service=\(service.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        SFBleLogger.callback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_service, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func didUpdateCharacteristicValue(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: (any Error)?) {
        let opt: SFPeripheralLogOption = .didUpdateCharacteristicValue
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        let msg_characteristic = "characteristic=\(characteristic.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        SFBleLogger.callback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_characteristic, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func didWriteCharacteristicValue(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: (any Error)?) {
        let opt: SFPeripheralLogOption = .didWriteCharacteristicValue
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        let msg_characteristic = "characteristic=\(characteristic.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        SFBleLogger.callback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_characteristic, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func didUpdateCharacteristicNotificationState(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: (any Error)?) {
        let opt: SFPeripheralLogOption = .didUpdateCharacteristicNotificationState
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        let msg_characteristic = "characteristic=\(characteristic.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        SFBleLogger.callback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_characteristic, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func didDiscoverDescriptors(peripheral: CBPeripheral, characteristic: CBCharacteristic, error: (any Error)?) {
        let opt: SFPeripheralLogOption = .didDiscoverDescriptors
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        let msg_characteristic = "characteristic=\(characteristic.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        SFBleLogger.callback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_characteristic, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func didUpdateDescriptorValue(peripheral: CBPeripheral, descriptor: CBDescriptor, error: (any Error)?) {
        let opt: SFPeripheralLogOption = .didUpdateDescriptorValue
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        let msg_descriptor = "descriptor=\(descriptor.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        SFBleLogger.callback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_descriptor, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func didWriteDescriptorValue(peripheral: CBPeripheral, descriptor: CBDescriptor, error: (any Error)?) {
        let opt: SFPeripheralLogOption = .didWriteDescriptorValue
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        let msg_descriptor = "descriptor=\(descriptor.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        SFBleLogger.callback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_descriptor, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func isReadyToSendWriteWithoutResponse(peripheral: CBPeripheral) {
        let opt: SFPeripheralLogOption = .isReadyToSendWriteWithoutResponse
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        SFBleLogger.callback(tag: opt.tag,
                        msgs: [msg_peripheral])
    }
    
    @available(iOS 11.0, *)
    public func didOpenL2CAPChannel(peripheral: CBPeripheral, channel: CBL2CAPChannel?, error: (any Error)?) {
        let opt: SFPeripheralLogOption = .didOpenL2CAPChannel
        guard opts.contains(opt) else { return }
        let msg_peripheral = "peripheral=\(peripheral.description)"
        var msg_channel = "channel=nil"
        if let channel = channel {
            msg_channel = "channel=\(channel.description)"
        }
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        SFBleLogger.callback(tag: opt.tag,
                        msgs: [msg_peripheral, msg_channel, msg_error])
    }
}
