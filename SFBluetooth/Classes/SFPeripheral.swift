//
//  SFPeripheral.swift
//  SFBluetooth
//
//  Created by hsf on 2024/9/12.
//

import Foundation
import CoreBluetooth
// Server
import SFLogger

// MARK: - SFPeripheral
public class SFPeripheral: NSObject {
    // MARK: var
    public let peripheral: CBPeripheral
    public var isLogEnable = true
    
    // MARK: block
    public var didUpdateNameBlock: ((CBPeripheral) -> ())?
    public var didModifyServicesBlock: ((CBPeripheral, [CBService]) -> ())?
    public var didUpdateRSSIBlock: ((CBPeripheral, (any Error)?) -> ())?
    public var didReadRSSIBlock: ((CBPeripheral, NSNumber, (any Error)?) -> ())?
    public var didDiscoverServicesBlock: ((CBPeripheral, (any Error)?) -> ())?
    public var didDiscoverIncludedServicesForServiceBlock: ((CBPeripheral, CBService, (any Error)?) -> ())?
    public var didDiscoverCharacteristicsForServiceBlock: ((CBPeripheral, CBService, (any Error)?) -> ())?
    public var didUpdateValueForCharacteristicBlock: ((CBPeripheral, CBCharacteristic, (any Error)?) -> ())?
    public var didWriteValueForCharacteristicBlock: ((CBPeripheral, CBCharacteristic, (any Error)?) -> ())?
    public var didUpdateNotificationStateForCharacteristicBlock: ((CBPeripheral, CBCharacteristic, (any Error)?) -> ())?
    public var didDiscoverDescriptorsForCharacteristicBlock: ((CBPeripheral, CBCharacteristic, (any Error)?) -> ())?
    public var didUpdateValueForDescriptorBlock: ((CBPeripheral, CBDescriptor, (any Error)?) -> ())?
    public var didWriteValueForDescriptorBlock: ((CBPeripheral, CBDescriptor, (any Error)?) -> ())?
    public var isReadyToSendWriteWithoutResponseBlock: ((CBPeripheral) -> ())?
    public var didOpenChannelBlock: ((CBPeripheral, CBL2CAPChannel?, (any Error)?) -> ())?
    
    // MARK: life cycle
    public init(peripheral: CBPeripheral) {
        self.peripheral = peripheral
        super.init()
        peripheral.delegate = self
    }
       
}

extension SFPeripheral {
    /**
     *  @method readRSSI
     *
     *  @discussion While connected, retrieves the current RSSI of the link.
     *
     *  @see        peripheral:didReadRSSI:error:
     */
    public func readRSSI() {
        peripheral.readRSSI()
        if isLogEnable {
            Log.info("peripheral=\(peripheral)")
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
    public func discoverServices(_ serviceUUIDs: [CBUUID]?) {
        peripheral.discoverServices(serviceUUIDs)
        if isLogEnable {
            Log.info("peripheral=\(peripheral) serviceUUIDs=\(serviceUUIDs)")
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
    public func discoverIncludedServices(_ includedServiceUUIDs: [CBUUID]?, for service: CBService) {
        peripheral.discoverIncludedServices(includedServiceUUIDs, for: service)
        if isLogEnable {
            Log.info("peripheral=\(peripheral) includedServiceUUIDs=\(includedServiceUUIDs) service=\(service)")
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
    public func discoverCharacteristics(_ characteristicUUIDs: [CBUUID]?, for service: CBService) {
        peripheral.discoverCharacteristics(characteristicUUIDs, for: service)
        if isLogEnable {
            Log.info("peripheral=\(peripheral) characteristicUUIDs=\(characteristicUUIDs) service=\(service)")
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
    public func readValue(for characteristic: CBCharacteristic) {
        peripheral.readRSSI()
        if isLogEnable {
            Log.info("peripheral=\(peripheral)")
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
    public func maximumWriteValueLength(for type: CBCharacteristicWriteType) -> Int {
        let length = peripheral.maximumWriteValueLength(for: type)
        if isLogEnable {
            Log.info("peripheral=\(peripheral) type=\(type) -> length=\(length)")
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
    public func writeValue(_ data: Data, for characteristic: CBCharacteristic, type: CBCharacteristicWriteType) {
        peripheral.writeValue(data, for: characteristic, type: type)
        if isLogEnable {
            Log.info("peripheral=\(peripheral) data=\(data) characteristic=\(characteristic) type=\(type)")
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
    public func setNotifyValue(_ enabled: Bool, for characteristic: CBCharacteristic) {
        peripheral.setNotifyValue(enabled, for: characteristic)
        if isLogEnable {
            Log.info("peripheral=\(peripheral) enabled=\(enabled) characteristic=\(characteristic)")
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
    public func discoverDescriptors(for characteristic: CBCharacteristic) {
        peripheral.discoverDescriptors(for: characteristic)
        if isLogEnable {
            Log.info("peripheral=\(peripheral) characteristic=\(characteristic)")
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
    public func readValue(for descriptor: CBDescriptor) {
        peripheral.readValue(for: descriptor)
        if isLogEnable {
            Log.info("peripheral=\(peripheral) descriptor=\(descriptor)")
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
    public func writeValue(_ data: Data, for descriptor: CBDescriptor) {
        peripheral.writeValue(data, for: descriptor)
        if isLogEnable {
            Log.info("peripheral=\(peripheral) data=\(data) descriptor=\(descriptor)")
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
    public func openL2CAPChannel(_ PSM: CBL2CAPPSM) {
        peripheral.openL2CAPChannel(PSM)
        if isLogEnable {
            Log.info("peripheral=\(peripheral) PSM=\(PSM)")
        }
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
        if isLogEnable {
            Log.info("peripheral=\(peripheral)")
        }
        didUpdateNameBlock?(peripheral)
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
        if isLogEnable {
            Log.info("peripheral=\(peripheral) services=\(invalidatedServices)")
        }
        didModifyServicesBlock?(peripheral, invalidatedServices)
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
        if isLogEnable {
            Log.info("peripheral=\(peripheral) error=\(error?.localizedDescription ?? "nil")")
        }
        didUpdateRSSIBlock?(peripheral, error)
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
        if isLogEnable {
            Log.info("peripheral=\(peripheral) RSSI=\(RSSI) error=\(error?.localizedDescription ?? "nil")")
        }
        didReadRSSIBlock?(peripheral, RSSI, error)
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
        if isLogEnable {
            Log.info("peripheral=\(peripheral) error=\(error?.localizedDescription ?? "nil")")
        }
        didDiscoverServicesBlock?(peripheral, error)
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
        if isLogEnable {
            Log.info("peripheral=\(peripheral) service=\(service) error=\(error?.localizedDescription ?? "nil")")
        }
        didDiscoverIncludedServicesForServiceBlock?(peripheral, service, error)
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
        if isLogEnable {
            Log.info("peripheral=\(peripheral) service=\(service) error=\(error?.localizedDescription ?? "nil")")
        }
        didDiscoverCharacteristicsForServiceBlock?(peripheral, service, error)
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
        if isLogEnable {
            Log.info("peripheral=\(peripheral) characteristic=\(characteristic) error=\(error?.localizedDescription ?? "nil")")
        }
        didUpdateValueForCharacteristicBlock?(peripheral, characteristic, error)
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
        if isLogEnable {
            Log.info("peripheral=\(peripheral) characteristic=\(characteristic) error=\(error?.localizedDescription ?? "nil")")
        }
        didWriteValueForCharacteristicBlock?(peripheral, characteristic, error)
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
        if isLogEnable {
            Log.info("peripheral=\(peripheral) characteristic=\(characteristic) error=\(error?.localizedDescription ?? "nil")")
        }
        didUpdateNotificationStateForCharacteristicBlock?(peripheral, characteristic, error)
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
        if isLogEnable {
            Log.info("peripheral=\(peripheral) characteristic=\(characteristic) error=\(error?.localizedDescription ?? "nil")")
        }
        didDiscoverDescriptorsForCharacteristicBlock?(peripheral, characteristic, error)
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
        if isLogEnable {
            Log.info("peripheral=\(peripheral) descriptor=\(descriptor) error=\(error?.localizedDescription ?? "nil")")
        }
        didUpdateValueForDescriptorBlock?(peripheral, descriptor, error)
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
        if isLogEnable {
            Log.info("peripheral=\(peripheral) descriptor=\(descriptor) error=\(error?.localizedDescription ?? "nil")")
        }
        didWriteValueForDescriptorBlock?(peripheral, descriptor, error)
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
        if isLogEnable {
            Log.info("peripheral=\(peripheral)")
        }
        isReadyToSendWriteWithoutResponseBlock?(peripheral)
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
        if isLogEnable {
            Log.info("peripheral=\(peripheral) channel=\(channel?.description ?? nil) error=\(error?.localizedDescription ?? "nil")")
        }
        didOpenChannelBlock?(peripheral, channel, error)
    }
}
