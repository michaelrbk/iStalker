//
//  ResultsViewController.swift
//  iStalker
//
//  Created by user113282 on 14/09/15.
//  Copyright (c) 2015 Infnet. All rights reserved.
//

import UIKit
import SwiftyJSON

class ResultsViewController: UIViewController {
    
    var email: UITextField!
    var facade = ContactFacade()
    
    @IBOutlet weak var labelTeste: UILabel!
    
    override func viewDidLoad() {
        facade.rvc = self
        facade.findContact(email.text)
    }
    
    func setContactInView(contact : JSON) {
        self.labelTeste.text = contact["args"]["email"].string
    }

}
