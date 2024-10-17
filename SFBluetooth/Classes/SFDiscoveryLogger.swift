//
//  SFDiscoveryLogger.swift
//  SFBluetooth
//
//  Created by hsf on 2024/9/20.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger

// MARK: - SFDiscoveryLogger
public class SFDiscoveryLogger {
    // MARK: var
    /// 缓存
    public private(set) var deviceCache: [UUID: SFDiscoverDevice] = [:]
    
    /// 日志采样时间间隔
    public let timeInterval: TimeInterval
    /// 设备容量最大阈值
    public let threshold: Int
    /// 队列
    public let queue: DispatchQueue
    
    /// 发现次数
    public private(set) var count: Int = 0
    /// 第一次发现时间
    public private(set) var firstDate: Date?
    /// 上次发现时间
    public private(set) var lastDate: Date?
    
    
    
    
    // MARK: life cycle
    public init(timeInterval: TimeInterval = 30,
                threshold: Int = 20,
                queue: DispatchQueue = DispatchQueue(label: "com.SFBluetooth.DiscoveryLogger", qos: .utility)) {
        self.timeInterval = timeInterval
        self.threshold = threshold
        self.queue = queue
    }
    
    
    // MARK: func
    /// 采样
    public func log(peripheral: CBPeripheral, RSSI: NSNumber, msg: String) {
        queue.async { [weak self] in
            guard let self = self else { return }
            
            let identifier = peripheral.identifier
            let name = peripheral.name
            let rssi = RSSI.doubleValue
            let date = Date()
            
            if self.firstDate == nil {
                self.firstDate = date
            }
            self.count += 1

            if let device = self.deviceCache[identifier] {
                device.update(date: date, rssi: rssi)
            } else {
                let device = SFDiscoverDevice(identifier: identifier, name: name, date: date, rssi: rssi)
                self.deviceCache[identifier] = device
                Log.info(msg) // 第一次发现的要打印出来
            }
            
            self.check(date: date)
        }
    }
    
    /// 检查
    private func check(date: Date) {
        if let lastDate = lastDate {
            if date.timeIntervalSince(lastDate) >= timeInterval || deviceCache.count >= threshold {
                aggregateLog()
            } else {
                self.lastDate = date
            }
        } else {
            self.lastDate = date
        }
    }
    
    /// 聚合日志
    private func aggregateLog() {
        let sortedDevices = deviceCache.values.sorted { device1, device2 in
            device1.firstDate < device2.firstDate
        }
        let descriptions = sortedDevices.map { device in
            device.description()
        }
        Log.info("""
            
            发现设备汇总 (过去 \(Int(timeInterval))秒):
            时间: \(firstDate!) ~ \(lastDate!)
            总扫描次数: \(count)
            发现设备数: \(deviceCache.count)
            设备详情：
            \(descriptions.joined(separator: "\n"))
            
            """)
        reset()
    }
    
    /// 重置
    private func reset() {
        deviceCache.removeAll(keepingCapacity: true)
        lastDate = Date()
        count = 0
    }
}


// MARK: - SFDiscoverDevice
public class SFDiscoverDevice {
    /// id
    public private(set) var identifier: UUID
    /// 名称
    public private(set) var name: String?
    /// 第一次发现时间
    public private(set) var firstDate: Date
    /// 第一次发现RSSI
    public private(set) var firstRssi: Double
    
    
    /// 最后一次发现时间
    public private(set) var lastDate: Date!
    /// 最后一次发现RSSI
    public private(set) var lastRssi: Double!
    
    
    /// 历史记录
    public private(set) var histories: [[String: Any]] = []
    /// 发现次数
    public private(set) var count: Int = 1
    /// 平均RSSI
    public private(set) var avgRssi: Double = 0
    
   
    
    public init(identifier: UUID, name: String? = nil, date: Date, rssi: Double) {
        self.identifier = identifier
        self.name = name
        self.firstDate = date
        self.firstRssi = rssi
        update(date: date, rssi: rssi)
    }
    
    /// 更新
    public func update(date: Date, rssi: Double) {
        lastDate = date
        lastRssi = rssi
        let history: [String : Any] = [
            "date": date,
            "rssi": rssi
        ]
        histories.append(history)
        count = histories.count
        updateAvgRssi()
    }
    
    private func updateAvgRssi() {
        var sumRssi: Double = 0
        for his in histories {
            if let rssi = his["rssi"] as? Double {
                sumRssi += rssi
            }
        }
        avgRssi = sumRssi / Double(count)
    }
        
    /// description
    public func description() -> String {
        return "{identifier:\(identifier) name:\(name ?? "nil") firstDate:\(firstDate) lastDate:\(lastDate!) firstRssi:\(firstRssi) lastRssi:\(lastRssi!) count:\(count) avgRssi:\(avgRssi)}"
    }
}
