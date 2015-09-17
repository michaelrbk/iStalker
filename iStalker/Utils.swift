//
//  ContactDTO.swift
//  iStalker
//
//  Created by user113282 on 15/09/15.
//  Copyright (c) 2015 Infnet. All rights reserved.
//

import Foundation
import UIKit

class Utils : NSObject {
    
    class func showAlert(message : String) {
        let alert = UIAlertView()
        alert.title = "Alerta"
        alert.message = message
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
}
