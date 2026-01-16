//
//  ViewController.swift
//  Zodiaco-iOS
//
//  Created by Tardes on 14/1/26.
//

import UIKit
//el searchbar lo aañadimos ya delegada para que cunado lo insertamos o podamos usar la funcionalidad tenemos que añadirlo en nuestro class
class ListViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    

    // MARK: Outles
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: propiedades
    var horoscopeList = Horoscope.horoscopeList
    
    // MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        
        //es el buscadore en version 26 es flotante y verwion 18 para atras esta incrustado en el interfaz
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self // sercahcoltroler seria el delegado y control de lo que se hace, self es de tipo valor Any
        navigationItem.searchController = searchController
        
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
    

   
    // el print nos muestra  en el logcat lo que el usuario pone en el buscador (recuerda searchbar es un objeto) por eso ponemos searchText para leer el texto
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        //el if lo añadimos si el buscador eswta vacio  muestrame la lita de hosocopos y no filtarame
        if searchText.isEmpty{
            horoscopeList = Horoscope.horoscopeList
        }else {
            horoscopeList = Horoscope.horoscopeList.filter { horoscope in horoscope.name.localizedCaseInsensitiveContains(searchText) || horoscope.dates.localizedCaseInsensitiveContains(searchText)
            }
        }
        //el comando sirve filtrar la lista en base a un predicado dependiendo de lo que corresponda a los itrem devuelve una funcion lamda; en una funcion lamda nos poemos ahorrar los () el caseinsesitive ignora mayus y minus con name busca el nombre del signo y dates busca por fechas
        tableView.reloadData()//recarga los datos
      
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Buscar: \(searchBar.text ?? "")") //sirve papra leer lo que el usuario esxcriba lo que busca cuando le de a buscar(lupa)
  
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("Cancelar")//sirve cuando el usuario pulsa el boton de cancelar muetsra en el logcat
        //
        horoscopeList = Horoscope.horoscopeList
        tableView.reloadData()
        
    }
    //MARK: Navigation
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
       

