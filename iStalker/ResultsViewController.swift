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
    
    //TODO: Colocar spinner de loading enquanto nao terminou de carregar os dados.
    
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
        
        println("contactInfo.familyName: " + c["contactInfo"]["familyName"].string!)
        println("contactInfo.givenName: " + c["contactInfo"]["givenName"].string!)
        println("contactInfo.contactInfo: " +  c["contactInfo"]["fullName"].string!)
        
        println("contactInfo.middleNames: ")
        if let middleNames = c["contactInfo"]["middleNames"].array {
            for middleName in middleNames {
                println(middleName.string)
            }
        } else {
            println("Sem middleNames: ")
        }
        
        println("contactInfo.websites: ")
        if let websites = c["contactInfo"]["websites"].array {
            for website in websites {
                println(website["url"].string)
            }
        } else {
            println("Sem websites")
        }
        
        println("socialProfiles: ")
        if let socialProfiles = c["socialProfiles"].array {
            for socialProfile in socialProfiles {
                println("typeId: " + socialProfile["typeId"].string!)
                println("typeName: " + socialProfile["typeName"].string!)
                println("id: " + socialProfile["id"].string!)
                println("username: " + socialProfile["username"].string!)
                println("url: " + socialProfile["url"].string!)
                println("bio: " + socialProfile["bio"].string!)
                println("rss: " + socialProfile["rss"].string!)
                println("following: " + socialProfile["following"].string!)
                println("followers: " + socialProfile["followers"].string!)
                
                println("photo.url: " + facade.getPhotoURL(c, typeId: socialProfile["typeId"].string!)!)
            }
        } else {
            println("Sem socialProfiles")
        }
        
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
