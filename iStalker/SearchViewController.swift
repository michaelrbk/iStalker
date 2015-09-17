//
//  ViewController.swift
//  iStalker
//
//  Created by user113282 on 9/14/15.
//  Copyright (c) 2015 Infnet. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UITextFieldDelegate {
    //TODO: Implementar o delegate pra esconder o teclado quando tocar na tela.
    //TODO: Se o serviço retornar pra tentar em 2min, posteriormente enviar notificação. Quando clicar na notificação abrir a tela de resultado.
    //TODO: Ver como documentar métodos.
    //TODO: Colocar ícone do app.
    //TODO: Copiar retorno do web service e mockar na aplicação para não estourar a cota de chamadas.
    //TODO: Colocar spinner de loading enquanto nao terminou de carregar os dados.

    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.email.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showResultsSegue")	{
            var rvc = segue.destinationViewController as! ResultsViewController
            rvc.email = email
        }
    }
    
    //Função utilizada para validar se a próxima interface pode ser chamada
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        if identifier == "showResultsSegue" {
        
            if (email.text.isEmpty || !email.text.isEmail() ) {
                Utils.showAlert("Email inválido")
                return false
            }
            else
            {
                return true
            }
        }
    

        return true
    }
    
    //Função para o enter chamar a próxima tela
    func textFieldShouldReturn(textField: UITextField) -> Bool {
            
            email.resignFirstResponder()
            if(self.shouldPerformSegueWithIdentifier("showResultsSegue", sender: self)){
                    self.performSegueWithIdentifier("showResultsSegue", sender: self)
            }
            return true
    }
    
    
}

// Extensão da String para validar se a string é um email
extension String {
    func isEmail() -> Bool {
    let regex = NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .CaseInsensitive, error: nil)
    return regex?.firstMatchInString(self, options: nil, range: NSMakeRange(0, count(self))) != nil
    }
}

