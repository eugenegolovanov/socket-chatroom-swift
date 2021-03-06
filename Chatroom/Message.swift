//
//  Message.swift
//  Chatroom
//
//  Created by eugene golovanov on 7/27/16.
//  Copyright © 2016 eugene golovanov. All rights reserved.
//



import Foundation

////////////////////////PRETTY WAY////////////////////////

class Message: CustomDebugStringConvertible{
    
    var data:[String:AnyObject]
    var text:String = ""
    var name:String = ""
    var timestamp:Int = 0
    var timeString:String = ""
    
    init(data:[String:AnyObject]) {
        self.data = data
        self.text = data["text"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.timestamp = data["timestamp"] as? Int ?? 0
        
        //Date string
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMM yyy hh:mm:ss"
        self.timeString = dateFormatter.stringFromDate(NSDate(timeIntervalSince1970: NSTimeInterval(self.timestamp/1000)))

    }
    
    var debugDescription: String {
        return "<text: \(self.text), name:\(self.name), timestamp:\(self.timestamp), timeString:\(self.timeString)>"
    }
    
}





////////////////////////OLD WAY////////////////////////
//class Message {
//    
//    var text:String = ""
//    var name:String = ""
//    var timestamp:Int = 0
//    
//    init() {
//        //uncomment this line if your class has been inherited from any other class
////        super.init()
//    }
//    
//    convenience init(text:String, name:String, timestamp:Int) {
//        self.init()
//        self.text = text
//        self.name = name
//        self.timestamp = timestamp
//    }
//}

