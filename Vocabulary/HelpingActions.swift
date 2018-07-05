//
//  HelpingActions.swift
//  Vocabulary
//
//  Created by Alexandr Kurdyukov on 05.07.2018.
//  Copyright © 2018 Alexandr Kurdyukov. All rights reserved.
//

import UIKit

class HelpingActions: NSObject {
    
    public static func okAlert(title:String, message: String, view: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        view.present(alert, animated: true, completion: nil)
    }
    
    
}
