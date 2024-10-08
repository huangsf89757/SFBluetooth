//
//  SFPeripheral.swift
//  SFBluetooth
//
//  Created by hsf on 2024/9/12.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger


// MARK: - Tag
public let SF_Tag_Peripheral_Name_DidUpdated =                                  "SF_Tag_Peripheral_Name_DidUpdated"
public let SF_Tag_Peripheral_Services_DidModified =                             "SF_Tag_Peripheral_Services_DidModified"
public let SF_Tag_Peripheral_RSSI_DidUpdated =                                  "SF_Tag_Peripheral_RSSI_DidUpdated"
public let SF_Tag_Peripheral_IsReadyToSendWriteWithoutResponse =                "SF_Tag_Peripheral_IsReadyToSendWriteWithoutResponse"

public let SF_Tag_Peripheral_ReadRSSI_Start =                                   "SF_Tag_Peripheral_ReadRSSI_Start"
public let SF_Tag_Peripheral_ReadRSSI_Success =                                 "SF_Tag_Peripheral_ReadRSSI_Success"

public let SF_Tag_Peripheral_DiscoverServices_Start =                           "SF_Tag_Peripheral_DiscoverServices_Start"
public let SF_Tag_Peripheral_DiscoverServices_Success =                         "SF_Tag_Peripheral_DiscoverServices_Success"

public let SF_Tag_Peripheral_DiscoverIncludedServices_Start =                   "SF_Tag_Peripheral_DiscoverIncludedServices_Start"
public let SF_Tag_Peripheral_DiscoverIncludedServices_Success =                 "SF_Tag_Peripheral_DiscoverIncludedServices_Success"

public let SF_Tag_Peripheral_DiscoverCharacteristics_Start =                    "SF_Tag_Peripheral_DiscoverCharacteristics_Start"
public let SF_Tag_Peripheral_DiscoverCharacteristics_Success =                  "SF_Tag_Peripheral_DiscoverCharacteristics_Success"

public let SF_Tag_Peripheral_DiscoverDescriptors_Start =                        "SF_Tag_Peripheral_DiscoverDescriptors_Start"
public let SF_Tag_Peripheral_DiscoverDescriptors_Success =                      "SF_Tag_Peripheral_DiscoverDescriptors_Success"

public let SF_Tag_Peripheral_SetCharacteristicNotificationState_Start =         "SF_Tag_Peripheral_SetCharacteristicNotificationState_Start"
public let SF_Tag_Peripheral_SetCharacteristicNotificationState_Success =       "SF_Tag_Peripheral_SetCharacteristicNotificationState_Success"

public let SF_Tag_Peripheral_ReadCharacteristicValue_Start =                    "SF_Tag_Peripheral_ReadCharacteristicValue_Start"
public let SF_Tag_Peripheral_ReadCharacteristicValue_Success =                  "SF_Tag_Peripheral_ReadCharacteristicValue_Success"

public let SF_Tag_Peripheral_WriteCharacteristicValue_Start =                   "SF_Tag_Peripheral_WriteCharacteristicValue_Start"
public let SF_Tag_Peripheral_WriteCharacteristicValue_Success =                 "SF_Tag_Peripheral_WriteCharacteristicValue_Success"

public let SF_Tag_Peripheral_ReadDescriptorValue_Start =                        "SF_Tag_Peripheral_ReadDescriptorValue_Start"
public let SF_Tag_Peripheral_ReadDescriptorValue_Success =                      "SF_Tag_Peripheral_ReadDescriptorValue_Success"

public let SF_Tag_Peripheral_WriteDescriptorValue_Start =                       "SF_Tag_Peripheral_WriteDescriptorValue_Start"
public let SF_Tag_Peripheral_WriteDescriptorValue_Success =                     "SF_Tag_Peripheral_WriteDescriptorValue_Success"

public let SF_Tag_Peripheral_OpenL2CAPChannel_Start =                           "SF_Tag_Peripheral_OpenL2CAPChannel_Start"
public let SF_Tag_Peripheral_OpenL2CAPChannel_Success =                         "SF_Tag_Peripheral_OpenL2CAPChannel_Success"


// MARK: - Notify
public let SF_Notify_Peripheral_Name_DidUpdated =                               NSNotification.Name("SF_Notify_Peripheral_Name_DidUpdated")
public let SF_Notify_Peripheral_Services_DidModified =                          NSNotification.Name("SF_Notify_Peripheral_Services_DidModified")
public let SF_Notify_Peripheral_RSSI_DidUpdated =                               NSNotification.Name("SF_Notify_Peripheral_RSSI_DidUpdated")
public let SF_Notify_Peripheral_IsReadyToSendWriteWithoutResponse =             NSNotification.Name("SF_Notify_Peripheral_IsReadyToSendWriteWithoutResponse")

public let SF_Notify_Peripheral_ReadRSSI_Start =                                NSNotification.Name("SF_Notify_Peripheral_ReadRSSI_Start")
public let SF_Notify_Peripheral_ReadRSSI_Success =                              NSNotification.Name("SF_Notify_Peripheral_ReadRSSI_Success")

public let SF_Notify_Peripheral_DiscoverServices_Start =                        NSNotification.Name("SF_Notify_Peripheral_DiscoverServices_Start")
public let SF_Notify_Peripheral_DiscoverServices_Success =                      NSNotification.Name("SF_Notify_Peripheral_DiscoverServices_Success")

public let SF_Notify_Peripheral_DiscoverIncludedServices_Start =                NSNotification.Name("SF_Notify_Peripheral_DiscoverIncludedServices_Start")
public let SF_Notify_Peripheral_DiscoverIncludedServices_Success =              NSNotification.Name("SF_Notify_Peripheral_DiscoverIncludedServices_Success")

public let SF_Notify_Peripheral_DiscoverCharacteristics_Start =                 NSNotification.Name("SF_Notify_Peripheral_DiscoverCharacteristics_Start")
public let SF_Notify_Peripheral_DiscoverCharacteristics_Success =               NSNotification.Name("SF_Notify_Peripheral_DiscoverCharacteristics_Success")

public let SF_Notify_Peripheral_DiscoverDescriptors_Start =                     NSNotification.Name("SF_Notify_Peripheral_DiscoverDescriptors_Start")
public let SF_Notify_Peripheral_DiscoverDescriptors_Success =                   NSNotification.Name("SF_Notify_Peripheral_DiscoverDescriptors_Success")

public let SF_Notify_Peripheral_SetCharacteristicNotificationState_Start =      NSNotification.Name("SF_Notify_Peripheral_SetCharacteristicNotificationState_Start")
public let SF_Notify_Peripheral_SetCharacteristicNotificationState_Success =    NSNotification.Name("SF_Notify_Peripheral_SetCharacteristicNotificationState_Success")

public let SF_Notify_Peripheral_ReadCharacteristicValue_Start =                 NSNotification.Name("SF_Notify_Peripheral_ReadCharacteristicValue_Start")
public let SF_Notify_Peripheral_ReadCharacteristicValue_Success =               NSNotification.Name("SF_Notify_Peripheral_ReadCharacteristicValue_Success")

public let SF_Notify_Peripheral_WriteCharacteristicValue_Start =                NSNotification.Name("SF_Notify_Peripheral_WriteCharacteristicValue_Start")
public let SF_Notify_Peripheral_WriteCharacteristicValue_Success =              NSNotification.Name("SF_Notify_Peripheral_WriteCharacteristicValue_Success")

public let SF_Notify_Peripheral_ReadDescriptorValue_Start =                     NSNotification.Name("SF_Notify_Peripheral_ReadDescriptorValue_Start")
public let SF_Notify_Peripheral_ReadDescriptorValue_Success =                   NSNotification.Name("SF_Notify_Peripheral_ReadDescriptorValue_Success")

public let SF_Notify_Peripheral_WriteDescriptorValue_Start =                    NSNotification.Name("SF_Notify_Peripheral_WriteDescriptorValue_Start")
public let SF_Notify_Peripheral_WriteDescriptorValue_Success =                  NSNotification.Name("SF_Notify_Peripheral_WriteDescriptorValue_Success")

public let SF_Notify_Peripheral_OpenL2CAPChannel_Start =                        NSNotification.Name("SF_Notify_Peripheral_OpenL2CAPChannel_Start")
public let SF_Notify_Peripheral_OpenL2CAPChannel_Success =                      NSNotification.Name("SF_Notify_Peripheral_OpenL2CAPChannel_Success")


// MARK: - SFPeripheralLogOption
public struct SFPeripheralLogOption: OptionSet {
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let nameDidUpdated = SFPeripheralLogOption(rawValue: 1 << 0)
    public static let servicesDidModified = SFPeripheralLogOption(rawValue: 1 << 1)
    public static let RSSIDidUpdated = SFPeripheralLogOption(rawValue: 1 << 2)
    public static let isReadyToSendWriteWithoutResponse = SFPeripheralLogOption(rawValue: 1 << 3)
    public static let readRSSIStart = SFPeripheralLogOption(rawValue: 1 << 4)
    public static let readRSSISuccess = SFPeripheralLogOption(rawValue: 1 << 5)
    public static let discoverServicesStart = SFPeripheralLogOption(rawValue: 1 << 6)
    public static let discoverServicesSuccess = SFPeripheralLogOption(rawValue: 1 << 7)
    public static let discoverIncludedServicesStart = SFPeripheralLogOption(rawValue: 1 << 8)
    public static let discoverIncludedServicesSuccess = SFPeripheralLogOption(rawValue: 1 << 9)
    public static let discoverCharacteristicsStart = SFPeripheralLogOption(rawValue: 1 << 10)
    public static let discoverCharacteristicsSuccess = SFPeripheralLogOption(rawValue: 1 << 11)
    public static let discoverDescriptorsStart = SFPeripheralLogOption(rawValue: 1 << 12)
    public static let discoverDescriptorsSuccess = SFPeripheralLogOption(rawValue: 1 << 13)
    public static let setCharacteristicNotificationStateStart = SFPeripheralLogOption(rawValue: 1 << 14)
    public static let setCharacteristicNotificationStateSuccess = SFPeripheralLogOption(rawValue: 1 << 15)
    public static let readCharacteristicValueStart = SFPeripheralLogOption(rawValue: 1 << 16)
    public static let readCharacteristicValueSuccess = SFPeripheralLogOption(rawValue: 1 << 17)
    public static let writeCharacteristicValueStart = SFPeripheralLogOption(rawValue: 1 << 18)
    public static let writeCharacteristicValueSuccess = SFPeripheralLogOption(rawValue: 1 << 19)
    public static let readDescriptorValueStart = SFPeripheralLogOption(rawValue: 1 << 20)
    public static let readDescriptorValueSuccess = SFPeripheralLogOption(rawValue: 1 << 21)
    public static let writeDescriptorValueStart = SFPeripheralLogOption(rawValue: 1 << 22)
    public static let writeDescriptorValueSuccess = SFPeripheralLogOption(rawValue: 1 << 23)
    public static let openL2CAPChannelStart = SFPeripheralLogOption(rawValue: 1 << 24)
    public static let openL2CAPChannelSuccess = SFPeripheralLogOption(rawValue: 1 << 25)

    public static let all: SFPeripheralLogOption = [
        .nameDidUpdated, .servicesDidModified, .RSSIDidUpdated, .isReadyToSendWriteWithoutResponse, .readRSSIStart, .readRSSISuccess, .discoverServicesStart, .discoverServicesSuccess, .discoverIncludedServicesStart, .discoverIncludedServicesSuccess, .discoverCharacteristicsStart, .discoverCharacteristicsSuccess, .discoverDescriptorsStart, .discoverDescriptorsSuccess, .setCharacteristicNotificationStateStart, .setCharacteristicNotificationStateSuccess, .readCharacteristicValueStart, .readCharacteristicValueSuccess, .writeCharacteristicValueStart, .writeCharacteristicValueSuccess, .readDescriptorValueStart, .readDescriptorValueSuccess, .writeDescriptorValueStart, .writeDescriptorValueSuccess, .openL2CAPChannelStart, .openL2CAPChannelSuccess
    ]
}


// MARK: - SFPeripheral
public class SFPeripheral: NSObject {
    // MARK: var
    public let peripheral: CBPeripheral
    public var logOption: SFPeripheralLogOption = .all
    // MARK: life cycle
    public init(peripheral: CBPeripheral) {
        self.peripheral = peripheral
        super.init()
        peripheral.delegate = self
    }
}

extension SFPeripheral {
    /**
     *  @property name
     *
     *  @discussion The name of the peripheral.
     */
    public var name: String? { peripheral.name }

    
    /**
     *  @property RSSI
     *
     *  @discussion The most recently read RSSI, in decibels.
     *
     *  @deprecated Use {@link peripheral:didReadRSSI:error:} instead.
     */
    @available(iOS, introduced: 5.0, deprecated: 8.0)
    public var rssi: NSNumber? { peripheral.rssi }

    
    /**
     *  @property state
     *
     *  @discussion The current connection state of the peripheral.
     */
    public var state: CBPeripheralState { peripheral.state }

    
    /**
     *  @property services
     *
     *  @discussion A list of <code>CBService</code> objects that have been discovered on the peripheral.
     */
    public var services: [CBService]? { peripheral.services }

    
    /**
     *  @property canSendWriteWithoutResponse
     *
     *  @discussion YES if the remote device has space to send a write without response. If this value is NO,
     *                the value will be set to YES after the current writes have been flushed, and
     *                <link>peripheralIsReadyToSendWriteWithoutResponse:</link> will be called.
     */
    @available(iOS 11.0, *)
    public var canSendWriteWithoutResponse: Bool { peripheral.canSendWriteWithoutResponse }

    
    /**
     *  @property ancsAuthorized
     *
     *  @discussion YES if the remote device has been authorized to receive data over ANCS (Apple Notification Service Center) protocol.  If this value is NO,
     *                the value will be set to YES after a user authorization occurs and
     *                <link>didUpdateANCSAuthorizationForPeripheral:</link> will be called.
     */
    @available(iOS 13.0, *)
    public var ancsAuthorized: Bool { peripheral.ancsAuthorized }
    
    
    /**
     *  @method readRSSI
     *
     *  @discussion While connected, retrieves the current RSSI of the link.
     *
     *  @see        peripheral:didReadRSSI:error:
     */
    public func readRSSI() {
        peripheral.readRSSI()
        // log
        if logOption.contains(.readRSSIStart) {
            let msg_tag = SF_Tag_Peripheral_ReadRSSI_Start
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msgs = [msg_tag, msg_peripheral].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        NotificationCenter.default.post(name: SF_Notify_Peripheral_ReadRSSI_Start, object: nil, userInfo: userInfo)
    }

    
    /**
     *  @method discoverServices:
     *
     *  @param serviceUUIDs A list of <code>CBUUID</code> objects representing the service types to be discovered. If <i>nil</i>,
     *                        all services will be discovered.
     *
     *  @discussion            Discovers available service(s) on the peripheral.
     *
     *  @see                peripheral:didDiscoverServices:
     */
    public func discoverServices(_ serviceUUIDs: [CBUUID]?) {
        peripheral.discoverServices(serviceUUIDs)
        // log
        if logOption.contains(.discoverServicesStart) {
            let msg_tag = SF_Tag_Peripheral_DiscoverServices_Start
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            var msg_serviceUUIDs = "serviceUUIDs=nil"
            if let serviceUUIDs = serviceUUIDs {
                msg_serviceUUIDs = "serviceUUIDs=\(serviceUUIDs)"
            }
            let msgs = [msg_tag, msg_peripheral, msg_serviceUUIDs].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        if let serviceUUIDs = serviceUUIDs {
            userInfo["serviceUUIDs"] = serviceUUIDs
        }
        NotificationCenter.default.post(name: SF_Notify_Peripheral_DiscoverServices_Start, object: nil, userInfo: userInfo)
    }

    
    /**
     *  @method discoverIncludedServices:forService:
     *
     *  @param includedServiceUUIDs A list of <code>CBUUID</code> objects representing the included service types to be discovered. If <i>nil</i>,
     *                                all of <i>service</i>s included services will be discovered, which is considerably slower and not recommended.
     *  @param service                A GATT service.
     *
     *  @discussion                    Discovers the specified included service(s) of <i>service</i>.
     *
     *  @see                        peripheral:didDiscoverIncludedServicesForService:error:
     */
    public func discoverIncludedServices(_ includedServiceUUIDs: [CBUUID]?, for service: CBService) {
        peripheral.discoverIncludedServices(includedServiceUUIDs, for: service)
        // log
        if logOption.contains(.discoverIncludedServicesStart) {
            let msg_tag = SF_Tag_Peripheral_DiscoverIncludedServices_Start
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_service = "service=\(service.sf.description)"
            var msg_includedServiceUUIDs = "includedServiceUUIDs=nil"
            if let includedServiceUUIDs = includedServiceUUIDs {
                msg_includedServiceUUIDs = "includedServiceUUIDs=\(includedServiceUUIDs)"
            }
            let msgs = [msg_tag, msg_peripheral, msg_service, msg_includedServiceUUIDs].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        userInfo["service"] = service
        if let includedServiceUUIDs = includedServiceUUIDs {
            userInfo["includedServiceUUIDs"] = includedServiceUUIDs
        }
        NotificationCenter.default.post(name: SF_Notify_Peripheral_DiscoverIncludedServices_Start, object: nil, userInfo: userInfo)
    }

    
    /**
     *  @method discoverCharacteristics:forService:
     *
     *  @param characteristicUUIDs    A list of <code>CBUUID</code> objects representing the characteristic types to be discovered. If <i>nil</i>,
     *                                all characteristics of <i>service</i> will be discovered.
     *  @param service                A GATT service.
     *
     *  @discussion                    Discovers the specified characteristic(s) of <i>service</i>.
     *
     *  @see                        peripheral:didDiscoverCharacteristicsForService:error:
     */
    public func discoverCharacteristics(_ characteristicUUIDs: [CBUUID]?, for service: CBService) {
        peripheral.discoverCharacteristics(characteristicUUIDs, for: service)
        // log
        if logOption.contains(.discoverCharacteristicsStart) {
            let msg_tag = SF_Tag_Peripheral_DiscoverCharacteristics_Start
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_service = "service=\(service.sf.description)"
            var msg_characteristicUUIDs = "characteristicUUIDs=nil"
            if let characteristicUUIDs = characteristicUUIDs {
                msg_characteristicUUIDs = "characteristicUUIDs=\(characteristicUUIDs)"
            }
            let msgs = [msg_tag, msg_peripheral, msg_service, msg_characteristicUUIDs].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        userInfo["service"] = service
        if let characteristicUUIDs = characteristicUUIDs {
            userInfo["characteristicUUIDs"] = characteristicUUIDs
        }
        NotificationCenter.default.post(name: SF_Notify_Peripheral_DiscoverCharacteristics_Start, object: nil, userInfo: userInfo)
    }

    
    /**
     *  @method readValueForCharacteristic:
     *
     *  @param characteristic    A GATT characteristic.
     *
     *  @discussion                Reads the characteristic value for <i>characteristic</i>.
     *
     *  @see                    peripheral:didUpdateValueForCharacteristic:error:
     */
    public func readValue(for characteristic: CBCharacteristic) {
        peripheral.readRSSI()
        // log
        if logOption.contains(.readCharacteristicValueStart) {
            let msg_tag = SF_Tag_Peripheral_ReadCharacteristicValue_Start
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_characteristic = "characteristic=\(characteristic.sf.description)"
            let msgs = [msg_tag, msg_peripheral, msg_characteristic].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        userInfo["characteristic"] = characteristic
        NotificationCenter.default.post(name: SF_Notify_Peripheral_ReadCharacteristicValue_Start, object: nil, userInfo: userInfo)
    }

    
    /**
     *  @method        maximumWriteValueLengthForType:
     *
     *  @discussion    The maximum amount of data, in bytes, that can be sent to a characteristic in a single write type.
     *
     *  @see        writeValue:forCharacteristic:type:
     */
    @available(iOS 9.0, *)
    public func maximumWriteValueLength(for type: CBCharacteristicWriteType) -> Int {
        let length = peripheral.maximumWriteValueLength(for: type)
//        // log
//        if isLogEnable {
//            Log.info("\nperipheral=\(peripheral.sf.description)\ntype=\(type.sf.description)\n-> length=\(length)")
//        }
        return length
    }

    
    /**
     *  @method writeValue:forCharacteristic:type:
     *
     *  @param data                The value to write.
     *  @param characteristic    The characteristic whose characteristic value will be written.
     *  @param type                The type of write to be executed.
     *
     *  @discussion                Writes <i>value</i> to <i>characteristic</i>'s characteristic value.
     *                            If the <code>CBCharacteristicWriteWithResponse</code> type is specified, {@link peripheral:didWriteValueForCharacteristic:error:}
     *                            is called with the result of the write request.
     *                            If the <code>CBCharacteristicWriteWithoutResponse</code> type is specified, and canSendWriteWithoutResponse is false, the delivery
     *                             of the data is best-effort and may not be guaranteed.
     *
     *  @see                    peripheral:didWriteValueForCharacteristic:error:
     *  @see                    peripheralIsReadyToSendWriteWithoutResponse:
     *    @see                    canSendWriteWithoutResponse
     *    @see                    CBCharacteristicWriteType
     */
    public func writeValue(_ data: Data, for characteristic: CBCharacteristic, type: CBCharacteristicWriteType) {
        peripheral.writeValue(data, for: characteristic, type: type)
        // log
        if logOption.contains(.writeCharacteristicValueStart) {
            let msg_tag = SF_Tag_Peripheral_WriteCharacteristicValue_Start
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_characteristic = "characteristic=\(characteristic.sf.description)"
            let msg_type = "type=\(type.sf.description)"
            let msg_data = "data=\(data.sf.toHex())"
            let msgs = [msg_tag, msg_peripheral, msg_characteristic, msg_type, msg_data].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        userInfo["characteristic"] = characteristic
        userInfo["type"] = type
        userInfo["data"] = data
        NotificationCenter.default.post(name: SF_Notify_Peripheral_WriteCharacteristicValue_Start, object: nil, userInfo: userInfo)
    }

    
    /**
     *  @method setNotifyValue:forCharacteristic:
     *
     *  @param enabled            Whether or not notifications/indications should be enabled.
     *  @param characteristic    The characteristic containing the client characteristic configuration descriptor.
     *
     *  @discussion                Enables or disables notifications/indications for the characteristic value of <i>characteristic</i>. If <i>characteristic</i>
     *                            allows both, notifications will be used.
     *                          When notifications/indications are enabled, updates to the characteristic value will be received via delegate method
     *                          @link peripheral:didUpdateValueForCharacteristic:error: @/link. Since it is the peripheral that chooses when to send an update,
     *                          the application should be prepared to handle them as long as notifications/indications remain enabled.
     *
     *  @see                    peripheral:didUpdateNotificationStateForCharacteristic:error:
     *  @seealso                CBConnectPeripheralOptionNotifyOnNotificationKey
     */
    public func setNotifyValue(_ enabled: Bool, for characteristic: CBCharacteristic) {
        peripheral.setNotifyValue(enabled, for: characteristic)
        // log
        if logOption.contains(.setCharacteristicNotificationStateStart) {
            let msg_tag = SF_Tag_Peripheral_SetCharacteristicNotificationState_Start
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_characteristic = "characteristic=\(characteristic.sf.description)"
            let msg_enabled = "enabled=\(enabled)"
            let msgs = [msg_tag, msg_peripheral, msg_characteristic, msg_enabled].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        userInfo["characteristic"] = characteristic
        userInfo["enabled"] = enabled
        NotificationCenter.default.post(name: SF_Notify_Peripheral_SetCharacteristicNotificationState_Start, object: nil, userInfo: userInfo)
    }

    
    /**
     *  @method discoverDescriptorsForCharacteristic:
     *
     *  @param characteristic    A GATT characteristic.
     *
     *  @discussion                Discovers the characteristic descriptor(s) of <i>characteristic</i>.
     *
     *  @see                    peripheral:didDiscoverDescriptorsForCharacteristic:error:
     */
    public func discoverDescriptors(for characteristic: CBCharacteristic) {
        peripheral.discoverDescriptors(for: characteristic)
        // log
        if logOption.contains(.discoverDescriptorsStart) {
            let msg_tag = SF_Tag_Peripheral_DiscoverDescriptors_Start
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_characteristic = "characteristic=\(characteristic.sf.description)"
            let msgs = [msg_tag, msg_peripheral, msg_characteristic].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        userInfo["characteristic"] = characteristic
        NotificationCenter.default.post(name: SF_Notify_Peripheral_DiscoverDescriptors_Start, object: nil, userInfo: userInfo)
    }

    
    /**
     *  @method readValueForDescriptor:
     *
     *  @param descriptor    A GATT characteristic descriptor.
     *
     *  @discussion            Reads the value of <i>descriptor</i>.
     *
     *  @see                peripheral:didUpdateValueForDescriptor:error:
     */
    public func readValue(for descriptor: CBDescriptor) {
        peripheral.readValue(for: descriptor)
        // log
        if logOption.contains(.readDescriptorValueStart) {
            let msg_tag = SF_Tag_Peripheral_ReadDescriptorValue_Start
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_descriptor = "descriptor=\(descriptor.sf.description)"
            let msgs = [msg_tag, msg_peripheral, msg_descriptor].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        userInfo["descriptor"] = descriptor
        NotificationCenter.default.post(name: SF_Notify_Peripheral_ReadDescriptorValue_Start, object: nil, userInfo: userInfo)
    }

    
    /**
     *  @method writeValue:forDescriptor:
     *
     *  @param data            The value to write.
     *  @param descriptor    A GATT characteristic descriptor.
     *
     *  @discussion            Writes <i>data</i> to <i>descriptor</i>'s value. Client characteristic configuration descriptors cannot be written using
     *                        this method, and should instead use @link setNotifyValue:forCharacteristic: @/link.
     *
     *  @see                peripheral:didWriteValueForCharacteristic:error:
     */
    public func writeValue(_ data: Data, for descriptor: CBDescriptor) {
        peripheral.writeValue(data, for: descriptor)
        // log
        if logOption.contains(.writeDescriptorValueStart) {
            let msg_tag = SF_Tag_Peripheral_WriteDescriptorValue_Start
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_descriptor = "descriptor=\(descriptor.sf.description)"
            let msg_data = "data=\(data.sf.toHex())"
            let msgs = [msg_tag, msg_peripheral, msg_descriptor, msg_data].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        userInfo["descriptor"] = descriptor
        userInfo["data"] = data
        NotificationCenter.default.post(name: SF_Notify_Peripheral_WriteDescriptorValue_Start, object: nil, userInfo: userInfo)
    }

    
    /**
     *  @method openL2CAPChannel:
     *
     *  @param PSM            The PSM of the channel to open
     *
     *  @discussion            Attempt to open an L2CAP channel to the peripheral using the supplied PSM.
     *
     *  @see                peripheral:didWriteValueForCharacteristic:error:
     */
    @available(iOS 11.0, *)
    public func openL2CAPChannel(_ PSM: CBL2CAPPSM) {
        peripheral.openL2CAPChannel(PSM)
        // log
        if logOption.contains(.openL2CAPChannelStart) {
            let msg_tag = SF_Tag_Peripheral_OpenL2CAPChannel_Start
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_PSM = "PSM=\(PSM)"
            let msgs = [msg_tag, msg_peripheral, msg_PSM].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        userInfo["PSM"] = PSM
        NotificationCenter.default.post(name: SF_Notify_Peripheral_OpenL2CAPChannel_Start, object: nil, userInfo: userInfo)
    }
}

// MARK: - CBPeripheralDelegate
extension SFPeripheral: CBPeripheralDelegate {
    
    
    /**
     *  @method peripheralDidUpdateName:
     *
     *  @param peripheral    The peripheral providing this update.
     *
     *  @discussion            This method is invoked when the @link name @/link of <i>peripheral</i> changes.
     */
    @available(iOS 6.0, *)
    public func peripheralDidUpdateName(_ peripheral: CBPeripheral) {
        // log
        if logOption.contains(.nameDidUpdated) {
            let msg_tag = SF_Tag_Peripheral_Name_DidUpdated
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msgs = [msg_tag, msg_peripheral].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        NotificationCenter.default.post(name: SF_Notify_Peripheral_Name_DidUpdated, object: nil, userInfo: userInfo)
    }

    
    /**
     *  @method peripheral:didModifyServices:
     *
     *  @param peripheral            The peripheral providing this update.
     *  @param invalidatedServices    The services that have been invalidated
     *
     *  @discussion            This method is invoked when the @link services @/link of <i>peripheral</i> have been changed.
     *                        At this point, the designated <code>CBService</code> objects have been invalidated.
     *                        Services can be re-discovered via @link discoverServices: @/link.
     */
    @available(iOS 7.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
        // log
        if logOption.contains(.servicesDidModified) {
            let msg_tag = SF_Tag_Peripheral_Services_DidModified
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            var msg_invalidatedServices = "invalidatedServices=["
            for invalidatedService in invalidatedServices {
                msg_invalidatedServices.append(invalidatedService.sf.description)
            }
            msg_invalidatedServices.append("]")
            let msgs = [msg_tag, msg_peripheral, msg_invalidatedServices].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        userInfo["invalidatedServices"] = invalidatedServices
        NotificationCenter.default.post(name: SF_Notify_Peripheral_Services_DidModified, object: nil, userInfo: userInfo)
    }

    
    /**
     *  @method peripheralDidUpdateRSSI:error:
     *
     *  @param peripheral    The peripheral providing this update.
     *    @param error        If an error occurred, the cause of the failure.
     *
     *  @discussion            This method returns the result of a @link readRSSI: @/link call.
     *
     *  @deprecated            Use {@link peripheral:didReadRSSI:error:} instead.
     */
    @available(iOS, introduced: 5.0, deprecated: 8.0)
    public func peripheralDidUpdateRSSI(_ peripheral: CBPeripheral, error: (any Error)?) {
        // log
        if logOption.contains(.readRSSISuccess) {
            let msg_tag = SF_Tag_Peripheral_RSSI_DidUpdated
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            let msgs = [msg_tag, msg_peripheral, msg_error].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        if let error = error {
            userInfo["error"] = error
        }
        NotificationCenter.default.post(name: SF_Notify_Peripheral_RSSI_DidUpdated, object: nil, userInfo: userInfo)
    }

    
    /**
     *  @method peripheral:didReadRSSI:error:
     *
     *  @param peripheral    The peripheral providing this update.
     *  @param RSSI            The current RSSI of the link.
     *  @param error        If an error occurred, the cause of the failure.
     *
     *  @discussion            This method returns the result of a @link readRSSI: @/link call.
     */
    @available(iOS 8.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: (any Error)?) {
        // log
        if logOption.contains(.readRSSISuccess) {
            let msg_tag = SF_Tag_Peripheral_ReadRSSI_Success
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_RSSI = "RSSI=\(RSSI)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            let msgs = [msg_tag, msg_peripheral, msg_RSSI, msg_error].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        userInfo["RSSI"] = RSSI
        if let error = error {
            userInfo["error"] = error
        }
        NotificationCenter.default.post(name: SF_Notify_Peripheral_ReadRSSI_Success, object: nil, userInfo: userInfo)
    }

    
    /**
     *  @method peripheral:didDiscoverServices:
     *
     *  @param peripheral    The peripheral providing this information.
     *    @param error        If an error occurred, the cause of the failure.
     *
     *  @discussion            This method returns the result of a @link discoverServices: @/link call. If the service(s) were read successfully, they can be retrieved via
     *                        <i>peripheral</i>'s @link services @/link property.
     *
     */
    @available(iOS 5.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: (any Error)?) {
        // log
        if logOption.contains(.discoverServicesSuccess) {
            let msg_tag = SF_Tag_Peripheral_DiscoverServices_Success
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            let msgs = [msg_tag, msg_peripheral, msg_error].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        if let error = error {
            userInfo["error"] = error
        }
        NotificationCenter.default.post(name: SF_Notify_Peripheral_DiscoverServices_Success, object: nil, userInfo: userInfo)
    }

    
    /**
     *  @method peripheral:didDiscoverIncludedServicesForService:error:
     *
     *  @param peripheral    The peripheral providing this information.
     *  @param service        The <code>CBService</code> object containing the included services.
     *    @param error        If an error occurred, the cause of the failure.
     *
     *  @discussion            This method returns the result of a @link discoverIncludedServices:forService: @/link call. If the included service(s) were read successfully,
     *                        they can be retrieved via <i>service</i>'s <code>includedServices</code> property.
     */
    @available(iOS 5.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverIncludedServicesFor service: CBService, error: (any Error)?) {
        // log
        if logOption.contains(.discoverIncludedServicesSuccess) {
            let msg_tag = SF_Tag_Peripheral_DiscoverIncludedServices_Success
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_service = "service=\(service.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            let msgs = [msg_tag, msg_peripheral, msg_service, msg_error].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        userInfo["service"] = service
        if let error = error {
            userInfo["error"] = error
        }
        NotificationCenter.default.post(name: SF_Notify_Peripheral_DiscoverIncludedServices_Success, object: nil, userInfo: userInfo)
    }

    
    /**
     *  @method peripheral:didDiscoverCharacteristicsForService:error:
     *
     *  @param peripheral    The peripheral providing this information.
     *  @param service        The <code>CBService</code> object containing the characteristic(s).
     *    @param error        If an error occurred, the cause of the failure.
     *
     *  @discussion            This method returns the result of a @link discoverCharacteristics:forService: @/link call. If the characteristic(s) were read successfully,
     *                        they can be retrieved via <i>service</i>'s <code>characteristics</code> property.
     */
    @available(iOS 5.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: (any Error)?) {
        // log
        if logOption.contains(.discoverCharacteristicsSuccess) {
            let msg_tag = SF_Tag_Peripheral_DiscoverCharacteristics_Success
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_service = "service=\(service.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            let msgs = [msg_tag, msg_peripheral, msg_service, msg_error].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        userInfo["service"] = service
        if let error = error {
            userInfo["error"] = error
        }
        NotificationCenter.default.post(name: SF_Notify_Peripheral_DiscoverCharacteristics_Success, object: nil, userInfo: userInfo)
    }

    
    /**
     *  @method peripheral:didUpdateValueForCharacteristic:error:
     *
     *  @param peripheral        The peripheral providing this information.
     *  @param characteristic    A <code>CBCharacteristic</code> object.
     *    @param error            If an error occurred, the cause of the failure.
     *
     *  @discussion                This method is invoked after a @link readValueForCharacteristic: @/link call, or upon receipt of a notification/indication.
     */
    @available(iOS 5.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: (any Error)?) {
        // log
        if logOption.contains(.readCharacteristicValueSuccess) {
            let msg_tag = SF_Tag_Peripheral_ReadCharacteristicValue_Success
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_characteristic = "characteristic=\(characteristic.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            let msgs = [msg_tag, msg_peripheral, msg_characteristic, msg_error].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        userInfo["characteristic"] = characteristic
        if let error = error {
            userInfo["error"] = error
        }
        NotificationCenter.default.post(name: SF_Notify_Peripheral_ReadCharacteristicValue_Success, object: nil, userInfo: userInfo)
    }

    
    /**
     *  @method peripheral:didWriteValueForCharacteristic:error:
     *
     *  @param peripheral        The peripheral providing this information.
     *  @param characteristic    A <code>CBCharacteristic</code> object.
     *    @param error            If an error occurred, the cause of the failure.
     *
     *  @discussion                This method returns the result of a {@link writeValue:forCharacteristic:type:} call, when the <code>CBCharacteristicWriteWithResponse</code> type is used.
     */
    @available(iOS 5.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: (any Error)?) {
        // log
        if logOption.contains(.writeCharacteristicValueSuccess) {
            let msg_tag = SF_Tag_Peripheral_WriteCharacteristicValue_Success
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_characteristic = "characteristic=\(characteristic.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            let msgs = [msg_tag, msg_peripheral, msg_characteristic, msg_error].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        userInfo["characteristic"] = characteristic
        if let error = error {
            userInfo["error"] = error
        }
        NotificationCenter.default.post(name: SF_Notify_Peripheral_WriteCharacteristicValue_Success, object: nil, userInfo: userInfo)
    }

    
    /**
     *  @method peripheral:didUpdateNotificationStateForCharacteristic:error:
     *
     *  @param peripheral        The peripheral providing this information.
     *  @param characteristic    A <code>CBCharacteristic</code> object.
     *    @param error            If an error occurred, the cause of the failure.
     *
     *  @discussion                This method returns the result of a @link setNotifyValue:forCharacteristic: @/link call.
     */
    @available(iOS 5.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: (any Error)?) {
        // log
        if logOption.contains(.setCharacteristicNotificationStateSuccess) {
            let msg_tag = SF_Tag_Peripheral_SetCharacteristicNotificationState_Success
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_characteristic = "characteristic=\(characteristic.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            let msgs = [msg_tag, msg_peripheral, msg_characteristic, msg_error].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        userInfo["characteristic"] = characteristic
        if let error = error {
            userInfo["error"] = error
        }
        NotificationCenter.default.post(name: SF_Notify_Peripheral_SetCharacteristicNotificationState_Success, object: nil, userInfo: userInfo)
    }

    
    /**
     *  @method peripheral:didDiscoverDescriptorsForCharacteristic:error:
     *
     *  @param peripheral        The peripheral providing this information.
     *  @param characteristic    A <code>CBCharacteristic</code> object.
     *    @param error            If an error occurred, the cause of the failure.
     *
     *  @discussion                This method returns the result of a @link discoverDescriptorsForCharacteristic: @/link call. If the descriptors were read successfully,
     *                            they can be retrieved via <i>characteristic</i>'s <code>descriptors</code> property.
     */
    @available(iOS 5.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: (any Error)?) {
        // log
        if logOption.contains(.discoverDescriptorsSuccess) {
            let msg_tag = SF_Tag_Peripheral_DiscoverDescriptors_Success
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_characteristic = "characteristic=\(characteristic.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            let msgs = [msg_tag, msg_peripheral, msg_characteristic, msg_error].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        userInfo["characteristic"] = characteristic
        if let error = error {
            userInfo["error"] = error
        }
        NotificationCenter.default.post(name: SF_Notify_Peripheral_DiscoverDescriptors_Success, object: nil, userInfo: userInfo)
    }

    
    /**
     *  @method peripheral:didUpdateValueForDescriptor:error:
     *
     *  @param peripheral        The peripheral providing this information.
     *  @param descriptor        A <code>CBDescriptor</code> object.
     *    @param error            If an error occurred, the cause of the failure.
     *
     *  @discussion                This method returns the result of a @link readValueForDescriptor: @/link call.
     */
    @available(iOS 5.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: (any Error)?) {
        // log
        if logOption.contains(.readDescriptorValueSuccess) {
            let msg_tag = SF_Tag_Peripheral_ReadDescriptorValue_Success
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_descriptor = "descriptor=\(descriptor.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            let msgs = [msg_tag, msg_peripheral, msg_descriptor, msg_error].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        userInfo["descriptor"] = descriptor
        if let error = error {
            userInfo["error"] = error
        }
        NotificationCenter.default.post(name: SF_Notify_Peripheral_ReadDescriptorValue_Success, object: nil, userInfo: userInfo)
    }

    
    /**
     *  @method peripheral:didWriteValueForDescriptor:error:
     *
     *  @param peripheral        The peripheral providing this information.
     *  @param descriptor        A <code>CBDescriptor</code> object.
     *    @param error            If an error occurred, the cause of the failure.
     *
     *  @discussion                This method returns the result of a @link writeValue:forDescriptor: @/link call.
     */
    @available(iOS 5.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: (any Error)?) {
        // log
        if logOption.contains(.writeDescriptorValueSuccess) {
            let msg_tag = SF_Tag_Peripheral_WriteDescriptorValue_Success
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_descriptor = "descriptor=\(descriptor.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            let msgs = [msg_tag, msg_peripheral, msg_descriptor, msg_error].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        userInfo["descriptor"] = descriptor
        if let error = error {
            userInfo["error"] = error
        }
        NotificationCenter.default.post(name: SF_Notify_Peripheral_WriteDescriptorValue_Success, object: nil, userInfo: userInfo)
    }

    
    /**
     *  @method peripheralIsReadyToSendWriteWithoutResponse:
     *
     *  @param peripheral   The peripheral providing this update.
     *
     *  @discussion         This method is invoked after a failed call to @link writeValue:forCharacteristic:type: @/link, when <i>peripheral</i> is again
     *                      ready to send characteristic value updates.
     *
     */
    @available(iOS 5.0, *)
    public func peripheralIsReady(toSendWriteWithoutResponse peripheral: CBPeripheral) {
        // log
        if logOption.contains(.isReadyToSendWriteWithoutResponse) {
            let msg_tag = SF_Tag_Peripheral_IsReadyToSendWriteWithoutResponse
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msgs = [msg_tag, msg_peripheral].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        NotificationCenter.default.post(name: SF_Notify_Peripheral_IsReadyToSendWriteWithoutResponse, object: nil, userInfo: userInfo)
    }

    
    /**
     *  @method peripheral:didOpenL2CAPChannel:error:
     *
     *  @param peripheral        The peripheral providing this information.
     *  @param channel            A <code>CBL2CAPChannel</code> object.
     *    @param error            If an error occurred, the cause of the failure.
     *
     *  @discussion                This method returns the result of a @link openL2CAPChannel: @link call.
     */
    @available(iOS 11.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didOpen channel: CBL2CAPChannel?, error: (any Error)?) {
        // log
        if logOption.contains(.openL2CAPChannelSuccess) {
            let msg_tag = SF_Tag_Peripheral_OpenL2CAPChannel_Success
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            var msg_channel = "channel=nil"
            if let channel = channel {
                msg_channel = "channel=\(channel.description)"
            }   
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            let msgs = [msg_tag, msg_peripheral, msg_channel, msg_error].joined(separator: "\n")
            Log.info("\n\(msgs)\n")
        }
        // notify
        var userInfo = [String: Any]()
        userInfo["peripheral"] = peripheral
        if let channel = channel {
            userInfo["channel"] = channel
        }
        if let error = error {
            userInfo["error"] = error
        }
        NotificationCenter.default.post(name: SF_Notify_Peripheral_OpenL2CAPChannel_Success, object: nil, userInfo: userInfo)
    }
}
