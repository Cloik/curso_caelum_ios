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
    var contato: Contato!
    var delegate:FormularioContatoViewControllerDelegate?
    
    required init?(coder aDecoder: NSCoder){
        self.dao = ContatoDao.sharedInstance()
        super.init(coder:aDecoder )
    }
    
    @IBAction func criaContato(){
        self.pegaDadosDoFormulario()
        dao.adiciona(contato)
        
        self.delegate?.contatoAdicionado(contato)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func pegaDadosDoFormulario(){
        
        if (contato == nil){
            
            self.contato = Contato()
        }
       
        self.contato.nome       = self.nome.text!
        self.contato.telefone   = self.telefone.text!
        self.contato.endereco   = self.endereco.text!
        self.contato.siteText   = self.siteText.text!

    }
    
    func atualizaContato(){
        pegaDadosDoFormulario()
        
        self.delegate?.contatoAdicionado(contato)
        _ = self.navigationController?.popViewController(animated: true)
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if contato != nil {
            self.nome.text = contato.nome
            self.telefone.text = contato.telefone
            self.endereco.text = contato.endereco
            self.siteText.text = contato.siteText
            
            let botaoAlterar = UIBarButtonItem(title: "Confirmar", style: .plain, target: self, action: #selector(atualizaContato))
            
            self.navigationItem.rightBarButtonItem = botaoAlterar
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

