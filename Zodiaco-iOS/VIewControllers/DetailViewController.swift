//
//  DescriptionViewController.swift
//  Zodiaco-iOS
//
//  Created by Tardes on 15/1/26.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: Outles
    
    @IBOutlet weak var iconImagenView: UIImageView!
    //imagen
    
    // MARK: propiedades
    var horoscope:Horoscope!
    
    // MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = horoscope.name//esto es para mostrar el nombre que contiene el struct
        if #available(iOS 26.0, *) {
            navigationItem.subtitle = horoscope.dates
        } else {
            //version
        }
        iconImagenView.image = horoscope.getsecondaryIcon()

    }
   

}
