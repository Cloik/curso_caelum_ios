//
//  ViewController.swift
//  ContatosIP67_v03
//
//  Created by ios8106 on 3/19/19.
//  Copyright © 2019 caelum. All rights reserved.
//

import UIKit

class FormularioContatoViewController: UIViewController {

    @IBOutlet var nome:     UITextField!
    @IBOutlet var telefone: UITextField!
    @IBOutlet var endereco: UITextField!
    @IBOutlet var siteText: UITextField!
    var dao:ContatoDao
    
    required init?(coder aDecoder: NSCoder){
        self.dao = ContatoDao.sharedInstance()
        super.init(coder:aDecoder )
    }
    
    @IBAction func pegaDadosDoFormulario(){
        
        let contato: Contato = Contato()
        
//        let nome       = self.nome.text!
//        let telefone   = self.telefone.text!
//        let endereco   = self.endereco.text!
//        let siteText   = self.siteText.text!
//        print("Nome: \(nome), Telefone: \(telefone), Endereço: \(endereco), Site: \(siteText)")
        
        contato.nome       = self.nome.text!
        contato.telefone   = self.telefone.text!
        contato.endereco   = self.endereco.text!
        contato.siteText   = self.siteText.text!
//        print(contato)
        dao.adiciona(contato)
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

