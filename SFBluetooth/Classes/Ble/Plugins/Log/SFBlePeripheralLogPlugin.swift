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
    
    public static let stateDidUpdated =                             Self(rawValue: 1 << 0)
    public static let nameDidUpdated =                              Self(rawValue: 1 << 1)
    public static let servicesDidModified =                         Self(rawValue: 1 << 2)
    public static let RSSIDidUpdated =                              Self(rawValue: 1 << 3)
    public static let isReadyToSendWriteWithoutResponse =           Self(rawValue: 1 << 4)
    public static let readRSSIStart =                               Self(rawValue: 1 << 5)
    public static let readRSSISuccess =                             Self(rawValue: 1 << 6)
    public static let discoverServicesStart =                       Self(rawValue: 1 << 7)
    public static let discoverServicesSuccess =                     Self(rawValue: 1 << 8)
    public static let discoverIncludedServicesStart =               Self(rawValue: 1 << 9)
    public static let discoverIncludedServicesSuccess =             Self(rawValue: 1 << 10)
    public static let discoverCharacteristicsStart =                Self(rawValue: 1 << 11)
    public static let discoverCharacteristicsSuccess =              Self(rawValue: 1 << 12)
    public static let discoverDescriptorsStart =                    Self(rawValue: 1 << 13)
    public static let discoverDescriptorsSuccess =                  Self(rawValue: 1 << 14)
    public static let setCharacteristicNotificationStateStart =     Self(rawValue: 1 << 15)
    public static let setCharacteristicNotificationStateSuccess =   Self(rawValue: 1 << 16)
    public static let getMaximumWriteValueLength =                  Self(rawValue: 1 << 16)
    public static let readCharacteristicValueStart =                Self(rawValue: 1 << 18)
    public static let readCharacteristicValueSuccess =              Self(rawValue: 1 << 19)
    public static let writeCharacteristicValueStart =               Self(rawValue: 1 << 20)
    public static let writeCharacteristicValueSuccess =             Self(rawValue: 1 << 21)
    public static let readDescriptorValueStart =                    Self(rawValue: 1 << 22)
    public static let readDescriptorValueSuccess =                  Self(rawValue: 1 << 23)
    public static let writeDescriptorValueStart =                   Self(rawValue: 1 << 24)
    public static let writeDescriptorValueSuccess =                 Self(rawValue: 1 << 25)
    public static let openL2CAPChannelStart =                       Self(rawValue: 1 << 26)
    public static let openL2CAPChannelSuccess =                     Self(rawValue: 1 << 27)
    
    public static let all: Self = [.stateDidUpdated, .nameDidUpdated, .servicesDidModified, .RSSIDidUpdated, .isReadyToSendWriteWithoutResponse, .readRSSIStart, .readRSSISuccess, .discoverServicesStart, .discoverServicesSuccess, .discoverIncludedServicesStart, .discoverIncludedServicesSuccess, .discoverCharacteristicsStart, .discoverCharacteristicsSuccess, .discoverDescriptorsStart, .discoverDescriptorsSuccess, .setCharacteristicNotificationStateStart, .setCharacteristicNotificationStateSuccess, .getMaximumWriteValueLength, .readCharacteristicValueStart, .readCharacteristicValueSuccess, .writeCharacteristicValueStart, .writeCharacteristicValueSuccess, .readDescriptorValueStart, .readDescriptorValueSuccess, .writeDescriptorValueStart, .writeDescriptorValueSuccess, .openL2CAPChannelStart, .openL2CAPChannelSuccess]
}


// MARK: - SFBlePeripheralLogPlugin
public class SFBlePeripheralLogPlugin {
    public var option: SFBlePeripheralLogOption = .all
}


// MARK: - SFBlePeripheralPlugin
extension SFBlePeripheralLogPlugin: SFBlePeripheralPlugin {
    public func peripheral(_ peripheral: CBPeripheral, readRSSI id: UUID) {
        guard option.contains(.readRSSIStart) else { return }
        let msg_tag = SF_Tag_Peripheral_ReadRSSI_Start
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        Log.bleTry(id: id, tag: SF_Tag_Peripheral_ReadRSSI_Start,
                   msgs: [msg_peripheral],
                   result: nil)
    }
    
    public func peripheral(_ peripheral: CBPeripheral, discoverServices id: UUID, serviceUUIDs: [CBUUID]?) {
        guard option.contains(.discoverServicesStart) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        var msg_serviceUUIDs = "serviceUUIDs=nil"
        if let serviceUUIDs = serviceUUIDs {
            msg_serviceUUIDs = "serviceUUIDs=\(serviceUUIDs)"
        }
        Log.bleTry(id: id, tag: SF_Tag_Peripheral_DiscoverServices_Start,
                   msgs: [msg_peripheral, msg_serviceUUIDs],
                   result: nil)
    }
    
    public func peripheral(_ peripheral: CBPeripheral, discoverIncludedServices id: UUID, includedServiceUUIDs: [CBUUID]?, for service: CBService) {
        guard option.contains(.discoverIncludedServicesStart) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_service = "service=\(service.sf.description)"
        var msg_includedServiceUUIDs = "includedServiceUUIDs=nil"
        if let includedServiceUUIDs = includedServiceUUIDs {
            msg_includedServiceUUIDs = "includedServiceUUIDs=\(includedServiceUUIDs)"
        }
        Log.bleTry(id: id, tag: SF_Tag_Peripheral_DiscoverIncludedServices_Start,
                   msgs: [msg_peripheral, msg_service, msg_includedServiceUUIDs],
                   result: nil)
    }
    
    public func peripheral(_ peripheral: CBPeripheral, discoverCharacteristics id: UUID, characteristicUUIDs: [CBUUID]?, for service: CBService) {
        guard option.contains(.discoverCharacteristicsStart) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_service = "service=\(service.sf.description)"
        var msg_characteristicUUIDs = "characteristicUUIDs=nil"
        if let characteristicUUIDs = characteristicUUIDs {
            msg_characteristicUUIDs = "characteristicUUIDs=\(characteristicUUIDs)"
        }
        Log.bleTry(id: id, tag: SF_Tag_Peripheral_DiscoverCharacteristics_Start,
                   msgs: [msg_peripheral, msg_service, msg_characteristicUUIDs],
                   result: nil)
    }
    
    public func peripheral(_ peripheral: CBPeripheral, readValue id: UUID, for characteristic: CBCharacteristic) {
        guard option.contains(.readCharacteristicValueStart) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_characteristic = "characteristic=\(characteristic.sf.description)"
        Log.bleTry(id: id, tag: SF_Tag_Peripheral_ReadCharacteristicValue_Start,
                   msgs: [msg_peripheral, msg_characteristic],
                   result: nil)
    }
    
    @available(iOS 9.0, *)
    public func peripheral(_ peripheral: CBPeripheral, getMaximumWriteValueLength id: UUID, for type: CBCharacteristicWriteType, return length: Int) {
        guard option.contains(.getMaximumWriteValueLength) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_type = "type=\(type.sf.description)"
        let msg_length = "length=\(length)"
        Log.bleTry(id: id, tag: SF_Tag_Peripheral_GetMaximumWriteValueLength,
                   msgs: [msg_peripheral, msg_type],
                   result: msg_length)
    }
    
    public func peripheral(_ peripheral: CBPeripheral, writeValue id: UUID, data: Data, for characteristic: CBCharacteristic, type: CBCharacteristicWriteType) {
        guard option.contains(.writeCharacteristicValueStart) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_characteristic = "characteristic=\(characteristic.sf.description)"
        let msg_type = "type=\(type.sf.description)"
        let msg_data = "data=\(data.sf.toHex())"
        Log.bleTry(id: id, tag: SF_Tag_Peripheral_WriteCharacteristicValue_Start,
                   msgs: [msg_peripheral, msg_characteristic, msg_type, msg_data],
                   result: nil)
    }
    
    public func peripheral(_ peripheral: CBPeripheral, setNotifyValue id: UUID, enabled: Bool, for characteristic: CBCharacteristic) {
        guard option.contains(.setCharacteristicNotificationStateStart) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_characteristic = "characteristic=\(characteristic.sf.description)"
        let msg_enabled = "enabled=\(enabled)"
        Log.bleTry(id: id, tag: SF_Tag_Peripheral_SetCharacteristicNotificationState_Start,
                   msgs: [msg_peripheral, msg_characteristic, msg_enabled],
                   result: nil)
    }
    
    public func peripheral(_ peripheral: CBPeripheral, discoverDescriptors id: UUID, for characteristic: CBCharacteristic) {
        guard option.contains(.discoverDescriptorsStart) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_characteristic = "characteristic=\(characteristic.sf.description)"
        Log.bleTry(id: id, tag: SF_Tag_Peripheral_DiscoverDescriptors_Start,
                   msgs: [msg_peripheral, msg_characteristic],
                   result: nil)
    }
    
    public func peripheral(_ peripheral: CBPeripheral, readValue id: UUID, for descriptor: CBDescriptor) {
        guard option.contains(.readDescriptorValueStart) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_descriptor = "descriptor=\(descriptor.sf.description)"
        Log.bleTry(id: id, tag: SF_Tag_Peripheral_ReadDescriptorValue_Start,
                   msgs: [msg_peripheral, msg_descriptor],
                   result: nil)
    }
    
    public func peripheral(_ peripheral: CBPeripheral, writeValue id: UUID, data: Data, for descriptor: CBDescriptor) {
        guard option.contains(.writeDescriptorValueStart) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_descriptor = "descriptor=\(descriptor.sf.description)"
        let msg_data = "data=\(data.sf.toHex())"
        Log.bleTry(id: id, tag: SF_Tag_Peripheral_WriteDescriptorValue_Start,
                   msgs: [msg_peripheral, msg_descriptor, msg_data],
                   result: nil)
    }
    
    @available(iOS 11.0, *)
    public func peripheral(_ peripheral: CBPeripheral, openL2CAPChannel id: UUID, PSM: CBL2CAPPSM) {
        guard option.contains(.openL2CAPChannelStart) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_PSM = "PSM=\(PSM)"
        Log.bleTry(id: id, tag: SF_Tag_Peripheral_OpenL2CAPChannel_Start,
                   msgs: [msg_peripheral, msg_PSM],
                   result: nil)
    }
    
    public func peripheral(_ peripheral: CBPeripheral, didUpdateState id: UUID, state: CBPeripheralState) {
        guard option.contains(.stateDidUpdated) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_state = "state=\(state.sf.description)"
        Log.bleCallback(id: id, tag: SF_Tag_Peripheral_State_DidUpdated,
                        msgs: [msg_peripheral, msg_state])
    }
    
    @available(iOS 6.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didUpdateName id: UUID, name: String?) {
        guard option.contains(.nameDidUpdated) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_name = "name=\(name)"
        Log.bleCallback(id: id, tag: SF_Tag_Peripheral_Name_DidUpdated,
                        msgs: [msg_peripheral, msg_name])
    }
    
    @available(iOS 7.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didModifyServices id: UUID, invalidatedServices: [CBService]) {
        guard option.contains(.servicesDidModified) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        var msg_invalidatedServices = "invalidatedServices=["
        for invalidatedService in invalidatedServices {
            msg_invalidatedServices.append(invalidatedService.sf.description)
        }
        msg_invalidatedServices.append("]")
        Log.bleCallback(id: id, tag: SF_Tag_Peripheral_Services_DidModified,
                        msgs: [msg_peripheral, msg_invalidatedServices])
    }
    
    @available(iOS, introduced: 5.0, deprecated: 8.0)
    public func peripheral(_ peripheral: CBPeripheral, didUpdateRSSI id: UUID, RSSI: NSNumber?, error: (any Error)?) {
        guard option.contains(.RSSIDidUpdated) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_RSSI = "RSSI=\(RSSI)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(id: id, tag: SF_Tag_Peripheral_RSSI_DidUpdated,
                        msgs: [msg_peripheral, msg_RSSI, msg_error])
    }
    
    @available(iOS 8.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didReadRSSI id: UUID, RSSI: NSNumber, error: (any Error)?) {
        guard option.contains(.readRSSISuccess) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_RSSI = "RSSI=\(RSSI)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(id: id, tag: SF_Tag_Peripheral_ReadRSSI_Success,
                        msgs: [msg_peripheral, msg_RSSI, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverServices id: UUID, error: (any Error)?) {
        guard option.contains(.discoverServicesSuccess) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(id: id, tag: SF_Tag_Peripheral_DiscoverServices_Success,
                        msgs: [msg_peripheral, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverIncludedServices id: UUID, for service: CBService, error: (any Error)?) {
        guard option.contains(.discoverIncludedServicesSuccess) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_service = "service=\(service.sf.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(id: id, tag: SF_Tag_Peripheral_DiscoverIncludedServices_Success,
                        msgs: [msg_peripheral, msg_service, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristics id: UUID, for service: CBService, error: (any Error)?) {
        guard option.contains(.discoverCharacteristicsSuccess) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_service = "service=\(service.sf.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(id: id, tag: SF_Tag_Peripheral_DiscoverCharacteristics_Success,
                        msgs: [msg_peripheral, msg_service, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didUpdateValue id: UUID, for characteristic: CBCharacteristic, error: (any Error)?) {
        guard option.contains(.readCharacteristicValueSuccess) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_characteristic = "characteristic=\(characteristic.sf.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(id: id, tag: SF_Tag_Peripheral_ReadCharacteristicValue_Success,
                        msgs: [msg_peripheral, msg_characteristic, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didWriteValue id: UUID, for characteristic: CBCharacteristic, error: (any Error)?) {
        guard option.contains(.writeCharacteristicValueSuccess) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_characteristic = "characteristic=\(characteristic.sf.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(id: id, tag: SF_Tag_Peripheral_WriteCharacteristicValue_Success,
                        msgs: [msg_peripheral, msg_characteristic, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationState id: UUID, for characteristic: CBCharacteristic, error: (any Error)?) {
        guard option.contains(.setCharacteristicNotificationStateSuccess) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_characteristic = "characteristic=\(characteristic.sf.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(id: id, tag: SF_Tag_Peripheral_SetCharacteristicNotificationState_Success,
                        msgs: [msg_peripheral, msg_characteristic, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptors id: UUID, for characteristic: CBCharacteristic, error: (any Error)?) {
        guard option.contains(.discoverDescriptorsSuccess) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_characteristic = "characteristic=\(characteristic.sf.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(id: id, tag: SF_Tag_Peripheral_DiscoverDescriptors_Success,
                        msgs: [msg_peripheral, msg_characteristic, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didUpdateValue id: UUID, for descriptor: CBDescriptor, error: (any Error)?) {
        guard option.contains(.readDescriptorValueSuccess) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_descriptor = "descriptor=\(descriptor.sf.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(id: id, tag: SF_Tag_Peripheral_ReadDescriptorValue_Success,
                        msgs: [msg_peripheral, msg_descriptor, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didWriteValue id: UUID, for descriptor: CBDescriptor, error: (any Error)?) {
        guard option.contains(.writeDescriptorValueSuccess) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        let msg_descriptor = "descriptor=\(descriptor.sf.description)"
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(id: id, tag: SF_Tag_Peripheral_WriteDescriptorValue_Success,
                        msgs: [msg_peripheral, msg_descriptor, msg_error])
    }
    
    @available(iOS 5.0, *)
    public func peripheral(_ peripheral: CBPeripheral, isReadyToSendWriteWithoutResponse id: UUID) {
        guard option.contains(.isReadyToSendWriteWithoutResponse) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        Log.bleCallback(id: id, tag: SF_Tag_Peripheral_IsReadyToSendWriteWithoutResponse,
                        msgs: [msg_peripheral])
    }
    
    @available(iOS 11.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didOpen id: UUID, channel: CBL2CAPChannel?, error: (any Error)?) {
        guard option.contains(.openL2CAPChannelSuccess) else { return }
        let msg_peripheral = "peripheral=\(peripheral.sf.description)"
        var msg_channel = "channel=nil"
        if let channel = channel {
            msg_channel = "channel=\(channel.description)"
        }
        var msg_error = "error=nil"
        if let error = error {
            msg_error = "error=\(error.localizedDescription)"
        }
        Log.bleCallback(id: id, tag: SF_Tag_Peripheral_OpenL2CAPChannel_Success,
                        msgs: [msg_peripheral, msg_channel, msg_error])
    }
}
