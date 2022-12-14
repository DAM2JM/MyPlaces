//
//  Place.swf.swift
//
//
//  Created by PC-793 on 5/10/22.
//

import Foundation
import MapKit

class Place: Codable {
    
    enum PlacesTypes{
        case GenericPlace
        case TouristicPlace
    }
    
    var id: String = ""
    var type: PlacesTypes = .GenericPlace
    var name: String = ""
    var description: String = ""
    var location: CLLocationCoordinate2D!
    var image:Data? = nil
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case description
        case name
        case type
        case latitude
        case longitude
    }
    
    /*required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String.self, forKey: .description)
        //type = try values.decode(PlacesTypes.self, forKey: .type)
    }*/

    func decode(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy:CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        //type = try container.decode(PlacesTypes.self, forKey: .type)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey:.description)
        let latitude = try container.decode(Double.self, forKey:.latitude)
        let longitude = try container.decode(Double.self, forKey:.longitude)
        location = CLLocationCoordinate2D(latitude: latitude,longitude: longitude)
    }
    required convenience init(from decoder: Decoder) throws {
        self.init()
        try decode(from: decoder)
    }
    
    init() {
        self.id = UUID().uuidString
        
    }
    init(name:String,description:String,image_in:Data?){
        self.id = UUID().uuidString
        self.name = name
        self.description = description
        self.image = image_in
    }
    init(type:PlacesTypes,name:String,description:String,image_in:Data?){
        self.id = UUID().uuidString
        self.name = name
        self.description = description
        self.image = image_in
        self.type = type
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy:CodingKeys.self)
        try container.encode(id, forKey: .id)
        // Repetir para el resto de propiedades.
        try container.encode(description, forKey: .description)
        try container.encode(name, forKey: .name)
        try container.encode(type.hashValue, forKey: .type)
        // Para la location, grabamos sus componentes latitud y longitud por separado.
        try container.encode(location.latitude, forKey:.latitude)
        try container.encode(location.longitude, forKey:.longitude)
    }
    
}
