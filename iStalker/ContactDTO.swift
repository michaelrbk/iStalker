//
//  ContactDTO.swift
//  iStalker
//
//  Created by user113282 on 15/09/15.
//  Copyright (c) 2015 Infnet. All rights reserved.
//

import Foundation

class ContactDTO : NSObject {
    
    var familyName : String?
    var givenName : String?
    var fullName : String?
    var middleNames : String?
    var websites : String?
    
    init(json: NSDictionary) {
        super.init()
        self.setValuesForKeysWithDictionary(json as [NSObject : AnyObject])
    }
    
}
