//
//  ChatVC.swift
//  Chatroom
//
//  Created by eugene golovanov on 7/26/16.
//  Copyright © 2016 eugene golovanov. All rights reserved.
//

import UIKit

//class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
class ChatVC: UIViewController {


    //---------------------------------------------------------------------------
    // MARK: - Properties
    
    @IBOutlet weak var tableViewChat: UITableView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    
    @IBOutlet weak var messageTextField: UITextField!
    //---------------------------------------------------------------------------
    // MARK: - View Lifecycle

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChatVC.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
                
        //RECEIVING MESSAGES
        SocketIOManager.sharedInstance.getChatMessage { (messageInfo) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                print("----------------------MESSAGE INFO:-------------------------------")
                let message = Message(data: messageInfo)
                print("Received Message: \(message)")
                print("-----------------------------------------------------")                
            })
        }
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
        SocketIOManager.sharedInstance.closeConnection()
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
    // MARK: - -UITableView Delegate and Datasource Methods-
    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return chatMessages.count
//    }
//    
//    
//    
//    /**
//     When a message is sent from us (our user), the cell contents will be aligned to the right.
//     When the sender is another user, the cell contents will be aligned to the left.
//     */
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCellWithIdentifier("chatCell", forIndexPath: indexPath) as! ChatCell
//        
//        let currentChatMessage = chatMessages[indexPath.row]
//        let senderNickname = currentChatMessage["nickname"] as! String
//        let message = currentChatMessage["message"] as! String
//        let messageDate = currentChatMessage["date"] as! String
//        
//        if senderNickname == nickname {
//            cell.lblChatMessage.textAlignment = NSTextAlignment.Right
//            cell.lblMessageDetails.textAlignment = NSTextAlignment.Right
//            
//            cell.lblChatMessage.textColor = lblNewsBanner.backgroundColor
//        }
//        
//        cell.lblChatMessage.text = message
//        cell.lblMessageDetails.text = "by \(senderNickname.uppercaseString) @ \(messageDate)"
//        
//        cell.lblChatMessage.textColor = UIColor.darkGrayColor()
//        
//        return cell
//        
//    }

    

    
    
    
}
