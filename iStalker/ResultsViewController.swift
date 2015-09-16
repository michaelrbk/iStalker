//
//  ResultsViewController.swift
//  iStalker
//
//  Created by user113282 on 14/09/15.
//  Copyright (c) 2015 Infnet. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var email: UITextField!
    var facade = ContactFacade()
    
    @IBOutlet weak var labelTeste: UILabel!
    
    override func viewDidLoad() {
        labelTeste.text = facade.buscarContato(email.text)
    }

}
