//
//  ContactFacade.swift
//  iStalker
//
//  Created by user113282 on 15/09/15.
//  Copyright (c) 2015 Infnet. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ContactFacade {
    
    var rvc : ResultsViewController?
    
     func findContact(email: String) {
        
        var contact: JSON = nil
//        Alamofire.request(.GET, "https://api.fullcontact.com/v2/person.json", parameters: ["apiKey": "252a1ebb9708464c", "email" : "bart@fullcontact.com"])
//            .responseJSON { _, _, JSON, _ in
//                println(JSON)
//        }
        
        Alamofire.request(.GET, "http://httpbin.org/get", parameters: ["apiKey": "252a1ebb9708464c", "email" : "bart@fullcontact.com"])
            .responseJSON { _, _, json, _ in
            contact = JSON(json!)
            //print(contact["args"]["email"].string)
                self.rvc?.setContactInView(contact)
        }
    }
}