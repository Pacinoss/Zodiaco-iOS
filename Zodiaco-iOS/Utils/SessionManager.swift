//
//  SessionManager.swift
//  Zodiaco-iOS
//
//  Created by Tardes on 16/1/26.
//

import Foundation

class SessionManager {
    
    
    let defaults = UserDefaults.standard
    //es para guardar
    func setFavorite(id:String){//favorite_horoscope es un nombre al azar
        defaults.set(id, forKey: "favorite_horoscope")
        
    }
    //es para no guardar
    func getFavorite() -> String{//cuando no hayya ningun me devuelve vacio null
        defaults.string(forKey: "favorite_horoscope") ?? ""
    }
    // es para preguntar ¿esta en favorite?
    func isFavorite(id:String) -> Bool{
        id == getFavorite()// esto devuelve un id de objeto si esta en favoritos del objeto
    }
}
