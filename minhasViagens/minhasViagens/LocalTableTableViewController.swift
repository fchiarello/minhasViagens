//
//  LocalTableTableViewController.swift
//  minhasViagens
//
//  Created by Fellipe Ricciardi Chiarello on 5/3/19.
//  Copyright © 2019 fchiarello. All rights reserved.
//

import UIKit

class LocalTableTableViewController: UITableViewController {

    var localViagem: [Dictionary <String, String>] = []
    var controleNavegacao = "adicionar"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        controleNavegacao = "adicionar"
        atualizarViagem()
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return localViagem.count
    }
    
    

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let viagem = localViagem [indexPath.row]["local"]
        
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaReuso", for: indexPath)
        celula.textLabel?.text = viagem
        
        return celula
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            armazenamentoViagens().removerViagem(indice: indexPath.row)
            atualizarViagem()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        self.controleNavegacao = "listar"
        
        performSegue(withIdentifier: "identificadorMapa", sender: indexPath.row)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "identificadorMapa" {
            let viewControllerDestino = segue.destination as! ViewController
            if self.controleNavegacao == "listar"{
                if let indiceRecuperado = sender {
                    let indice = indiceRecuperado as! Int
                    viewControllerDestino.viagem = localViagem [indice]
                    viewControllerDestino.indiceSelecionado = indice
                }else{
                    viewControllerDestino.viagem = [:]
                    viewControllerDestino.indiceSelecionado = -1
                }
            }
        }
    }
    

    
    func atualizarViagem() {
        localViagem = armazenamentoViagens().listarViagem()
        tableView.reloadData()
    }

}
