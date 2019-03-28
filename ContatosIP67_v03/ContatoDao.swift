//
//  ContatoDao.swift
//  FormularioContatoViewController
//
//  Created by ios8106 on 3/19/19.
//  Copyright © 2019 caelum. All rights reserved.
//

import UIKit

class ContatoDao: CoreDataUtil {
    
    static private var defaultDAO:ContatoDao!
    var contatos: Array<Contato>
    
    func adiciona(_ contato:Contato){
        contatos.append(contato)
        
        for cont in contatos{
            print(cont)
            print("Imprime contato")
        }
    }
    
    static func sharedInstance()->ContatoDao{
        if defaultDAO == nil{
            defaultDAO = ContatoDao()
        }
        return defaultDAO
    }
    
    override private init(){
        self.contatos = Array()
        super.init()
        
        self.inserirDadosIniciais()
        
        print("Caminho do BD: \(NSHomeDirectory())")
    }
    
    func listaTodos() -> [Contato]{
        return contatos
    }
    
    func buscaContatoNaPosicao(_ posicao:Int)->Contato{
        return contatos[posicao]
        
    }
    
    func remove(_ posicao:Int){
        contatos.remove(at: posicao)
    }
    
    func buscaPosicaoDoContato(_ contato:Contato) -> Int{
       return contatos.index(of: contato)!
    }
    
    func inserirDadosIniciais(){
        let configuracoes = UserDefaults.standard
        let dadosInseridos = configuracoes.bool(forKey: "dados_inseridos")
        
        if !dadosInseridos {
            let caelumSP = NSEntityDescription.insertNewObject(forEntityName: "Contato", into: self.persistentContainer.viewContext) as! Contato
            
            caelumSP.nome = "Caelum SP"
            caelumSP.endereco = "São Paulo, SP, Rua Vergueiro, 3185"
            caelumSP.telefone = "01155712751"
            caelumSP.siteText = "http://www.caelum.com.br"
            caelumSP.latitude = -23.5883034
            caelumSP.longitude = -46.632369
            
            self.saveContext()
            
            configuracoes.set(true, forKey: "dados_inseridos")
            
            configuracoes.synchronize()
            
        }
    }
    
    

}

