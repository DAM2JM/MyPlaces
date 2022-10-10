//
//  PlaceTourist.swift
//  MyPlaces
//
//  Created by PC-793 on 6/10/22.
//

import Foundation
class PlaceTourist:Place {
    
    var discount_tourist: String = ""
    
    
    
    override init() {
        super.init()
        //var type = .TouristicPlace
    }
    init(name:String,description:String,discount_tourist:String,image_in:Data?){
        super.init(type:.TouristicPlace,name:name,description:description,image_in:image_in)
        self.discount_tourist = discount_tourist
        
    }
    
    
}
