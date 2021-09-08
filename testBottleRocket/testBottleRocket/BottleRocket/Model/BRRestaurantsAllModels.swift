//
//  restaurantsAllModels.swift
//  testBottleRocket
//
//  Created by roreyesl on 07/09/21.
//

import Foundation

// MARK: - Structs
public struct ResponseRestaurant : Codable{
    
    public var result : [detailRestaurant]?
    private enum CodingKeys : String, CodingKey{
        case result = "restaurants"
    }
    public init(){}
}

public struct detailRestaurant : Codable{
    
    public var strName      : String?
    public var strImage     : String?
    public var strCategory  : String?
    public var arrContact   : detailRestaurantContact?
    public var arrLocation  : detailRestaurantLocation?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        strName     =  try (container.decodeIfPresent(String.self, forKey: .strName))
        strImage    =  try (container.decodeIfPresent(String.self, forKey: .strImage))
        strCategory =  try (container.decodeIfPresent(String.self, forKey: .strCategory))
        arrContact  =  try (container.decodeIfPresent(detailRestaurantContact.self, forKey: .arrContact))
        arrLocation =  try (container.decodeIfPresent(detailRestaurantLocation.self, forKey: .arrLocation))
    }
    
    private enum CodingKeys : String, CodingKey{
        case strName       = "name"
        case strImage      = "backgroundImageURL"
        case strCategory   = "category"
        case arrContact    = "contact"
        case arrLocation   = "location"
    }
    
    public init(){}
}

public struct detailRestaurantContact : Codable {
    
    public var strPhone             : String?
    public var strFormatedPhone     : String?
    public var strSocialNetwork     : String?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        strPhone     =  try (container.decodeIfPresent(String.self, forKey: .strPhone))
        strFormatedPhone    =  try (container.decodeIfPresent(String.self, forKey: .strFormatedPhone))
        strSocialNetwork =  try (container.decodeIfPresent(String.self, forKey: .strSocialNetwork))
    }
    
    private enum CodingKeys : String, CodingKey{
        case strPhone              = "phone"
        case strFormatedPhone      = "formattedPhone"
        case strSocialNetwork      = "twitter"
    }
    public init(){}
}

public struct detailRestaurantLocation : Codable{
    
    public var strAddress              : String?
    public var strCrossStreet          : String?
    public var fLatitud                : Float?
    public var fLongitud               : Float?
    public var strPostalCode           : String?
    public var strCC                   : String?
    public var strCity                 : String?
    public var strState                : String?
    public var strCountry              : String?
    public var strformattedAddress     : [String]?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        strAddress  =  try (container.decodeIfPresent(String.self, forKey: .strAddress))
        strCrossStreet  =  try (container.decodeIfPresent(String.self, forKey: .strCrossStreet))
        fLatitud    =  try (container.decodeIfPresent(Float.self, forKey: .fLatitud))
        fLongitud   =  try (container.decodeIfPresent(Float.self, forKey: .fLongitud))
        strPostalCode     =  try (container.decodeIfPresent(String.self, forKey: .strPostalCode))
        strCC   =  try (container.decodeIfPresent(String.self, forKey: .strCC))
        strCity =  try (container.decodeIfPresent(String.self, forKey: .strCity))
        strState    =  try (container.decodeIfPresent(String.self, forKey: .strState))
        strCountry  =  try (container.decodeIfPresent(String.self, forKey: .strCountry))
        strformattedAddress =  try (container.decodeIfPresent([String].self, forKey: .strformattedAddress))
    }
    
    private enum CodingKeys : String, CodingKey{
        case strAddress             = "address"
        case strCrossStreet         = "crossStreet"
        case fLatitud               = "lat"
        case fLongitud              = "lng"
        case strPostalCode          = "postalCode"
        case strCC                  = "cc"
        case strCity                = "city"
        case strState               = "state"
        case strCountry             = "country"
        case strformattedAddress    = "formattedAddress"
    }
    public init(){}
}
