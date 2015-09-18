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
    
    class func loadImage(view: UIImageView, url: String) {
        if let url = NSURL(string: url) {
            if let data = NSData(contentsOfURL: url){
            view.contentMode = UIViewContentMode.ScaleAspectFit
            view.image = UIImage(data: data)
            }
        }
    }
}
