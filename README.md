# PMTAlertManager
Alert manager to display alerts using UIAlertController

Do you want to dispaly alerts in your project with out writing much code? Alert Manager is there to help you

# Usage Description

This app need i0S 8 or greater
Supports Swift 4.x


# Features

Supports Localization
has Objective - C compatablity 

# Installation

1. Clone the repository and copy AlertManager.swift file in to your xcode project.
2. To show the Warning with out a need to track user action 

# Swift
AlertManager.shared().show(true, message: "Test Alert", cancelButtonTitle: "Ok") 

# Objective - C
```
[[AlertManager shared] show:true message:@"Message to be displayed" cancelButtonTitle:@"Okay"];
```

a) If you are passing localised string keys you should give false as the bool value
b) If you are passing strings directly you should give true as the bool value

3. To shouw the Alert and need to track user selection 

# Swift
```
let buttonsArray = ["Save", "Settings", "Okay"]
        AlertManager.shared().show(true, message: "Test alert with multiple buttons", cancelButtonTitle: "Cancel", buttons: buttonsArray) { (index) in
            if index == AlertManager.shared().alertCancelButtonIndex { 
                print("Cancel Button pressed")
                return
            }
            
            print(buttonsArray[index])
        }
 ```
        
 # Objective - C
 Alert with completion callback
 ```
     NSArray *buttonNames = @[@"Save", @"Settings", @"Okay"];
     [[AlertManager shared] show:true message:@"Message To Be Displayed" cancelButtonTitle:@"Okay" buttons:buttonNames completionCallBack:^(NSInteger index) {
     
     if (index == [AlertManager shared].alertCancelButtonIndex) { // Cancel button Index
        NSLog(@"Cancel button pressed");
     }
     
     NSLog(@"%@", buttonNames[index]);
     }];
     ```
        
 a) Remove the if condition if cancelButtonTitle is sent as empty string ""
        
4. To shouw the Alert and need to track user selection with tuples

# Swift
```
let tupleList = [("Settings", { print("SettingsPressed") }), ("Save", { print("SavePressed") }), ("Okay", { print("OkayPressed") })]
        AlertManager.shared().show(true, message: "Test alert with multiple button tuples", buttons: tupleList)
        ```
        
        
