//
//  ViewController.swift
//  ContatosIP67_v03
//
//  Created by ios8106 on 3/19/19.
//  Copyright © 2019 caelum. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var nome:     UITextField!
    @IBOutlet var telefone: UITextField!
    @IBOutlet var endereco: UITextField!
    @IBOutlet var siteText: UITextField!
    
    @IBAction func pegaDadosDoFormulario(){
        let nome       = self.nome.text!
        let telefone   = self.telefone.text!
        let endereco   = self.endereco.text!
        let siteText   = self.siteText.text!
        print("Nome: \(nome), Telefone: \(telefone), Endereço: \(endereco), Site: \(siteText)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

