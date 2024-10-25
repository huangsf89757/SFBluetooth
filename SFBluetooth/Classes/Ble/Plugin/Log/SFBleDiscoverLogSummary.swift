//
//  SFBleDiscoverLogSummary.swift
//  SFBluetooth
//
//  Created by hsf on 2024/10/25.
//

import Foundation
import CoreBluetooth
// Basic
import SFExtension
// Server
import SFLogger


// MARK: - SFBleDiscoverLogSummary
public class SFBleDiscoverLogSummary {
    public private(set) lazy var timer: DispatchSourceTimer = {
        DispatchSource.makeTimerSource()
    }()
    public let id: UUID
    public let tag: String
    public let duration: TimeInterval
    public let itemThreshold: Int
    public let logThreshold: Int
    public var firstTimeLogEnable = false
    public private(set) var items = [SFBleDiscoverLogItem]()
    public private(set) var summaryTime: Date?
    public var size: Int {
        items.count
    }
    public var firstTime: Date? {
        items.first?.firstTime
    }
    public var lastTime: Date? {
        items.last?.lastTime
    }
    public init(id: UUID,
                tag: String,
                duration: TimeInterval = 60,
                itemThreshold: Int = 20,
                logThreshold: Int = 10) {
        self.id = id
        self.tag = tag
        self.duration = duration
        self.itemThreshold = itemThreshold
        self.logThreshold = logThreshold
        self.timer.schedule(deadline: .now(), repeating: duration)
        self.timer.setEventHandler {
            self.clean(because: "duration")
        }
    }
    public func update(log: SFBleDiscoverLog) {
        let id = log.id
        let identifier = log.peripheral.identifier
        let item = items.first { element in
            (element.id == id) && element.identifier == identifier
        }
        if let item = item {
            item.update(log: log)
        } else {
            let item = SFBleDiscoverLogItem(id: id, tag: tag, identifier: identifier, threshold: logThreshold, firstTimeLogEnable: firstTimeLogEnable)
            item.update(log: log)
            items.append(item)
        }
        if size > itemThreshold {
            clean(because: "threshold")
        }
    }
    public func clean(because: String) {
        guard items.count > 0 else { return }
        let msg_because = "because: \(because)"
        let msg_count = "count: \(items.count)\n"
        let msg_detail = "========== DETAIL ==========\n"
        var msgs = [String]()
        msgs.append(msg_because)
        msgs.append(msg_count)
        msgs.append(msg_detail)
        for i in 0..<items.count {
            let item = items[i]
            msgs.append("【\(i)】")
            msgs.append(contentsOf: item.summaryMsgs)
            msgs.append("")
            if i < items.count - 1 {
                msgs.append("----------\n")
            }
        }
        Log.bleSummary(id: id, tag: tag, msgs: msgs)
        summaryTime = Date()
        items = []
    }
}

// MARK: - SFBleDiscoverLogItem
public class SFBleDiscoverLogItem {
    public let id: UUID
    public let tag: String
    public let identifier: UUID
    public let threshold: Int
    public let firstTimeLogEnable: Bool
    public private(set) var logs = [SFBleDiscoverLog]()
    public var firstTime: Date {
        logs.first?.time ?? Date(timeIntervalSince1970: 0)
    }
    public var firstRssi: Double {
        logs.first?.rssi.doubleValue ?? 0
    }
    public var lastTime: Date {
        logs.last?.time ?? Date(timeIntervalSince1970: 0)
    }
    public var lastRssi: Double {
        logs.last?.rssi.doubleValue ?? 0
    }
    public var avgRssi: Double {
        guard logs.count > 0 else {
            return 0
        }
        let sum = logs.reduce(into: 0) { result, log in
            result += log.rssi.doubleValue
        }
        return sum / Double(logs.count)
    }
    public init(id: UUID,
                tag: String,
                identifier: UUID,
                threshold: Int,
                firstTimeLogEnable: Bool) {
        self.id = id
        self.tag = tag
        self.identifier = identifier
        self.threshold = threshold
        self.firstTimeLogEnable = firstTimeLogEnable
    }
    public func update(log: SFBleDiscoverLog) {
        logs.append(log)
        if firstTimeLogEnable, logs.count == 1 {
            Log.bleSummary(id: id, tag: tag, msgs: summaryMsgs)
        }
        if logs.count > threshold {
            clean()
        }
    }
    public func clean() {
        guard logs.count > 0 else { return }
        Log.bleSummary(id: id, tag: tag, msgs: summaryMsgs)
        logs = []
    }
    
    public var summaryMsgs: [String] {
        guard logs.count > 0 else { return [] }
        let lastLog = logs[logs.count-1]
        let msg_name = "name: \(lastLog.peripheral.name ?? "UNKNOWN")"
        let msg_identifier = "identifier: \(identifier)"
        let msg_count = "count: \(logs.count)"
        let msg_first = "first: \(firstTime) \(firstRssi) dBm"
        let msg_last = "last: \(lastTime) \(lastRssi) dBm"
        let msg_avg = "avg: \(avgRssi) dBm"
        let msg_LAST = "[LAST]:"
        let msg_peripheral = "peripheral=\(lastLog.peripheral.sf.description)"
        let msg_RSSI = "RSSI=\(lastLog.rssi)"
        let msg_advertisementData = "advertisementData=\(lastLog.advertisementData)"
        return [msg_name, msg_identifier, msg_count, msg_first, msg_last, msg_avg, msg_LAST, msg_peripheral, msg_RSSI, msg_advertisementData]
    }
}


// MARK: - SFBleDiscoverLog
public struct SFBleDiscoverLog {
    public let id: UUID
    public let time: Date
    public let peripheral: CBPeripheral
    public let advertisementData: [String : Any]
    public let rssi: NSNumber
}
