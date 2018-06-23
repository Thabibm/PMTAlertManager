//
//  ViewController.swift
//  AlertDemo
//
//  Created by Peer Mohamed Thabib on 6/23/18.
//  Copyright © 2018 Peer Mohamed Thabib. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    /*
     Usage: Objective - C
     Test Alert sample
     
     [[AlertManager shared] show:true message:@"Message to be displayed" cancelButtonTitle:@"Okay"];
     
     Alert with completion callback
     NSArray *buttonNames = @[@"Save", @"Settings", @"Okay"];
     [[AlertManager shared] show:true message:@"Message To Be Displayed" cancelButtonTitle:@"Okay" buttons:buttonNames completionCallBack:^(NSInteger index) {
     
     if (index == [AlertManager shared].alertCancelButtonIndex) { // Cancel button Index
        NSLog(@"Cancel button pressed");
     }
     
     NSLog(@"%@", buttonNames[index]);
     }];
     
    */

    @IBAction func simpleAlertPresed(_ sender: Any) {
        AlertManager.shared().show(true, message: "Test Alert", cancelButtonTitle: "Ok")
    }
    
    @IBAction func alertWithHandlerPresed(_ sender: Any) {
        
        let buttonsArray = ["Save", "Settings", "Okay"]
        AlertManager.shared().show(true, message: "Test alert with multiple buttons", cancelButtonTitle: "Cancel", buttons: buttonsArray) { (index) in
            if index == AlertManager.shared().alertCancelButtonIndex { // Remove this condition if cancelButtonTitle is sent as empty string ""
                print("Cancel Button pressed")
                return
            }
            
            print(buttonsArray[index])
        }
        
    }
    
    @IBAction func alertTuplePressed(_ sender: Any) {
        
        let tupleList = [("Settings", { print("SettingsPressed") }), ("Save", { print("SavePressed") }), ("Okay", { print("OkayPressed") })]
        AlertManager.shared().show(true, message: "Test alert with multiple button tuples", buttons: tupleList)
        
    }

}

