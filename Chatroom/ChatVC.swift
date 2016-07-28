//
//  ChatVC.swift
//  Chatroom
//
//  Created by eugene golovanov on 7/26/16.
//  Copyright © 2016 eugene golovanov. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {


    //---------------------------------------------------------------------------
    // MARK: - Properties
    
    @IBOutlet weak var tableViewChat: UITableView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    
    @IBOutlet weak var messageTextField: UITextField!
    
    var messagesArray = Array<Message>()
    //---------------------------------------------------------------------------
    // MARK: - View Lifecycle

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChatVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        tableViewChat.delegate = self
        tableViewChat.dataSource = self
        tableViewChat.registerNib(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "chatCell")

        

//        self.fakeData()

    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
                
        //RECEIVING MESSAGES
        SocketIOManager.sharedInstance.getChatMessage { (messageInfo) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                print("----------------------MESSAGE INFO:-------------------------------")
                let message = Message(data: messageInfo)
                self.messagesArray.append(message)
                self.tableViewChat.reloadData()
                self.tableViewScrollToBottom(tableView: self.tableViewChat, animated: true)
                print("Received Message: \(message)")
                print("-----------------------------------------------------")                
            })
        }
    }

    
    //---------------------------------------------------------------------------
    // MARK: - Table view scroll aniated

    
    func tableViewScrollToBottom(tableView tableView:UITableView, animated: Bool) {
        
        let delay = 0.1 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue(), {
            
            let numberOfSections = tableView.numberOfSections
            let numberOfRows = tableView.numberOfRowsInSection(numberOfSections-1)
            
            if numberOfRows > 0 {
                let indexPath = NSIndexPath(forRow: numberOfRows-1, inSection: (numberOfSections-1))
                tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: animated)
            }
            
        })
    }

    
    //---------------------------------------------------------------------------
    // MARK: - Actions

    
    @IBAction func sendMessageAction(sender: UIButton) {
        if self.messageTextField.text!.characters.count > 0 {
            
            let message = self.messageTextField.text!
            let name = self.nameLabel.text!
            let timestamp = Int(NSDate().timeIntervalSince1970 * 1000)
            
            SocketIOManager.sharedInstance.sendMessage(message: message, name: name, timestamp: timestamp)
            
            self.messageTextField.text = ""

        } else {
           let alert = UIAlertController(title: "Empty", message: "Type something to send", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (act) in }))
            presentViewController(alert, animated: true, completion: nil)
        }
        
    }

    
    @IBAction func dismissAction(sender: UIButton) {
//        SocketIOManager.sharedInstance.closeConnection()

        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //---------------------------------------------------------------------------
    // MARK: - End editing

    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
    //---------------------------------------------------------------------------
    // MARK: - Fake Data

    func fakeData() {
        let data1 = ["text": "bla bla", "name": "julia", "timestamp": 1469681882176]
        let mess1 = Message(data: data1)
        
        let data2 = ["text": "How are you?", "name": "eugene", "timestamp": 1469681897263]
        let mess2 = Message(data: data2)
        
        let data3 = ["text": "ochen horosho", "name": "julia", "timestamp": 1469681899487]
        let mess3 = Message(data: data3)
        
        let data4 = ["text": "tra ta ta", "name": "eugene", "timestamp": 1469681903863]
        let mess4 = Message(data: data4)
        
        let data5 = ["text": "Hello", "name": "julia", "timestamp": 1469681906417]
        let mess5 = Message(data: data5)
        
        self.messagesArray.append(mess1)
        self.messagesArray.append(mess2)
        self.messagesArray.append(mess3)
        self.messagesArray.append(mess4)
        self.messagesArray.append(mess5)
        
    }

    
    
    
    //---------------------------------------------------------------------------
    // MARK: - -UITableView Delegate and Datasource Methods-
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    
    
    /**
     When a message is sent from us (our user), the cell contents will be aligned to the right.
     When the sender is another user, the cell contents will be aligned to the left.
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("chatCell", forIndexPath: indexPath) as! ChatCell
        let message = self.messagesArray[indexPath.row]
        
        
        
        if message.name == self.nameLabel.text {
            cell.lblChatMessage.textAlignment = NSTextAlignment.Right
            cell.lblMessageDetails.textAlignment = NSTextAlignment.Right
            
//            cell.lblChatMessage.textColor = lblNewsBanner.backgroundColor
        }
        
        
        cell.lblChatMessage.text = message.text
        cell.lblMessageDetails.text = "by \(message.name.uppercaseString) @ \(message.timeString)"
        
        cell.lblChatMessage.textColor = UIColor.darkGrayColor()
        
        return cell
        
    }

    

    
    
    
}
