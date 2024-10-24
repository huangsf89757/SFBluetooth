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



// MARK: - SFBlePeripheral
public class SFBlePeripheral: NSObject {
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
    /// 唯一标识
    public var id = UUID()
    /// 外围设备
    public let peripheral: CBPeripheral
    /// 插件
    public var plugins: [SFBlePeripheralPlugin] = [SFBlePeripheralLogPlugin()]
    
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
                // plugins
                plugins.forEach { plugin in
                    plugin.peripheral(peripheral, didUpdateState: id, state: state)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, readRSSI: id)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, discoverServices: id, serviceUUIDs: serviceUUIDs)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, discoverIncludedServices: id, includedServiceUUIDs: includedServiceUUIDs, for: service)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, discoverCharacteristics: id, characteristicUUIDs: characteristicUUIDs, for: service)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, readValue: id, for: characteristic)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, getMaximumWriteValueLength: id, for: type, return: length)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, writeValue: id, data: data, for: characteristic, type: type)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, setNotifyValue: id, enabled: enabled, for: characteristic)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, discoverDescriptors: id, for: characteristic)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, readValue: id, for: descriptor)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, writeValue: id, data: data, for: descriptor)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, openL2CAPChannel: id, PSM: PSM)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, didUpdateName: id, name: peripheral.name)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, didModifyServices: id, invalidatedServices: invalidatedServices)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, didUpdateRSSI: id, RSSI: peripheral.rssi, error: error)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, didReadRSSI: id, RSSI: RSSI, error: error)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, didDiscoverServices: id, error: error)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, didDiscoverIncludedServices: id, for: service, error: error)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, didDiscoverCharacteristics: id, for: service, error: error)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, didUpdateValue: id, for: characteristic, error: error)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, didWriteValue: id, for: characteristic, error: error)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, didUpdateNotificationState: id, for: characteristic, error: error)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, didDiscoverDescriptors: id, for: characteristic, error: error)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, didUpdateValue: id, for: descriptor, error: error)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, didWriteValue: id, for: descriptor, error: error)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, isReadyToSendWriteWithoutResponse: id)
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
        // plugins
        plugins.forEach { plugin in
            plugin.peripheral(peripheral, didOpen: id, channel: channel, error: error)
        }
        // callback
        didOpenChannel?(peripheral, channel, error)
    }
}
