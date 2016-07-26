//
//  ChatVC.swift
//  Chatroom
//
//  Created by eugene golovanov on 7/26/16.
//  Copyright © 2016 eugene golovanov. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //RECEIVING MESSAGES
        SocketIOManager.sharedInstance.getChatMessage { (messageInfo) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                print("----------------------MESSAGE INFO:-------------------------------")
                print("messageInfo: \(messageInfo)")
                print("-----------------------------------------------------")
            })
        }
        
        
    }

    
    
    
    @IBAction func dismissAction(sender: UIButton) {
        SocketIOManager.sharedInstance.closeConnection()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}
