//
//  HoroscopeViewCell.swift
//  Zodiaco-iOS
//
//  Created by Tardes on 15/1/26.
//

import UIKit

class HoroscopeViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var Icon_imageView: UIImageView!
    @IBOutlet weak var fechas_Label: UILabel!
    @IBOutlet weak var name_Label: UILabel!
    @IBOutlet weak var FavoriteimageView: UIImageView!

    
    
    // MARK: lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    // MARK: configure
    //configurar el horoscon: horoscopo como parametro
    func configure(with horoscope: Horoscope) {
        name_Label.text = horoscope.name
        fechas_Label.text = horoscope.dates
        Icon_imageView.image = horoscope.getIcon()//esta funcion para cargra una imagfen
        FavoriteimageView.isHidden = !SessionManager().isFavorite(id: horoscope.id)
        /*
        if (SessionManager().isFavorite(id: horoscope.id) {
            FavoriteimageView.isHidden = false
            
        } else {
            FavoriteimageView.isHidden = true
            
        }
         */
        
    }
    

}
