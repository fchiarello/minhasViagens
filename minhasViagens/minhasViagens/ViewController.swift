//
//  ViewController.swift
//  minhasViagens
//
//  Created by Fellipe Ricciardi Chiarello on 5/2/19.
//  Copyright © 2019 fchiarello. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorLocalizacao = CLLocationManager ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configuraGerenciadorLocalizacao()
    }
    
    func configuraGerenciadorLocalizacao() {
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.desiredAccuracy = kCLLocationAccuracyBest
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse {
            let alertaController = UIAlertController(title: "Permissão de acesso. Local!", message: "Precisamos de permissão para o funcionamento do app.", preferredStyle: .alert)
            let acaoConfiguracoes = UIAlertAction(title: "AbrirConfigurações", style: .default, handler: {
                (alertaConfiguracoes) in
                if let configuracoes = NSURL (string: UIApplication.openSettingsURLString){
                 
                    UIApplication.shared.open(configuracoes as URL)
                }
            })
            
            let acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            
            alertaController.addAction(acaoConfiguracoes)
            alertaController.addAction(acaoCancelar)
            present(alertaController, animated: true, completion: nil)
        }
    }


}

