//
//  armazenandoViagens.swift
//  minhasViagens
//
//  Created by Fellipe Ricciardi Chiarello on 5/6/19.
//  Copyright © 2019 fchiarello. All rights reserved.
//

import UIKit

class armazenamentoViagens {
    
    let chaveArmazenamento = "locaisViagens"
    var viagens : [ Dictionary <String, String> ] = []
    
    
    func getDefaults() -> UserDefaults {
        return UserDefaults.standard
    }
    
    func salvarViagem( viagem: Dictionary <String, String> ) {
        
        viagens = listarViagem()
        
        viagens.append(viagem)
        getDefaults().set(viagens, forKey: chaveArmazenamento)
        getDefaults().synchronize()
        
        
    }
    
    func listarViagem() -> [Dictionary <String, String>] {
        
       let dados =  getDefaults().object(forKey: chaveArmazenamento)
    
    if dados != nil {
            return dados as! Array
    
        }else{
            return []
        }
    }
    
    func removerViagem(indice: Int) {
        viagens = listarViagem()
        viagens.remove(at: indice)
        getDefaults().set(viagens, forKey: chaveArmazenamento)
        getDefaults().synchronize()
        
    }
    
    
}
