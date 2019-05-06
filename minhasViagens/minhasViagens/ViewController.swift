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
        
        let reconhecedorGesto = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.marcar( gesture:) ))
        reconhecedorGesto.minimumPressDuration = 2
        
        mapa.addGestureRecognizer(reconhecedorGesto)
    }
    
    @objc func marcar (gesture: UIGestureRecognizer) {
        
        if gesture.state == UIGestureRecognizer.State.began {
            
//            Recupera coordenadas dos pontos
            let pontoSelecionado = gesture.location(in: self.mapa)
            let coordenadas = mapa.convert(pontoSelecionado, toCoordinateFrom: self.mapa)
            let localizacao = CLLocation(latitude: coordenadas.latitude, longitude: coordenadas.longitude)
            
//            recupera endereco do ponto selecionado
            
            var localcompleto = "Endereço não encontrado!"
            
            
            CLGeocoder().reverseGeocodeLocation(localizacao) { (local, erro) in
                if erro == nil {
                    if let dadosLocal = local?.first{
                        if let nome = dadosLocal.name{
                            localcompleto = nome
                        }else{
                            if let endereco = dadosLocal.thoroughfare{
                                localcompleto = endereco
                            }
                        }
                    }
             
                    //            Exibe anotacao com dados de endereco
                    
                    let anotacao = MKPointAnnotation()
                    anotacao.coordinate.latitude = coordenadas.latitude
                    anotacao.coordinate.longitude = coordenadas.longitude
                    anotacao.title = localcompleto
                    
                    self.mapa.addAnnotation(anotacao)
                    
                }else{
                    print("Erro")
                }
            }
        }
        
        
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

