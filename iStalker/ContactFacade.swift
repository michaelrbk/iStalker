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
        //email teste: "bart@fullcontact.com"
        Alamofire.request(.GET, "https://api.fullcontact.com/v2/person.json", parameters: ["apiKey": "252a1ebb9708464c", "email" : email])
            .responseJSON { _, _, json, _ in
            self.rvc?.setContactInView(JSON(json!))
        }
        
    }
    
    func getPhotoURL(contact : JSON, typeId : String) -> String? {
        var url : String?
        
        if let photos = contact["photos"].array {
            for photo in photos {
                if (photo["typeId"].string == typeId) {
                    url = photo["url"].string!
                    break
                }
            }
        }
        
        return url
    }
}