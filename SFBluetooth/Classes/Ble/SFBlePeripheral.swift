//
//  SFBlePeripheral.swift
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
public let SF_Tag_Peripheral_State_DidUpdated =                                 "Tag_Peripheral_State_DidUpdated"
public let SF_Tag_Peripheral_Name_DidUpdated =                                  "Tag_Peripheral_Name_DidUpdated"
public let SF_Tag_Peripheral_Services_DidModified =                             "Tag_Peripheral_Services_DidModified"
public let SF_Tag_Peripheral_RSSI_DidUpdated =                                  "Tag_Peripheral_RSSI_DidUpdated"
public let SF_Tag_Peripheral_IsReadyToSendWriteWithoutResponse =                "Tag_Peripheral_IsReadyToSendWriteWithoutResponse"
public let SF_Tag_Peripheral_ReadRSSI_Start =                                   "Tag_Peripheral_ReadRSSI_Start"
public let SF_Tag_Peripheral_ReadRSSI_Success =                                 "Tag_Peripheral_ReadRSSI_Success"
public let SF_Tag_Peripheral_DiscoverServices_Start =                           "Tag_Peripheral_DiscoverServices_Start"
public let SF_Tag_Peripheral_DiscoverServices_Success =                         "Tag_Peripheral_DiscoverServices_Success"
public let SF_Tag_Peripheral_DiscoverIncludedServices_Start =                   "Tag_Peripheral_DiscoverIncludedServices_Start"
public let SF_Tag_Peripheral_DiscoverIncludedServices_Success =                 "Tag_Peripheral_DiscoverIncludedServices_Success"
public let SF_Tag_Peripheral_DiscoverCharacteristics_Start =                    "Tag_Peripheral_DiscoverCharacteristics_Start"
public let SF_Tag_Peripheral_DiscoverCharacteristics_Success =                  "Tag_Peripheral_DiscoverCharacteristics_Success"
public let SF_Tag_Peripheral_DiscoverDescriptors_Start =                        "Tag_Peripheral_DiscoverDescriptors_Start"
public let SF_Tag_Peripheral_DiscoverDescriptors_Success =                      "Tag_Peripheral_DiscoverDescriptors_Success"
public let SF_Tag_Peripheral_SetCharacteristicNotificationState_Start =         "Tag_Peripheral_SetCharacteristicNotificationState_Start"
public let SF_Tag_Peripheral_SetCharacteristicNotificationState_Success =       "Tag_Peripheral_SetCharacteristicNotificationState_Success"
public let SF_Tag_Peripheral_GetMaximumWriteValueLength =                       "Tag_Peripheral_GetMaximumWriteValueLength"
public let SF_Tag_Peripheral_ReadCharacteristicValue_Start =                    "Tag_Peripheral_ReadCharacteristicValue_Start"
public let SF_Tag_Peripheral_ReadCharacteristicValue_Success =                  "Tag_Peripheral_ReadCharacteristicValue_Success"
public let SF_Tag_Peripheral_WriteCharacteristicValue_Start =                   "Tag_Peripheral_WriteCharacteristicValue_Start"
public let SF_Tag_Peripheral_WriteCharacteristicValue_Success =                 "Tag_Peripheral_WriteCharacteristicValue_Success"
public let SF_Tag_Peripheral_ReadDescriptorValue_Start =                        "Tag_Peripheral_ReadDescriptorValue_Start"
public let SF_Tag_Peripheral_ReadDescriptorValue_Success =                      "Tag_Peripheral_ReadDescriptorValue_Success"
public let SF_Tag_Peripheral_WriteDescriptorValue_Start =                       "Tag_Peripheral_WriteDescriptorValue_Start"
public let SF_Tag_Peripheral_WriteDescriptorValue_Success =                     "Tag_Peripheral_WriteDescriptorValue_Success"
public let SF_Tag_Peripheral_OpenL2CAPChannel_Start =                           "Tag_Peripheral_OpenL2CAPChannel_Start"
public let SF_Tag_Peripheral_OpenL2CAPChannel_Success =                         "Tag_Peripheral_OpenL2CAPChannel_Success"

// MARK: - SFBlePeripheralLogOption
public struct SFBlePeripheralLogOption: OptionSet {
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let stateDidUpdated =                             SFBlePeripheralLogOption(rawValue: 1 << 0)
    public static let nameDidUpdated =                              SFBlePeripheralLogOption(rawValue: 1 << 1)
    public static let servicesDidModified =                         SFBlePeripheralLogOption(rawValue: 1 << 2)
    public static let RSSIDidUpdated =                              SFBlePeripheralLogOption(rawValue: 1 << 3)
    public static let isReadyToSendWriteWithoutResponse =           SFBlePeripheralLogOption(rawValue: 1 << 4)
    public static let readRSSIStart =                               SFBlePeripheralLogOption(rawValue: 1 << 5)
    public static let readRSSISuccess =                             SFBlePeripheralLogOption(rawValue: 1 << 6)
    public static let discoverServicesStart =                       SFBlePeripheralLogOption(rawValue: 1 << 7)
    public static let discoverServicesSuccess =                     SFBlePeripheralLogOption(rawValue: 1 << 8)
    public static let discoverIncludedServicesStart =               SFBlePeripheralLogOption(rawValue: 1 << 9)
    public static let discoverIncludedServicesSuccess =             SFBlePeripheralLogOption(rawValue: 1 << 10)
    public static let discoverCharacteristicsStart =                SFBlePeripheralLogOption(rawValue: 1 << 11)
    public static let discoverCharacteristicsSuccess =              SFBlePeripheralLogOption(rawValue: 1 << 12)
    public static let discoverDescriptorsStart =                    SFBlePeripheralLogOption(rawValue: 1 << 13)
    public static let discoverDescriptorsSuccess =                  SFBlePeripheralLogOption(rawValue: 1 << 14)
    public static let setCharacteristicNotificationStateStart =     SFBlePeripheralLogOption(rawValue: 1 << 15)
    public static let setCharacteristicNotificationStateSuccess =   SFBlePeripheralLogOption(rawValue: 1 << 16)
    public static let getMaximumWriteValueLength =                  SFBlePeripheralLogOption(rawValue: 1 << 16)
    public static let readCharacteristicValueStart =                SFBlePeripheralLogOption(rawValue: 1 << 18)
    public static let readCharacteristicValueSuccess =              SFBlePeripheralLogOption(rawValue: 1 << 19)
    public static let writeCharacteristicValueStart =               SFBlePeripheralLogOption(rawValue: 1 << 20)
    public static let writeCharacteristicValueSuccess =             SFBlePeripheralLogOption(rawValue: 1 << 21)
    public static let readDescriptorValueStart =                    SFBlePeripheralLogOption(rawValue: 1 << 22)
    public static let readDescriptorValueSuccess =                  SFBlePeripheralLogOption(rawValue: 1 << 23)
    public static let writeDescriptorValueStart =                   SFBlePeripheralLogOption(rawValue: 1 << 24)
    public static let writeDescriptorValueSuccess =                 SFBlePeripheralLogOption(rawValue: 1 << 25)
    public static let openL2CAPChannelStart =                       SFBlePeripheralLogOption(rawValue: 1 << 26)
    public static let openL2CAPChannelSuccess =                     SFBlePeripheralLogOption(rawValue: 1 << 27)

    public static let all: SFBlePeripheralLogOption = [.stateDidUpdated, .nameDidUpdated, .servicesDidModified, .RSSIDidUpdated, .isReadyToSendWriteWithoutResponse, .readRSSIStart, .readRSSISuccess, .discoverServicesStart, .discoverServicesSuccess, .discoverIncludedServicesStart, .discoverIncludedServicesSuccess, .discoverCharacteristicsStart, .discoverCharacteristicsSuccess, .discoverDescriptorsStart, .discoverDescriptorsSuccess, .setCharacteristicNotificationStateStart, .setCharacteristicNotificationStateSuccess, .getMaximumWriteValueLength, .readCharacteristicValueStart, .readCharacteristicValueSuccess, .writeCharacteristicValueStart, .writeCharacteristicValueSuccess, .readDescriptorValueStart, .readDescriptorValueSuccess, .writeDescriptorValueStart, .writeDescriptorValueSuccess, .openL2CAPChannelStart, .openL2CAPChannelSuccess]
}


// MARK: - SFBlePeripheral
public class SFBlePeripheral: NSObject, SFBleProtocol {
    // MARK: callback
    public var didUpdateState: ((_ peripheral: CBPeripheral, _ state: CBPeripheralState) -> ())?
    public var didUpdateName: ((_ peripheral: CBPeripheral) -> ())?
    public var didModifyServices: ((_ peripheral: CBPeripheral, _ invalidatedServices: [CBService]) -> ())?
    public var didUpdateRSSI: ((_ peripheral: CBPeripheral, _ error: (any Error)?) -> ())?
    public var isReadyToSendWriteWithoutResponse: ((_ peripheral: CBPeripheral) -> ())?
    public var didReadRSSI: ((_ peripheral: CBPeripheral, _ RSSI: NSNumber, _ error: (any Error)?) -> ())?
    public var didDiscoverServices: ((_ peripheral: CBPeripheral, _ error: (any Error)?) -> ())?
    public var didDiscoverIncludedServices: ((_ peripheral: CBPeripheral, _ service: CBService, _ error: (any Error)?) -> ())?
    public var didDiscoverCharacteristics: ((_ peripheral: CBPeripheral, _ service: CBService, _ error: (any Error)?) -> ())?
    public var didUpdateValueForCharacteristic: ((_ peripheral: CBPeripheral, _ characteristic: CBCharacteristic, _ error: (any Error)?) -> ())?
    public var didWriteValueForCharacteristic: ((_ peripheral: CBPeripheral, _ characteristic: CBCharacteristic, _ error: (any Error)?) -> ())?
    public var didUpdateNotificationStateForCharacteristic: ((_ peripheral: CBPeripheral, _ characteristic: CBCharacteristic, _ error: (any Error)?) -> ())?
    public var didDiscoverDescriptorsForCharacteristic: ((_ peripheral: CBPeripheral, _ characteristic: CBCharacteristic, _ error: (any Error)?) -> ())?
    public var didUpdateValueForDescriptor: ((_ peripheral: CBPeripheral, _ descriptor: CBDescriptor, _ error: (any Error)?) -> ())?
    public var didWriteValueForDescriptor: ((_ peripheral: CBPeripheral, _ descriptor: CBDescriptor, _ error: (any Error)?) -> ())?
    public var didOpenChannel: ((_ peripheral: CBPeripheral, _ channel: CBL2CAPChannel?, _ error: (any Error)?) -> ())?
    
    // MARK: var
    public var id: UUID?
    public let peripheral: CBPeripheral
    public var logOption: SFBlePeripheralLogOption = .all
    
    // MARK: life cycle
    public init(peripheral: CBPeripheral) {
        self.peripheral = peripheral
        super.init()
        self.peripheral.delegate = self
        self.peripheral.addObserver(self, forKeyPath: "state", options: .new, context: nil)
    }
    deinit {
        self.peripheral.removeObserver(self, forKeyPath: "state")
    }
}


// MARK: - KVO
extension SFBlePeripheral {
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let peripheral = object as? CBPeripheral, peripheral == self.peripheral {
            if keyPath == "state", let state = change?[.newKey] as? CBPeripheralState {
                // log
                if logOption.contains(.stateDidUpdated) {
                    let msg_peripheral = "peripheral=\(peripheral.sf.description)"
                    let msg_state = "state=\(state.sf.description)"
                    logCallback(tag: SF_Tag_Peripheral_State_DidUpdated,
                           msgs: [msg_peripheral, msg_state])
                }
                // callback
                didUpdateState?(peripheral, state)
                return
            }
            return
        }
    }
}


// MARK: - func
extension SFBlePeripheral {
    
    /**
     *  @method readRSSI
     *
     *  @discussion While connected, retrieves the current RSSI of the link.
     *
     *  @see        peripheral:didReadRSSI:error:
     */
    public func readRSSI(id: UUID) {
        // do
        self.id = id
        peripheral.readRSSI()
        // log
        if logOption.contains(.readRSSIStart) {
            let msg_tag = SF_Tag_Peripheral_ReadRSSI_Start
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            logTry(tag: SF_Tag_Peripheral_ReadRSSI_Start,
                   msgs: [msg_peripheral],
                   result: nil)
        }
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
    public func discoverServices(id: UUID, serviceUUIDs: [CBUUID]?) {
        // do
        self.id = id
        peripheral.discoverServices(serviceUUIDs)
        // log
        if logOption.contains(.discoverServicesStart) {
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            var msg_serviceUUIDs = "serviceUUIDs=nil"
            if let serviceUUIDs = serviceUUIDs {
                msg_serviceUUIDs = "serviceUUIDs=\(serviceUUIDs)"
            }
            logTry(tag: SF_Tag_Peripheral_DiscoverServices_Start,
                   msgs: [msg_peripheral, msg_serviceUUIDs],
                   result: nil)
        }
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
    public func discoverIncludedServices(id: UUID, includedServiceUUIDs: [CBUUID]?, for service: CBService) {
        // do
        self.id = id
        peripheral.discoverIncludedServices(includedServiceUUIDs, for: service)
        // log
        if logOption.contains(.discoverIncludedServicesStart) {
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_service = "service=\(service.sf.description)"
            var msg_includedServiceUUIDs = "includedServiceUUIDs=nil"
            if let includedServiceUUIDs = includedServiceUUIDs {
                msg_includedServiceUUIDs = "includedServiceUUIDs=\(includedServiceUUIDs)"
            }
            logTry(tag: SF_Tag_Peripheral_DiscoverIncludedServices_Start,
                   msgs: [msg_peripheral, msg_service, msg_includedServiceUUIDs],
                   result: nil)
        }
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
    public func discoverCharacteristics(id: UUID, characteristicUUIDs: [CBUUID]?, for service: CBService) {
        // do
        self.id = id
        peripheral.discoverCharacteristics(characteristicUUIDs, for: service)
        // log
        if logOption.contains(.discoverCharacteristicsStart) {
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_service = "service=\(service.sf.description)"
            var msg_characteristicUUIDs = "characteristicUUIDs=nil"
            if let characteristicUUIDs = characteristicUUIDs {
                msg_characteristicUUIDs = "characteristicUUIDs=\(characteristicUUIDs)"
            }
            logTry(tag: SF_Tag_Peripheral_DiscoverCharacteristics_Start,
                   msgs: [msg_peripheral, msg_service, msg_characteristicUUIDs],
                   result: nil)
        }
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
    public func readValue(id: UUID, for characteristic: CBCharacteristic) {
        // do
        self.id = id
        peripheral.readRSSI()
        // log
        if logOption.contains(.readCharacteristicValueStart) {
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_characteristic = "characteristic=\(characteristic.sf.description)"
            logTry(tag: SF_Tag_Peripheral_ReadCharacteristicValue_Start,
                   msgs: [msg_peripheral, msg_characteristic],
                   result: nil)
        }
    }

    
    /**
     *  @method        maximumWriteValueLengthForType:
     *
     *  @discussion    The maximum amount of data, in bytes, that can be sent to a characteristic in a single write type.
     *
     *  @see        writeValue:forCharacteristic:type:
     */
    @available(iOS 9.0, *)
    public func maximumWriteValueLength(id: UUID, for type: CBCharacteristicWriteType) -> Int {
        // do
        self.id = id
        let length = peripheral.maximumWriteValueLength(for: type)
        // log
        if logOption.contains(.getMaximumWriteValueLength) {
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_type = "type=\(type.sf.description)"
            logTry(tag: SF_Tag_Peripheral_GetMaximumWriteValueLength,
                   msgs: [msg_peripheral, msg_type],
                   result: nil)
        }
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
    public func writeValue(id: UUID, data: Data, for characteristic: CBCharacteristic, type: CBCharacteristicWriteType) {
        // do
        self.id = id
        peripheral.writeValue(data, for: characteristic, type: type)
        // log
        if logOption.contains(.writeCharacteristicValueStart) {
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_characteristic = "characteristic=\(characteristic.sf.description)"
            let msg_type = "type=\(type.sf.description)"
            let msg_data = "data=\(data.sf.toHex())"
            logTry(tag: SF_Tag_Peripheral_WriteCharacteristicValue_Start,
                   msgs: [msg_peripheral, msg_characteristic, msg_type, msg_data],
                   result: nil)
        }
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
    public func setNotifyValue(id: UUID, enabled: Bool, for characteristic: CBCharacteristic) {
        // do
        self.id = id
        peripheral.setNotifyValue(enabled, for: characteristic)
        // log
        if logOption.contains(.setCharacteristicNotificationStateStart) {
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_characteristic = "characteristic=\(characteristic.sf.description)"
            let msg_enabled = "enabled=\(enabled)"
            logTry(tag: SF_Tag_Peripheral_SetCharacteristicNotificationState_Start,
                   msgs: [msg_peripheral, msg_characteristic, msg_enabled],
                   result: nil)
        }
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
    public func discoverDescriptors(id: UUID, for characteristic: CBCharacteristic) {
        // do
        self.id = id
        peripheral.discoverDescriptors(for: characteristic)
        // log
        if logOption.contains(.discoverDescriptorsStart) {
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_characteristic = "characteristic=\(characteristic.sf.description)"
            logTry(tag: SF_Tag_Peripheral_DiscoverDescriptors_Start,
                   msgs: [msg_peripheral, msg_characteristic],
                   result: nil)
        }
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
    public func readValue(id: UUID, for descriptor: CBDescriptor) {
        // do
        self.id = id
        peripheral.readValue(for: descriptor)
        // log
        if logOption.contains(.readDescriptorValueStart) {
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_descriptor = "descriptor=\(descriptor.sf.description)"
            logTry(tag: SF_Tag_Peripheral_ReadDescriptorValue_Start,
                   msgs: [msg_peripheral, msg_descriptor],
                   result: nil)
        }
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
    public func writeValue(id: UUID, data: Data, for descriptor: CBDescriptor) {
        // do
        self.id = id
        peripheral.writeValue(data, for: descriptor)
        // log
        if logOption.contains(.writeDescriptorValueStart) {
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_descriptor = "descriptor=\(descriptor.sf.description)"
            let msg_data = "data=\(data.sf.toHex())"
            logTry(tag: SF_Tag_Peripheral_WriteDescriptorValue_Start,
                   msgs: [msg_peripheral, msg_descriptor, msg_data],
                   result: nil)
        }
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
    public func openL2CAPChannel(id: UUID, PSM: CBL2CAPPSM) {
        // do
        self.id = id
        peripheral.openL2CAPChannel(PSM)
        // log
        if logOption.contains(.openL2CAPChannelStart) {
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_PSM = "PSM=\(PSM)"
            logTry(tag: SF_Tag_Peripheral_OpenL2CAPChannel_Start,
                   msgs: [msg_peripheral, msg_PSM],
                   result: nil)
        }
    }
}

// MARK: - CBPeripheralDelegate
extension SFBlePeripheral: CBPeripheralDelegate {
    
    
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
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            logCallback(tag: SF_Tag_Peripheral_Name_DidUpdated,
                   msgs: [msg_peripheral])
        }
        // callback
        didUpdateName?(peripheral)
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
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            var msg_invalidatedServices = "invalidatedServices=["
            for invalidatedService in invalidatedServices {
                msg_invalidatedServices.append(invalidatedService.sf.description)
            }
            msg_invalidatedServices.append("]")
            logCallback(tag: SF_Tag_Peripheral_Services_DidModified,
                   msgs: [msg_peripheral, msg_invalidatedServices])
        }
        // callback
        didModifyServices?(peripheral, invalidatedServices)
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
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            logCallback(tag: SF_Tag_Peripheral_RSSI_DidUpdated,
                   msgs: [msg_peripheral, msg_error])
        }
        // callback
        didUpdateRSSI?(peripheral, error)
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
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_RSSI = "RSSI=\(RSSI)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            logCallback(tag: SF_Tag_Peripheral_ReadRSSI_Success,
                   msgs: [msg_peripheral, msg_RSSI, msg_error])
        }
        // callback
        didReadRSSI?(peripheral, RSSI, error)
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
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            logCallback(tag: SF_Tag_Peripheral_DiscoverServices_Success,
                   msgs: [msg_peripheral, msg_error])
        }
        // callback
        didDiscoverServices?(peripheral, error)
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
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_service = "service=\(service.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            logCallback(tag: SF_Tag_Peripheral_DiscoverIncludedServices_Success,
                   msgs: [msg_peripheral, msg_service, msg_error])
        }
        // callback
        didDiscoverIncludedServices?(peripheral, service, error)
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
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_service = "service=\(service.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            logCallback(tag: SF_Tag_Peripheral_DiscoverCharacteristics_Success,
                   msgs: [msg_peripheral, msg_service, msg_error])
        }
        // callback
        didDiscoverCharacteristics?(peripheral, service, error)
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
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_characteristic = "characteristic=\(characteristic.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            logCallback(tag: SF_Tag_Peripheral_ReadCharacteristicValue_Success,
                   msgs: [msg_peripheral, msg_characteristic, msg_error])
        }
        // callback
        didUpdateValueForCharacteristic?(peripheral, characteristic, error)
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
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_characteristic = "characteristic=\(characteristic.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            logCallback(tag: SF_Tag_Peripheral_WriteCharacteristicValue_Success,
                   msgs: [msg_peripheral, msg_characteristic, msg_error])
        }
        // callback
        didWriteValueForCharacteristic?(peripheral, characteristic, error)
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
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_characteristic = "characteristic=\(characteristic.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            logCallback(tag: SF_Tag_Peripheral_SetCharacteristicNotificationState_Success,
                   msgs: [msg_peripheral, msg_characteristic, msg_error])
        }
        // callback
        didUpdateNotificationStateForCharacteristic?(peripheral, characteristic, error)
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
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_characteristic = "characteristic=\(characteristic.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            logCallback(tag: SF_Tag_Peripheral_DiscoverDescriptors_Success,
                   msgs: [msg_peripheral, msg_characteristic, msg_error])
        }
        // callback
        didDiscoverDescriptorsForCharacteristic?(peripheral, characteristic, error)
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
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_descriptor = "descriptor=\(descriptor.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            logCallback(tag: SF_Tag_Peripheral_ReadDescriptorValue_Success,
                   msgs: [msg_peripheral, msg_descriptor, msg_error])
        }
        // callback
        didUpdateValueForDescriptor?(peripheral, descriptor, error)
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
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            let msg_descriptor = "descriptor=\(descriptor.sf.description)"
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            logCallback(tag: SF_Tag_Peripheral_WriteDescriptorValue_Success,
                   msgs: [msg_peripheral, msg_descriptor, msg_error])
        }
        // callback
        didWriteValueForDescriptor?(peripheral, descriptor, error)
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
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            logCallback(tag: SF_Tag_Peripheral_IsReadyToSendWriteWithoutResponse,
                   msgs: [msg_peripheral])
        }
        // callback
        isReadyToSendWriteWithoutResponse?(peripheral)
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
            let msg_peripheral = "peripheral=\(peripheral.sf.description)"
            var msg_channel = "channel=nil"
            if let channel = channel {
                msg_channel = "channel=\(channel.description)"
            }   
            var msg_error = "error=nil"
            if let error = error {
                msg_error = "error=\(error.localizedDescription)"
            }
            logCallback(tag: SF_Tag_Peripheral_OpenL2CAPChannel_Success,
                   msgs: [msg_peripheral, msg_channel, msg_error])
        }
        // callback
        didOpenChannel?(peripheral, channel, error)
    }
}
