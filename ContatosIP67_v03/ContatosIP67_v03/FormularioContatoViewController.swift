//
//  ViewController.swift
//  ContatosIP67_v03
//
//  Created by ios8106 on 3/19/19.
//  Copyright © 2019 caelum. All rights reserved.
//

import UIKit

class FormularioContatoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var nome:     UITextField!
    @IBOutlet var telefone: UITextField!
    @IBOutlet var endereco: UITextField!
    @IBOutlet var siteText: UITextField!
    @IBOutlet var imageView: UIImageView!
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(selecionarFoto(sender:)))
        self.imageView.addGestureRecognizer(tap)
    }
    
    func selecionarFoto(sender: AnyObject){
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            //Camera disponível
            
        }else{
            
            //Usar biblioteca
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            
            self.present(imagePicker, animated: true, completion: nil)
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let imageSelecionada = info[UIImagePickerControllerEditedImage] as? UIImage{
        
        self.imageView.image = imageSelecionada
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

