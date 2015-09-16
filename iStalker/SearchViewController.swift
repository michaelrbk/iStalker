//
//  ViewController.swift
//  iStalker
//
//  Created by user113282 on 9/14/15.
//  Copyright (c) 2015 Infnet. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    //TODO: Implementar o delegate pro ENTER realizar a mesma acao do clique no botao Stalk.
    //TODO: Implementar o delegate pra esconder o teclado quando tocar na tela.
    //TODO: Se o serviço retornar pra tentar em 2min, posteriormente enviar notificação. Quando clicar na notificação abrir a tela de resultado.
    //TODO: Ver como documentar métodos.
    //TODO: Colocar ícone do app.
    //TODO: Precisa validar formato do e-mail ou o retorno da API é o suficiente.
    //TODO: Copiar retorno do web service e mockar na aplicação para não estourar a cota de chamadas.

    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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


}

