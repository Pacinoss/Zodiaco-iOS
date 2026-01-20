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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var iconImagenView: UIImageView!
    @IBOutlet weak var PredictionTextView: UITextView!
    //imagen
    
    // MARK: propiedades
    var horoscope:Horoscope!
    var sesion : SessionManager = SessionManager()//y llamamos al constructor
    var isFavorite:Bool = false//preguntamos si es false si no esta
    var prediction : String? = nil
    
    
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
        gethoroscopepredicion()
        
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
    // MARK: Actions
    // MARK: segmento de control
    @IBAction func changePrediction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{ //con el swith hacemo la llamada con  el caso que sea sabiendo cual es el segmento selecionado y segun el que sea  hacemos la llamda a internet  pasandole los datos a su nombre correspondiente
        case 0:
            gethoroscopepredicion(period: "daily")
           // print("primer period")
        case 1:
            gethoroscopepredicion(period: "weekly")
           // print("second period")
        default:
            gethoroscopepredicion(period: "monthly")
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
        if let prediction = prediction{
            
            //falta la api
            let text = "mira mi predicion \(horoscope.name): \(prediction)"
            
            let textToShare = [text]
            // nos permite mostrar un viewcontroller para compartir
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            
            //lo presenta de manera animada
            self.present(activityViewController, animated: true, completion: nil)
        }
        
        
    }
    func gethoroscopepredicion(period:String = "daily") {
        activityIndicator.isHidden = false
        self.PredictionTextView.text = "Consultando"
        
        // lo malo delel guard y el if es que podemos llamar variables del mismo nombre; el probelma que noms liarimaos mas y no tendria orden

        let url = URL(string:"https://horoscope-app-api.vercel.app/api/v1/get-horoscope/\(period)?sign=\(horoscope.id)&day=TODAY")//cambiamos y añadimos al url hosocope para que busque por el id de horocope y cambiamos sign por daily para que la primera que llamada que haga se a diario y continue si pulsamos en la sigueinte que searia semanal
        
        //tambien podemos usar if cumple la misma funcionn el guRD ES LA  como la version mala
        //si la url no es nulo salta este bloque y sigue con el if
        //el guard se utiliza mas para comprobar si su url es valida
        guard let url = url else {
            print("Invalido URL")
            //el guard nos obliga a lanzar un error o un return
            return
            // el ejempo de url del mismno nombre esto nos sirve para comprobar errores
        }
        /*
            //MARK: ejemplo del if let con URL
        //el guard analiza primero la parte negativa por si el url es invalido
        //minetras que el if es al contrario comprueba que si es valido y podriamos jugar con la url dentro del if; recordando que el else{} es opcional
            if let url = URL(string:"https://itunes.apple.com/search?term=taylor+swift&entity=song") {
                url
                
            }else{//si es nulo controlamos el error con el else
                print ("URL invalida")
                return
            }
            */
        
        
        Task { // nos esta creando una specia de corrutina una tarea asincrona o en segundoi plano
            // se utiliza para comproibar errores tambien se utiliza en try cacht en kotlin; erroresw como si no tienes errores evitando que la app se cierre
            // como vamos a utilizar una llamada a internet este do, catch estaria en un hijo secundario
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                //comprobamos que nos deviuelve
              /*  if let str = String(data: data, encoding: .utf8){
                    print("decodificacion correcta: \(str)")
                    //convertirmos un data a sring pone el if por si es nulo
                }
               */
                
                // el decimos que convierta los datos en json y lo casteamos por que es de tipo diccionario y utlizamos try por si falla recordad que cada linea que puede fallar ponemos uyn try
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                print(jsonObject)//este mestra todos los datos que continee  jsonobject de la api que utilizamos
                let jsonObjectdata = jsonObject["data"] as! [String:String]
                
                let result = jsonObjectdata["horoscope_data"]!// si le ponemos la exclamacion es por que estamos segurisimos que valor nos va a devolver
                
                prediction = result
            
                // ejecute el hilo principal de manera asincrona
                DispatchQueue.main.async {
                    //mostrar el resultado en pantalla
                    print(result) // este es el resultado; muestra el string que  continee el signo selecionado  de hosocope_data
                    self.PredictionTextView.text = result
                    self.activityIndicator.isHidden = true

                    
                }
                
            } catch {
                print("Invalid data")
                DispatchQueue.main.async {
                    //mostrar el resultado en pantalla
                    print("error en el catch") // este es el resultado; muestra el string que  continee el signo selecionado  de hosocope_data
                    self.PredictionTextView.text = "Error Inesperado, intente mas tarde"
                    self.activityIndicator.isHidden = true

                    
                }
            }

        }
        
        
    }
    
}






