//
//  CityModel.swift
//  NearBy_Airports
//
//  Created by Jitesh Sharma on 11/12/19.
//  Copyright © 2019 Jitesh Sharma. All rights reserved.
//

import Foundation
class CityModel : Codable {
    let code : String?
    let lat : String?
    let lon : String?
    let name : String?
    let city : String?
    let state : String?
    let country : String?
    let woeid : String?
    let tz : String?
    let phone : String?
    let type : String?
    let email : String?
    let url : String?
    let runway_length : String?
    let elev : String?
    let icao : String?
    let direct_flights : String?
    let carriers : String?
    var distanceFromSelectedCity: Double?
    
    enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case lat = "lat"
        case lon = "lon"
        case name = "name"
        case city = "city"
        case state = "state"
        case country = "country"
        case woeid = "woeid"
        case tz = "tz"
        case phone = "phone"
        case type = "type"
        case email = "email"
        case url = "url"
        case runway_length = "runway_length"
        case elev = "elev"
        case icao = "icao"
        case direct_flights = "direct_flights"
        case carriers = "carriers"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        woeid = try values.decodeIfPresent(String.self, forKey: .woeid)
        tz = try values.decodeIfPresent(String.self, forKey: .tz)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        runway_length = try values.decodeIfPresent(String.self, forKey: .runway_length)
        elev = try values.decodeIfPresent(String.self, forKey: .elev)
        icao = try values.decodeIfPresent(String.self, forKey: .icao)
        direct_flights = try values.decodeIfPresent(String.self, forKey: .direct_flights)
        carriers = try values.decodeIfPresent(String.self, forKey: .carriers)
    }
    
}
