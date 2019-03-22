//
//  ContatoDao.swift
//  FormularioContatoViewController
//
//  Created by ios8106 on 3/19/19.
//  Copyright © 2019 caelum. All rights reserved.
//

import UIKit

class ContatoDao: NSObject {
    
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
    
    

}
