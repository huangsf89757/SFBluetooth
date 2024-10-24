//
//  SFBlePeripheralPlugin.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/23.
//

import Foundation
import CoreBluetooth

// MARK: - Tag
public let SF_Tag_Peripheral_DidUpdate_State =                                  "Tag_Peripheral_DidUpdate_State"
public let SF_Tag_Peripheral_DidUpdate_Name =                                   "Tag_Peripheral_Name_DidUpdated"
public let SF_Tag_Peripheral_DidModifie_Services =                              "Tag_Peripheral_DidModifie_Services"
public let SF_Tag_Peripheral_DidUpdate_RSSI =                                   "Tag_Peripheral_DidUpdate_RSSI"

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


// MARK: - SFBlePeripheralPlugin
public protocol SFBlePeripheralPlugin {
    func peripheral(_ peripheral: CBPeripheral, readRSSI id: UUID)

    func peripheral(_ peripheral: CBPeripheral, discoverServices id: UUID, serviceUUIDs: [CBUUID]?)

    func peripheral(_ peripheral: CBPeripheral, discoverIncludedServices id: UUID, includedServiceUUIDs: [CBUUID]?, for service: CBService)

    func peripheral(_ peripheral: CBPeripheral, discoverCharacteristics id: UUID, characteristicUUIDs: [CBUUID]?, for service: CBService)
    
    func peripheral(_ peripheral: CBPeripheral, readValue id: UUID, for characteristic: CBCharacteristic)

    @available(iOS 9.0, *)
    func peripheral(_ peripheral: CBPeripheral, getMaximumWriteValueLength id: UUID, for type: CBCharacteristicWriteType, return length: Int)
    
    func peripheral(_ peripheral: CBPeripheral, writeValue id: UUID, data: Data, for characteristic: CBCharacteristic, type: CBCharacteristicWriteType)

    func peripheral(_ peripheral: CBPeripheral, setNotifyValue id: UUID, enabled: Bool, for characteristic: CBCharacteristic)

    func peripheral(_ peripheral: CBPeripheral, discoverDescriptors id: UUID, for characteristic: CBCharacteristic)

    func peripheral(_ peripheral: CBPeripheral, readValue id: UUID, for descriptor: CBDescriptor)

    func peripheral(_ peripheral: CBPeripheral, writeValue id: UUID, data: Data, for descriptor: CBDescriptor)

    @available(iOS 11.0, *)
    func peripheral(_ peripheral: CBPeripheral, openL2CAPChannel id: UUID, PSM: CBL2CAPPSM)
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateState id: UUID, state: CBPeripheralState)

    @available(iOS 6.0, *)
    func peripheral(_ peripheral: CBPeripheral, didUpdateName id: UUID, name: String?)

    @available(iOS 7.0, *)
    func peripheral(_ peripheral: CBPeripheral, didModifyServices id: UUID, invalidatedServices: [CBService])

    @available(iOS, introduced: 5.0, deprecated: 8.0)
    func peripheral(_ peripheral: CBPeripheral, didUpdateRSSI id: UUID, RSSI: NSNumber?, error: (any Error)?)

    @available(iOS 8.0, *)
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI id: UUID, RSSI: NSNumber, error: (any Error)?)

    @available(iOS 5.0, *)
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices id: UUID, error: (any Error)?)

    @available(iOS 5.0, *)
    func peripheral(_ peripheral: CBPeripheral, didDiscoverIncludedServices id: UUID, for service: CBService, error: (any Error)?)

    @available(iOS 5.0, *)
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristics id: UUID, for service: CBService, error: (any Error)?)

    @available(iOS 5.0, *)
    func peripheral(_ peripheral: CBPeripheral, didUpdateValue id: UUID, for characteristic: CBCharacteristic, error: (any Error)?)
    
    @available(iOS 5.0, *)
    func peripheral(_ peripheral: CBPeripheral, didWriteValue id: UUID, for characteristic: CBCharacteristic, error: (any Error)?)

    @available(iOS 5.0, *)
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationState id: UUID, for characteristic: CBCharacteristic, error: (any Error)?)

    @available(iOS 5.0, *)
    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptors id: UUID, for characteristic: CBCharacteristic, error: (any Error)?)

    @available(iOS 5.0, *)
    func peripheral(_ peripheral: CBPeripheral, didUpdateValue id: UUID, for descriptor: CBDescriptor, error: (any Error)?)

    @available(iOS 5.0, *)
    func peripheral(_ peripheral: CBPeripheral, didWriteValue id: UUID, for descriptor: CBDescriptor, error: (any Error)?)

    @available(iOS 5.0, *)
    func peripheral(_ peripheral: CBPeripheral, isReadyToSendWriteWithoutResponse id: UUID)

    @available(iOS 11.0, *)
    func peripheral(_ peripheral: CBPeripheral, didOpen id: UUID, channel: CBL2CAPChannel?, error: (any Error)?)
}


extension SFBlePeripheralPlugin {
    func peripheral(_ peripheral: CBPeripheral, readRSSI id: UUID) {}

    func peripheral(_ peripheral: CBPeripheral, discoverServices id: UUID, serviceUUIDs: [CBUUID]?) {}

    func peripheral(_ peripheral: CBPeripheral, discoverIncludedServices id: UUID, includedServiceUUIDs: [CBUUID]?, for service: CBService) {}

    func peripheral(_ peripheral: CBPeripheral, discoverCharacteristics id: UUID, characteristicUUIDs: [CBUUID]?, for service: CBService) {}
    
    func peripheral(_ peripheral: CBPeripheral, readValue id: UUID, for characteristic: CBCharacteristic) {}

    @available(iOS 9.0, *)
    func peripheral(_ peripheral: CBPeripheral, getMaximumWriteValueLength id: UUID, for type: CBCharacteristicWriteType, return length: Int) {}
    
    func peripheral(_ peripheral: CBPeripheral, writeValue id: UUID, data: Data, for characteristic: CBCharacteristic, type: CBCharacteristicWriteType) {}

    func peripheral(_ peripheral: CBPeripheral, setNotifyValue id: UUID, enabled: Bool, for characteristic: CBCharacteristic) {}

    func peripheral(_ peripheral: CBPeripheral, discoverDescriptors id: UUID, for characteristic: CBCharacteristic) {}

    func peripheral(_ peripheral: CBPeripheral, readValue id: UUID, for descriptor: CBDescriptor) {}

    func peripheral(_ peripheral: CBPeripheral, writeValue id: UUID, data: Data, for descriptor: CBDescriptor) {}

    @available(iOS 11.0, *)
    func peripheral(_ peripheral: CBPeripheral, openL2CAPChannel id: UUID, PSM: CBL2CAPPSM) {}

    func peripheral(_ peripheral: CBPeripheral, didUpdateState id: UUID, state: CBPeripheralState) {}
    
    @available(iOS 6.0, *)
    func peripheral(_ peripheral: CBPeripheral, didUpdateName id: UUID, name: String?) {}

    @available(iOS 7.0, *)
    func peripheral(_ peripheral: CBPeripheral, didModifyServices id: UUID, invalidatedServices: [CBService]) {}

    @available(iOS, introduced: 5.0, deprecated: 8.0)
    func peripheral(_ peripheral: CBPeripheral, didUpdateRSSI id: UUID, RSSI: NSNumber?, error: (any Error)?) {}

    @available(iOS 8.0, *)
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI id: UUID, RSSI: NSNumber, error: (any Error)?) {}

    @available(iOS 5.0, *)
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices id: UUID, error: (any Error)?) {}

    @available(iOS 5.0, *)
    func peripheral(_ peripheral: CBPeripheral, didDiscoverIncludedServices id: UUID, for service: CBService, error: (any Error)?) {}

    @available(iOS 5.0, *)
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristics id: UUID, for service: CBService, error: (any Error)?) {}

    @available(iOS 5.0, *)
    func peripheral(_ peripheral: CBPeripheral, didUpdateValue id: UUID, for characteristic: CBCharacteristic, error: (any Error)?) {}
    
    @available(iOS 5.0, *)
    func peripheral(_ peripheral: CBPeripheral, didWriteValue id: UUID, for characteristic: CBCharacteristic, error: (any Error)?) {}

    @available(iOS 5.0, *)
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationState id: UUID, for characteristic: CBCharacteristic, error: (any Error)?) {}

    @available(iOS 5.0, *)
    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptors id: UUID, for characteristic: CBCharacteristic, error: (any Error)?) {}

    @available(iOS 5.0, *)
    func peripheral(_ peripheral: CBPeripheral, didUpdateValue id: UUID, for descriptor: CBDescriptor, error: (any Error)?) {}

    @available(iOS 5.0, *)
    func peripheral(_ peripheral: CBPeripheral, didWriteValue id: UUID, for descriptor: CBDescriptor, error: (any Error)?) {}

    @available(iOS 5.0, *)
    func peripheral(_ peripheral: CBPeripheral, isReadyToSendWriteWithoutResponse id: UUID) {}

    @available(iOS 11.0, *)
    func peripheral(_ peripheral: CBPeripheral, didOpen id: UUID, channel: CBL2CAPChannel?, error: (any Error)?) {}
}
