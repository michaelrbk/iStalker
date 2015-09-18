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
    
    class func loadImageSync(view: UIImageView, url: String) {
        
        if let url = NSURL(string: url) {
            if let data = NSData(contentsOfURL: url){
            view.contentMode = UIViewContentMode.ScaleAspectFit
            view.image = UIImage(data: data)
            }
        }
    }
    
    class func loadImageAsync(view: UIImageView, url: String) {
                
        view.contentMode = UIViewContentMode.ScaleAspectFit
        if let checkedUrl = NSURL(string: url) {
            getDataFromUrl(checkedUrl) { data in
                dispatch_async(dispatch_get_main_queue()) {
                    view.image = UIImage(data: data!)
                }
            }
        }
    }
    
    class func getDataFromUrl(url: NSURL, completion: ((data: NSData?) -> Void)) {
        
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
        completion(data: data)
        }.resume()
    }
    
}
