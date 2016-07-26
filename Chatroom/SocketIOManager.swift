//
//  SocketIOManager.swift
//  Chatroom
//
//  Created by eugene golovanov on 7/26/16.
//  Copyright © 2016 eugene golovanov. All rights reserved.
//

import Foundation

class SocketIOManager: NSObject {
    
    //----------------------------------------------------------------------------------------
    //MARK: - Properties
    
    static let sharedInstance = SocketIOManager()
    
//    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://localhost:3000")!)
//    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://192.168.0.2:3000")!)//HOME
    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://192.168.10.234:3000")!)//WORK
    
    
    
    //----------------------------------------------------------------------------------------
    //MARK: - Init
    
    
    override init() {
        super.init()
    }
    
    
    
    //----------------------------------------------------------------------------------------
    //MARK: - Connection
    
    func establishConnection() {
        socket.connect()
    }
    
    
    func closeConnection() {
        socket.disconnect()
    }
    
    
    func connectToChatroomWithNickname(chatroom chatroom:String, nickname: String) {
        socket.emit("joinRoom", [
            "name": nickname,
            "room": chatroom
            ])
    }
    
    
    
    //----------------------------------------------------------------------------------------
    //MARK: - Messages
    
//    func sendMessage(message: String, withNickname nickname: String) {
//        socket.emit("chatMessage", nickname, message)
//    }
    
    
    func getChatMessage(completionHandler: (messageInfo: [String: AnyObject]) -> Void) {
        socket.on("message") { (dataArray, socketAck) -> Void in
            
            guard let data = dataArray.first else {
                print("something wrong with message data")
                return
            }
//            print("-----------------------------------------------------")
//            print("dataArray: \(data["name"])")
//            print("\nsocketAck: \(socketAck)")
            var messageDictionary = [String: AnyObject]()
            messageDictionary["name"] = data["name"] as? String
            messageDictionary["text"] = data["text"] as? String
            messageDictionary["timestamp"] = data["timestamp"]
            completionHandler(messageInfo: messageDictionary)
//            print("-----------------------------------------------------")
        }
    }
    
    
}
