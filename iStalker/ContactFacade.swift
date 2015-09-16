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
    
    func buscarContato(email: String) -> String {
        
//        Alamofire.request(.GET, "https://api.fullcontact.com/v2/person.json", parameters: ["apiKey": "252a1ebb9708464c", "email" : "bart@fullcontact.com"])
//            .responseJSON { _, _, JSON, _ in
//                println(JSON)
//        }
        
        Alamofire.request(.GET, "http://httpbin.org/get", parameters: ["apiKey": "252a1ebb9708464c", "email" : "bart@fullcontact.com"])
            .responseJSON { _, _, json, _ in
            var json = JSON(json!)
            print(json["args"]["email"])
        }
        
        //TODO: Ver se é melhor trabalhar com DTO ou com dictionary retornado pelo Alamofire.
        return "Ola, " + email
    }
}