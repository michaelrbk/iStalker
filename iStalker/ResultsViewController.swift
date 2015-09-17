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
 
        switch (contact["status"].intValue) {
            case 200:
                showContact(contact)
            case 202:
                showSearchContactLaterAlert()
            case 404:
                showContactNotFoundAlert()
            default:
                showErrorAlert()
        }
    }
    
    func showContact(c : JSON) {
        
        self.labelTeste.text = c["contactInfo"]["fullName"].string
        print(c["contactInfo"]["fullName"])
    }
    
    func showSearchContactLaterAlert() {
        Utils.showAlert("Estamos preparando os dados desta pessoa. Procure novamente em 5 minutos.")
        //TODO: Voltar para tela de busca.
    }

    func showContactNotFoundAlert() {
        Utils.showAlert("Pessoa não encontrada.")
        //TODO: Voltar para tela de busca.
    }
    
    func showErrorAlert() {
        Utils.showAlert("Ocorreu um erro ao buscar esta pessoa.")
        //TODO: Voltar para tela de busca.
    }
}
