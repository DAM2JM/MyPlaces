//
//  ManagerPlaces.swift
//  MyPlaces
//
//  Created by PC-793 on 6/10/22.
//

import Foundation

class ManagerPlaces{
    var places:[Place] = []
    
    var placeSelected = -1
    
    init(){
        
    }
    
    //******************************************
    // Singleton
    //
    //  Unique instance for all App
    //
    
    private static var sharedManagerVehicles: ManagerPlaces = {
        
        var singletonManager:ManagerPlaces
       
        singletonManager = ManagerPlaces()
        
        return singletonManager
    }()
    
    class func shared() -> ManagerPlaces {
        return sharedManagerVehicles
    }
    
    func append(value:Place){
        places.append(value)
    }
    
    func GetCount()->Int{
        return places.count
    }
    func GetItemAt(position:Int) -> Place{
        return places[position]
    }
    func GetItemById(id:String) -> Place{
        return places.filter{
            $0.id == id}[0]
    }
    func remove(_ value:Place){
        places = places.filter{ $0.id != value.id}
    }
    
    func getPlaces() -> [Place]{
        return places
    }
    
    func setPlaceSelected(position:Int){
        placeSelected = position
    }
    func getPlaceSelected () -> Place{
        return GetItemAt(position: placeSelected)
    }
    
}
