//
//  ResultsViewController.swift
//  iStalker
//
//  Created by user113282 on 14/09/15.
//  Copyright (c) 2015 Infnet. All rights reserved.
//

import UIKit
import SwiftyJSON

class ResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //TODO: Colocar spinner de loading enquanto nao terminou de carregar os dados.
    //TODO: Colocar imagem default de placeholder na foto da pessoa.
    //TODO: Tentar passar closure para o facade em vez de referência desta classe.
    
    var email: UITextField!
    var facade: ContactFacade = ContactFacade()
    var contact: JSON?
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var labelTeste: UILabel!
    @IBOutlet weak var socialNetworksTable: UITableView!
    
    override func viewDidLoad() {
        
        facade.rvc = self
        facade.findContact(email.text)
        
        socialNetworksTable.rowHeight = UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: SocialNetworkCell = self.socialNetworksTable.dequeueReusableCellWithIdentifier("Cell") as! SocialNetworkCell
        
        if (contact != nil) {
            
            var socialProfile: JSON = contact!["socialProfiles"][indexPath.row]
            
            cell.socialNetworkName.text = socialProfile["typeName"].string
            
            var typeId: String = socialProfile["typeId"].string!
            var socialNetworkIconURL: String = facade.getSocialNetworkIconURL(typeId)
            Utils.loadImageAsync(cell.socialNetworkIcon, url: socialNetworkIconURL)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 0
        
        if (contact != nil) {
            count = contact!["socialProfiles"].count
        }
        
        return count
    }
    
    func handleContactCallback(contact : JSON) {
 
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
        
        var primaryPhotoURL : String? = facade.getPrimaryPhotoURL(c)
        if (primaryPhotoURL != nil) {
            Utils.loadImageAsync(photo, url: primaryPhotoURL!)
        }
        
        contact = c
        self.socialNetworksTable.reloadData()
        
        //----------- TESTE
        
        print("contactInfo.familyName: ")
        println(c["contactInfo"]["familyName"].string)
        
        print("contactInfo.givenName: ")
        println(c["contactInfo"]["givenName"].string)
        
        print("contactInfo.fullName: ")
        println(c["contactInfo"]["fullName"].string)
        
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
                print("typeId: ")
                println(socialProfile["typeId"].string)
                
                print("typeName: ")
                println(socialProfile["typeName"].string)
                
                print("id: ")
                println(socialProfile["id"].string)
                
                print("username: ")
                println(socialProfile["username"].string)
                
                print("url: ")
                println(socialProfile["url"].string)
                
                print("bio: ")
                println(socialProfile["bio"].string)
                
                print("rss: ")
                println(socialProfile["rss"].string)
                
                print("following: ")
                println(socialProfile["following"].string)
                
                print("followers: ")
                println(socialProfile["followers"].string)
                
                print("photo.url: ")
                if (socialProfile["typeId"].string != nil) {
                    println(facade.getPhotoURL(c, typeId: socialProfile["typeId"].string!))
                }
                
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
