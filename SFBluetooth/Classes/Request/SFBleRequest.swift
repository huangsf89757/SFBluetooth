//
//  SFBleRequest.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/24.
//

import Foundation

/*
 startScan
 peripheral
 stopScan
 connectPeripheral
 readRssi
 
 if connected {
    readRssi
 }
 else if peripheral {
    connectPeripheral
    readRssi
 }
 else if isScanning {
     stopScan
     connectPeripheral
     readRssi
 }
 
 有一个过程需要顺序经过 A,B,C,D,E... 随机个数的步骤，才算成功。
 每个步骤都可以认为是一个耗时的步骤
 每个步骤的执行都需要依赖上一个步骤的成功完成结果，如A的结果是a，B的结果是b ...
 且支持从任一点随机开始。比如：如果已经有了A的结果a，则可以直接从B开始；如果已经有了结果a、b、c，则直接从步骤D开始
 根据这种场景，请用swift设计代码。
 
 */
