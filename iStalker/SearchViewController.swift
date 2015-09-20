//
//  ViewController.swift
//  iStalker
//
//  Created by user113282 on 9/14/15.
//  Copyright (c) 2015 Infnet. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UITextFieldDelegate {
    //TODO: Se o serviço retornar pra tentar em 2min, posteriormente enviar notificação. Quando clicar na notificação abrir a tela de resultado.
    //TODO: Ver como documentar métodos.
    //TODO: Colocar ícone do app.
    //TODO: Copiar retorno do web service e mockar na aplicação para não estourar a cota de chamadas.

    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.email.delegate = self
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "showResultsSegue")	{
            var rvc = segue.destinationViewController as! ResultsViewController
            rvc.email = email
        }
    }
    
    @IBAction func hideKeyboard(sender: AnyObject) {
        
        self.view.endEditing(true)
    }
    
    //Função utilizada para validar se a próxima interface pode ser chamada
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        
        if identifier == "showResultsSegue" {
        
            if (email.text.isEmpty || !email.text.isEmail() ) {
                Utils.showAlert("Email inválido.")
                return false
            } else {
                return true
            }
        }

        return false
    }
    
    //Função para o enter chamar a próxima tela
    func textFieldShouldReturn(textField: UITextField) -> Bool {
            
        email.resignFirstResponder()
        if (self.shouldPerformSegueWithIdentifier("showResultsSegue", sender: self)) {
            self.performSegueWithIdentifier("showResultsSegue", sender: self)
        }
        
        return true
    }
    
}
