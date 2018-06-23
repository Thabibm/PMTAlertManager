//
//  AlertManager.swift
//  AlertDemo
//
//  Created by Peer Mohamed Thabib on 6/23/18.
//  Copyright © 2018 Peer Mohamed Thabib. All rights reserved.
//

import UIKit


class AlertManager: NSObject {
    
    //MARK: Variables
    static private var instance : AlertManager?
    
    let alertCancelButtonIndex = -1
    
    
    //MARK: Init Method
    
    private override init() {
        super.init()
    }
    
    
    //MARK: Singleton method
    
    @objc class func shared() -> AlertManager {
        if (instance == nil) {
            instance = AlertManager()
        }
        
        return instance!
    }
    
    
    //MARK: Public Methods
    
    /*
     Description:   This methods used to show general warnings without any handlers
     Availiblity:   Supported in Both Swift and Objective - C classes
     Message:       Actual Message needs to be displayed in Alert
     Usage:         isLocalized boolean value is to process the localized strings, if it is false then message and cancelButtonTitle has to be
                    sent as actual strings
    */
    
    @objc func show(_ isLocalized: Bool, message: String, cancelButtonTitle: String) {
        let alertControl = self.createAlertControl(isLocalized: isLocalized, message: message)
        
        var cancel = cancelButtonTitle
        if (!isLocalized) {
            cancel = NSLocalizedString(cancel, comment: "")
        }
        
        alertControl.addAction(UIAlertAction(title: cancel, style: .default, handler: nil))
        self.displayAlertControl(alert: alertControl)
    }
    
    
    /*
     Description:   This methods used to show warning with handlers
     Availiblity:   Supported in Both Swift and Objective - C classes
     Message:       Actual Message needs to be displayed in Alert
     Usage:         isLocalized boolean value is to process the localized strings, if it is false then message and cancelButtonTitle has to be
                    sent as actual strings. Returns pressed button Index in completion handler.
    */
    
    @objc func show(_ isLocalized: Bool, message: String, cancelButtonTitle: String, buttons:[String]?, completionCallBack: @escaping ((_ index: Int) -> Void)) {
        
        let alertControl = self.createAlertControl(isLocalized: isLocalized, message: message)
        if (buttons != nil) {
            
            var buttonsListCopy = buttons
            if (cancelButtonTitle.count != 0) {
                buttonsListCopy!.append(cancelButtonTitle)
            }
            
            var localizeButtonNames = [String]()
            for var item in buttonsListCopy! {
                if (!isLocalized) {
                    item = NSLocalizedString(item, comment: "")
                    localizeButtonNames.append(item)
                }
                
                alertControl.addAction(UIAlertAction(title: item, style: .default, handler: { (action) in
                    let buttonList = isLocalized ? buttonsListCopy : localizeButtonNames
                    
                    let cancelButton = (isLocalized) ? cancelButtonTitle : NSLocalizedString(cancelButtonTitle, comment: "")
                    if (action.title == cancelButton) {
                        completionCallBack(self.alertCancelButtonIndex)
                        return
                    }
                    
                    completionCallBack(buttonList!.index(of: action.title!)!)
                }))
            }
        }
        
        self.displayAlertControl(alert: alertControl)
    }
    
    
    /*
     Description:   This methods used to show warning with handlers
     Availiblity:   Supported in Swift only
     Message:       Actual Message needs to be displayed in Alert
     Usage:         isLocalized boolean value is to process the localized strings, if it is false then message and cancelButtonTitle has to be
                    sent as actual strings. Returns pressed tupel object in completion handler.
    */
    
    func show(_ isLocalized: Bool, message: String, buttons : [(title: String, callBack:(() -> Void))]?) {  // cancel button has to be sent in tuple
        
        let alertControl = self.createAlertControl(isLocalized: isLocalized, message: message)
        
        if (buttons != nil) {
            for item in buttons! {
                var titleValue = item.title
                if isLocalized == false {
                    titleValue = NSLocalizedString(titleValue, comment: "")
                }
                
                alertControl.addAction(UIAlertAction(title: titleValue, style: .default, handler: { (action) in
                    item.callBack()
                }))
            }
        }
        
        self.displayAlertControl(alert: alertControl)
    }
    
    
    //MARK: Private Methods
    
    private func createAlertControl(isLocalized: Bool, message: String) -> UIAlertController {
        var message = message
        if (!isLocalized) {
            message = NSLocalizedString(message, comment: "")
        }
        
        // Can replace your project name for common usage
        return UIAlertController.init(title: NSLocalizedString("Alert Demo", comment: ""), message: message, preferredStyle: .alert)
    }
    
    
    private func displayAlertControl(alert: UIAlertController) {
        // Used to display multiple alerts at the same time
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindowLevelAlert + 1
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
    }

}
