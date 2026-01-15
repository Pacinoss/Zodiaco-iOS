//
//  ViewController.swift
//  Zodiaco-iOS
//
//  Created by Tardes on 14/1/26.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var horoscopeList = Horoscope.horoscopeList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        
    }
    //cauntos numero de filas o celdas y pasa la seccion es unica
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return horoscopeList.count//devuelve el nuemro de datos que hay en la lista
    }
    // cual es la celda para la posicion
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {//esta funcion devueleve una tableview cell
       let cell = tableView.dequeueReusableCell(withIdentifier : "Horoscope Cell", for: indexPath) as! HoroscopeViewCell//castear
        let horoscope = horoscopeList[indexPath.row] //
        cell.configure(with: horoscope)///se encargra de rellenar la celdaç
        return cell//devuelve una clase genereica
    }
    
    //cual es la vista para los elemntos
    //funcion que intercepta el destino incluso en kotlin
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {//intersepta l anavegacion de un segue
        let detailViewController = segue.destination as! DetailViewController
        let indexPath = tableView.indexPathForSelectedRow!//saber donde dio click
        let horoscope = horoscopeList[indexPath.row]//accedo a la lista
        detailViewController.horoscope = horoscope//y muestro el  horoscopo
        tableView.deselectRow(at: indexPath, animated: true)//deseleciona el boton pulsado at significa el el selecionado
        
        
        
        
    }


}

