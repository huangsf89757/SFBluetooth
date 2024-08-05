//
//  SFPeripheralDelegater.swift
//  SFBluetooth
//
//  Created by hsf on 2024/8/5.
//

import Foundation
import CoreBluetooth
// Server
import SFLogger


// MARK: - SFPeripheralDelegater
public class SFPeripheralDelegater: NSObject {
    
    // MARK: Block
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
    
    // MARK: log
    public var isLogEnable = true
}

extension SFPeripheralDelegater: CBPeripheralDelegate {
    
    
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
