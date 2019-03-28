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
        ContatoDao.sharedInstance().saveContext()
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
        
        self.carregaContatos()
        
        print("Metodo Init")
    }
    
    func listaTodos() -> [Contato]{
        return contatos
    }
    
    func buscaContatoNaPosicao(_ posicao:Int)->Contato{
        return contatos[posicao]
        
    }
    
    func remove(_ posicao:Int){
        
        persistentContainer.viewContext.delete(contatos[posicao])
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
    
    func novoContato() -> Contato{
        
        return NSEntityDescription.insertNewObject(forEntityName: "Contato", into: self.persistentContainer.viewContext) as! Contato
        
        self.saveContext()
        
    }
    
    func carregaContatos(){
        let busca = NSFetchRequest<Contato>(entityName: "Contato")
        
        let orderPorNome = NSSortDescriptor(key: "nome", ascending: true)
        
        busca.sortDescriptors = [orderPorNome]
        
        do{
            self.contatos = try self.persistentContainer.viewContext.fetch(busca)
            print("Carrega contatos")
        }catch let error as NSError{
            print("Fetch Falhou: \(error.localizedDescription)")
            print("Nao carregou contatos")
        }
    }
    
    
    

}

