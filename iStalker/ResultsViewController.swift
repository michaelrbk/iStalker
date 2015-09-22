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
    
    var email: UITextField!
    var facade: ContactFacade = ContactFacade()
    var contact: JSON?
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var socialNetworksTable: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        activityIndicator.startAnimating()
        facade.findContact(email.text, callback: handleContactCallback)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: SocialNetworkCell = self.socialNetworksTable.dequeueReusableCellWithIdentifier("Cell") as! SocialNetworkCell
        
        if (contact != nil) {
            
            var socialProfile: JSON = contact!["socialProfiles"][indexPath.row]
            
            cell.name.text = socialProfile["typeName"].string
            
            var typeId: String = socialProfile["typeId"].string!
            var socialNetworkIconURL: String = facade.getSocialNetworkIconURL(typeId)
            Utils.loadImageAsync(cell.icon, url: socialNetworkIconURL)
            
            var username: String? = socialProfile["username"].string
            if (username != nil) {
                    cell.userName.text = "@" + socialProfile["username"].string!
            } else {
                    cell.userName.text = ""
            }
            
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
    
    func handleContactCallback(contact: JSON) {
 
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
        
        var primaryPhotoURL : String? = facade.getPrimaryPhotoURL(c)
        if (primaryPhotoURL != nil) {
            Utils.loadImageAsync(photo, url: primaryPhotoURL!)
        }
        
        self.fullName.text = c["contactInfo"]["fullName"].string
        
        var gender:String? = c["demographics"]["gender"].string
        
        if (gender == nil) {
            self.gender.text = ""
        } else {
            switch (gender!) {
                case "Male":
                    self.gender.text = "Masculino"
                case "Female":
                    self.gender.text = "Feminino"
                default:
                    self.gender.text = ""
            }
        }
        
        contact = c
        self.socialNetworksTable.reloadData()
        activityIndicator.stopAnimating()
        
        //	logContactData(c)
    }
    
    func logContactData(c: JSON) {
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
        returnToLastSceen()
        
        //TODO: Pedir para mostrar notificação após clicar no botão OK do Alert.
        //TODO: Colocar ação pra quando clicar na notificação abrir a tela de resultado. Ver como persistir o e-mail usado.
//        if(UIApplication.instancesRespondToSelector(Selector("registerUserNotificationSettings:"))) {
//            UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: .Alert | .Sound, categories: nil))
//        }
//        
//        var not: UILocalNotification = UILocalNotification()
//        not.alertAction = "view details"
//        not.alertBody = "Tente pesquisar novamente pelo contato."
//        not.fireDate = NSDate(timeIntervalSinceNow: 300)
//        not.soundName = UILocalNotificationDefaultSoundName
//        
//        UIApplication.sharedApplication().scheduleLocalNotification(not)
    }

    func showContactNotFoundAlert() {
        
        Utils.showAlert("Pessoa não encontrada.")
        returnToLastSceen()
    }
    
    func showErrorAlert() {
        
        Utils.showAlert("Ocorreu um erro ao buscar esta pessoa.")
        returnToLastSceen()
    }
    
    func returnToLastSceen() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var socialProfile: JSON = contact!["socialProfiles"][indexPath.row]
        UIApplication.sharedApplication().openURL(NSURL(string: socialProfile["url"].string!)!)
    }

    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}
