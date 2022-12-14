//
//  ManagerPlaces.swift
//  MyPlaces
//
//  Created by PC-793 on 6/10/22.
//

import Foundation

class ManagerPlaces : Codable{
    var places:[Place] = []
    //new
    var placeSelected = -1
    
    enum CodingKeys: String, CodingKey {
        case places
    }
    enum PlacesTypeKey: CodingKey {
        case type
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy:CodingKeys.self)
        try container.encode(places, forKey: .places)
    }
    
    public var m_observers = Array<ManagerPlacesObserver>()

    init(){
        
    }
    
    //******************************************
    // Singleton
    //
    //  Unique instance for all App
    //
    
    private static var sharedManagerVehicles: ManagerPlaces = {
        
        /*var singletonManager:ManagerPlaces
       
        singletonManager = ManagerPlaces()
        
        return singletonManager*/
        var singletonManager:ManagerPlaces?
        singletonManager = load()
        if(singletonManager == nil) {
            singletonManager = ManagerPlaces()
        }
        return singletonManager!
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
    
    public func addObserver(object:ManagerPlacesObserver){
        m_observers.append(object)
    }
    
    public func UpdateObservers(){
        for observer in m_observers{
            observer.onPlacesChange();
        }
    }
    func GetPathImage(p:Place)->String{
        let r = FileSystem.GetPathImage(id:p.id)
        return r;
    }
    
    func store()
    {
        do{
            
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            for place in places {
                if(place.image != nil){
                    FileSystem.WriteData(id:place.id,image:place.image!)
                    place.image = nil;
                }
            }
            FileSystem.Write(data: String(data: data, encoding:.utf8)!)
        }catch{
        }
    }
    
    func decode(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy:CodingKeys.self)
        places = [Place]()
        var objectsArrayForType = try container.nestedUnkeyedContainer(forKey: CodingKeys.places)
        var tmp_array = objectsArrayForType
        while(!objectsArrayForType.isAtEnd)
        {
            let object = try objectsArrayForType.nestedContainer(keyedBy: PlacesTypeKey.self)
            /*let type = try object.decode(Place.PlacesTypes.self,forKey: PlacesTypeKey.type)
            switch type{
                case Place.PlacesTypes.TouristicPlace:
                    self.append(try tmp_array.decode(PlaceTourist.self))
                default :
                    self.append(try tmp_array.decode(Place.self))
            }*/
        }
    }
        
    static func load() -> ManagerPlaces?{
        var resul:ManagerPlaces? = nil
        let data_str = FileSystem.Read()
        if(data_str != "") {
            do{
                let decoder = JSONDecoder()
                let data:Data = Data(data_str.utf8)
                resul = try decoder.decode(ManagerPlaces.self,from:data)
            }
            catch{
                resul = nil
            }
        }
        return resul
    }
}
protocol ManagerPlacesObserver{
    func onPlacesChange()
}
