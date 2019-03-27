//
//  ContatosNoMapaViewController.swift
//  ContatosIP67_v03
//
//  Created by ios8106 on 3/25/19.
//  Copyright © 2019 caelum. All rights reserved.
//

import UIKit
import MapKit

class ContatosNoMapaViewController: UIViewController, MKMapViewDelegate{
    
    @IBOutlet weak var mapa: MKMapView!
    var contatos: [Contato] = Array()
    
    let locationManager = CLLocationManager()
    let dao:ContatoDao = ContatoDao.sharedInstance()
    
   
    override func viewWillAppear(_ animated: Bool) {
        self.contatos = dao.listaTodos()
        self.mapa.addAnnotations(self.contatos)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.mapa.removeAnnotations(self.contatos)
    }
    
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        
        self.mapa.delegate = self
        
        self.locationManager.requestWhenInUseAuthorization()
        
        let botaoLocalizacao = MKUserTrackingBarButtonItem(mapView: self.mapa)
        
        self.navigationItem.rightBarButtonItem = botaoLocalizacao
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        
        if annotation is MKUserLocation{
            return nil
        }
        
        let identifier: String = "pino"
        var pino: MKPinAnnotationView
        
        if let reusablePin = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView{
            
            pino = reusablePin

        }else{
            pino = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        if let contato = annotation as? Contato{
            pino.pinTintColor = UIColor.red
            pino.canShowCallout = true
            
            let frame = CGRect(x: 0.0, y: 0.0, width: 32.0, height: 32.0)
            let imageContato = UIImageView(frame: frame)
            
            imageContato.image = contato.foto
            pino.leftCalloutAccessoryView = imageContato
        }
        return pino
        
    }
    
    //Desafio    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        
        let pinToZoomOn = view.annotation
        
        mapView.showAnnotations([pinToZoomOn!], animated: true)
        mapView.selectAnnotation(pinToZoomOn!, animated: true)
        
    }
    

}

