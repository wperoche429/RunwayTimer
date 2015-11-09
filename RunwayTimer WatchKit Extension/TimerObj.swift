//
//  TimerObj.swift
//  RunwayTimer
//
//  Created by William Peroche on 9/11/15.
//  Copyright © 2015 William Peroche. All rights reserved.
//

import WatchKit

class TimerObj: NSObject {

    var name : String = ""
    var timer : Int = 0
    var isRunning = false
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeInteger(timer, forKey: "timer")
        aCoder.encodeBool(isRunning, forKey: "isRunning")
    }
    
    init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String
        timer = aDecoder.decodeIntegerForKey("timer")
        isRunning = aDecoder.decodeBoolForKey("isRunning")
    }
    
    override init() {
        
    }
    
    class func retrieveAllTimers() -> [TimerObj]? {
        
        if let saveTimersArray = NSUserDefaults.standardUserDefaults().objectForKey("saveTimers") {
            var saveObjArray : [TimerObj] = []
            for data in saveTimersArray as! NSArray {
                saveObjArray.append(NSKeyedUnarchiver.unarchiveObjectWithData(data as! (NSData)) as! TimerObj)
            }
            
            return saveObjArray
        }
        
        return nil
    }
    
    class func addTimer(obj : TimerObj) {
        var timers = TimerObj.retrieveAllTimers()
        if  timers == nil {
            timers = []
        }
        
        var saveObjArray : [NSData] = []
        
        for saveObj in timers! {
            let userData = NSKeyedArchiver.archivedDataWithRootObject(saveObj)
            saveObjArray.append(userData)
        }
        
        saveObjArray.append(NSKeyedArchiver.archivedDataWithRootObject(obj))
        NSUserDefaults.standardUserDefaults().setObject(saveObjArray, forKey: "saveTimers")
    }
    
    class func createDummyTimer() {
        
        for index in 0...5 {
            let timerObj = TimerObj()
            timerObj.name = "Name " + String(index)
            timerObj.timer = (index + 3) * 4
            timerObj.isRunning = false
            TimerObj.addTimer(timerObj)
        }
    }
}
