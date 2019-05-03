//
//  LocalTableTableViewController.swift
//  minhasViagens
//
//  Created by Fellipe Ricciardi Chiarello on 5/3/19.
//  Copyright © 2019 fchiarello. All rights reserved.
//

import UIKit

class LocalTableTableViewController: UITableViewController {

    var localViagem: [String] = ["Cristo Redentor", "Torre Eifel", "Empire State"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return localViagem.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let viagem = localViagem [indexPath.row]
        
        let celula = tableView.dequeueReusableCell(withIdentifier: "celulaReuso", for: indexPath)
        celula.textLabel?.text = viagem
        
        return celula
    }

}
