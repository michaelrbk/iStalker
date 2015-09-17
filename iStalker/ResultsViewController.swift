//
//  ResultsViewController.swift
//  iStalker
//
//  Created by user113282 on 14/09/15.
//  Copyright (c) 2015 Infnet. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ResultsViewController: UIViewController {
    
    var email: UITextField!
    var facade = ContactFacade()
    
    @IBOutlet weak var labelTeste: UILabel!
    
    override func viewDidLoad() {
        //var contact : JSON = facade.findContact(email.text)
        
        //TODO a chamada é assincrona. Ver se é possível manter no facade
        Alamofire.request(.GET, "http://httpbin.org/get", parameters: ["apiKey": "252a1ebb9708464c", "email" : "bart@fullcontact.com"])
            .responseJSON { _, _, json, _ in
                var contact = JSON(json!)
                self.labelTeste.text = contact["args"]["email"].string
        }
        
    }

}
