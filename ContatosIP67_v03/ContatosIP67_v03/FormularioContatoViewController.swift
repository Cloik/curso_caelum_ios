//
//  ViewController.swift
//  ContatosIP67_v03
//
//  Created by ios8106 on 3/19/19.
//  Copyright © 2019 caelum. All rights reserved.
//

import UIKit
import CoreLocation

class FormularioContatoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UI {

    @IBOutlet var nome:     UITextField!
    @IBOutlet var telefone: UITextField!
    @IBOutlet var endereco: UITextField!
    @IBOutlet var siteText: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var latitude: UITextField!
    @IBOutlet var longitude: UITextField!
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
    
    @IBAction func buscarCoordenadas(sender: UIButton){
        
        //self.loading.startAnimating()
    
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(self.endereco.text!){ (resultado, error) in
            
            if error == nil && (resultado?.count)! > 0 {
                
                let placemark = resultado![0]
                let coordenada = placemark.location!.coordinate
                
                self.latitude.text = coordenada.latitude.description
                self.longitude.text = coordenada.longitude.description
            }
        }
    }
    
    func pegaDadosDoFormulario(){
        
        if (contato == nil){
            
            self.contato = dao.novoContato()
        }
        
        //self.contato.foto = self.imageView.image
        
        //Para evitar a quebra do app se a imagem estiver vazia
        if let imagem = imageView.image{
            contato.foto = imagem
        }
        
        self.contato.nome       = self.nome.text!
        self.contato.telefone   = self.telefone.text!
        self.contato.endereco   = self.endereco.text!
        self.contato.siteText   = self.siteText.text!
        
//        if contato.endereco.isEmpty{
//            
//            let alert = UIAlertController(title: self.contato.endereco, message:"Campo de preenchimento Obrigatório", preferredStyle: .alert)
//            let acao = UIAlertAction(title: "Action", style: .cancel, handler: nil)
//            
//            
//            alert.addAction(acao)
//            self.present(alert, animated: true, completion: nil)
//            
//            
//        }
        
        if let latitude = Double(self.latitude.text!){
            self.contato.latitude = latitude as NSNumber
        }
        
        if let longitude = Double(self.longitude.text!){
            self.contato.longitude = longitude as NSNumber
        }

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
            self.latitude.text = contato.latitude?.description
            self.longitude.text = contato.longitude?.description
            
            if let foto = contato.foto{
                self.imageView.image = foto
            }
            
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
    
    override func viewDidLayoutSubviews() {
        
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds = true
    }
    
    

}

