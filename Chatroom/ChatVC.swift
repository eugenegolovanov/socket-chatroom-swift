//
//  ChatVC.swift
//  Chatroom
//
//  Created by eugene golovanov on 7/26/16.
//  Copyright © 2016 eugene golovanov. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    //---------------------------------------------------------------------------
    // MARK: - Properties
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    
    @IBOutlet weak var messageTextField: UITextField!
    //---------------------------------------------------------------------------
    // MARK: - View Lifecycle

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
                
        //RECEIVING MESSAGES
        SocketIOManager.sharedInstance.getChatMessage { (messageInfo) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                print("----------------------MESSAGE INFO:-------------------------------")
                print("Received Message: \(messageInfo)")
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
    
    
    
}
