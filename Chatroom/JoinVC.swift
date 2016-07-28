//
//  JoinVC.swift
//  Chatroom
//
//  Created by eugene golovanov on 7/25/16.
//  Copyright © 2016 eugene golovanov. All rights reserved.
//

import UIKit

class JoinVC: UIViewController {

    
    //---------------------------------------------------------------------------
    // MARK: - Properties
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var chatroomField: UITextField!
    
    
    
    //---------------------------------------------------------------------------
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
    
    
    //---------------------------------------------------------------------------
    // MARK: - Actions

    
    @IBAction func joinChatAction(sender: UIButton) {
        SocketIOManager.sharedInstance.establishConnection()

        performSegueWithIdentifier("chatSegue", sender: self)
    }
    
    
    
    
    //---------------------------------------------------------------------------
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "chatSegue" {
            let navVC = segue.destinationViewController as! UINavigationController
            let vc = navVC.viewControllers.first as! ChatVC
            vc.nameLabel.text = self.usernameField.text!
            vc.roomLabel.text = self.chatroomField.text!
        }
    }


}
