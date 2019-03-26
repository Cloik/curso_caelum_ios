//
//  ContatosNoMapaViewController.swift
//  ContatosIP67_v03
//
//  Created by ios8106 on 3/25/19.
//  Copyright © 2019 caelum. All rights reserved.
//

import UIKit
import MapKit

class ContatosNoMapaViewController: UIViewController{
    
    @IBOutlet weak var mapa: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        let botaoLocalizacao = MKUserTrackingBarButtonItem(mapView: self.mapa)
        
        self.navigationItem.rightBarButtonItem = botaoLocalizacao
    }

}

