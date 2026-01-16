//
//  DescriptionViewController.swift
//  Zodiaco-iOS
//
//  Created by Tardes on 15/1/26.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: Outles
    // lo conectamos para qhacer con el favotiro slo que yo quiera
    @IBOutlet weak var favoriteButtonItem: UIBarButtonItem!
    @IBOutlet weak var iconImagenView: UIImageView!
    
    //imagen
    
    // MARK: propiedades
    var horoscope:Horoscope!
    var sesion : SessionManager = SessionManager()//y llamamos al constructor
    var isFavorite:Bool = false//preguntamos si es false si no esta
    
    // MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //subtitulo
        navigationItem.title = horoscope.name//esto es para mostrar el nombre que contiene el struct
        if #available(iOS 26.0, *) {
            navigationItem.subtitle = horoscope.dates
        } else {
            //version
        }
        //cargamos el imagen secundario
        iconImagenView.image = horoscope.getsecondaryIcon()
        
        
        //cuando entremos cargamoscomprueba si es favorito o no
        isFavorite = sesion.isFavorite(id: horoscope.id)
        favoriteIcon()
        
        
  

    }
    // MARK: FAvorito corazon
    func favoriteIcon(){
        //que si es favorito rellenas y cambias
        if isFavorite{
            favoriteButtonItem.image = UIImage(systemName: "heart.fill")
        } else {
            favoriteButtonItem.image = UIImage(systemName: "heart")
        }

    }

    // MARK: Bar button Item corazon
    @IBAction func Favorite(_ sender: Any) {
        //si quermos usar una funcion dentro cambiamos Any por el nombre que llamos
        //le decimos que la imagen cambie a relleno por los que tiene el sitema
       //eliminamos no hace falta piorque sta arriba
        // favoriteButtonItem.image = UIImage(systemName: "heart.fill")
        //favoriteButtonItem.image
        isFavorite = !isFavorite
        if isFavorite{
            sesion.setFavorite(id: horoscope.id)
        } else {
            sesion.setFavorite(id: "")
        }
        //llamamos a la funcion para que  me lo pinte 
        favoriteIcon()
        
    }
    // MARK: Button Share
    @IBAction func share(_ sender: Any) {
        //falta la api
        let text = "Share"
        
        let textToShare = [text]
        // nos permite mostrar un viewcontroller para compartir
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
    
      //lo presenta de manera animada
        self.present(activityViewController, animated: true, completion: nil)
        
        
    }
    
}
