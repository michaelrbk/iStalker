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
    
    func findContact(email: String) -> JSON {
        var contact: JSON = nil
//        Alamofire.request(.GET, "https://api.fullcontact.com/v2/person.json", parameters: ["apiKey": "252a1ebb9708464c", "email" : "bart@fullcontact.com"])
//            .responseJSON { _, _, JSON, _ in
//                println(JSON)
//        }
        
        //TODO Ver como transformar a chamada em síncrona, pois o print 2 sai antes do 1
        Alamofire.request(.GET, "http://httpbin.org/get", parameters: ["apiKey": "252a1ebb9708464c", "email" : "bart@fullcontact.com"])
            .responseJSON { _, _, json, _ in
            contact = JSON(json!)
            print(contact["args"]["email"].string)
        }
        return contact
    }
}