//
//  TimerManager.swift
//  RunwayTimer
//
//  Created by William Peroche on 9/11/15.
//  Copyright © 2015 William Peroche. All rights reserved.
//

import Foundation

class TimerManager {
    static let sharedInstance = TimerManager()
    var timers : [Time]?
    
    init () {
        self.timers = []
        if let timerArray = NSUserDefaults.standardUserDefaults().objectForKey("saveTimers") as? [NSData] {
            for data in timerArray {
                self.timers?.append(NSKeyedUnarchiver.unarchiveObjectWithData(data) as! Time)
            }
        }
    }
    
    func addTimer(time : Time) {
        if (timers == nil) {
            timers = []
        }
        
        timers?.append(time)
        updateStorage()
    }
    
    func deleteTimer(time : Time) {
        if (timers == nil) {
            return
        }
        
        var index = 0
        for localTime in timers! {
            if localTime.id == time.id {
                self.timers?.removeAtIndex(index)
                break
            }
            index++
        }
        updateStorage()
        
    }
    
    func updateStorage() {
        var timerArray : [NSData] = []
        for timer in timers! {
            timerArray.append(NSKeyedArchiver.archivedDataWithRootObject(timer))
        }
        
        NSUserDefaults.standardUserDefaults().setObject(timerArray, forKey: "saveTimers")
    }
    
    
    func createDummyTimer () {
        for index in 0...3 {
            let time = Time()
            time.name = "Name " + String(index)
            time.hour = 0
            time.minute = index + 3 * index
            time.second = index + 2 * index
            time.timeStarted = nil
            addTimer(time)
        }
    }
    
}