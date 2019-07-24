//
//  DetailObject.swift
//  TATSDKSample
//

import Foundation
import TATSDK

class DetailObject {
    var name : String!
    var address : String?
    var detail : String?
    var tel : String?
    var website : String?
    var facilities : String?
    var services : String?
    var paymentOptions : String?
    
    init(attraction: TATAttraction) {
        self.name = attraction.name.isEmpty ? "-" : attraction.name
        self.address = setTextAddress(location : attraction.location)
        self.detail = attraction.information?.detail
        self.tel = attraction.contact?.phones?.first
        self.website = attraction.contact?.urls?.first?.absoluteString
        self.facilities = connectString(itemCode: attraction.facilities)
        self.services = connectString(itemCode: attraction.services)
        self.paymentOptions = connectString(itemCode: attraction.paymentMethods)
    }
    
    init(accommodation: TATAccommodation) {
        self.name = accommodation.name.isEmpty ? "-" : accommodation.name
        self.address = setTextAddress(location : accommodation.location)
        self.detail = accommodation.information?.detail
        self.tel = accommodation.contact?.phones?.first
        self.website = accommodation.contact?.urls?.first?.absoluteString
        self.facilities = connectString(itemCode: accommodation.facilities)
        self.services = connectString(itemCode: accommodation.services)
        self.paymentOptions = connectString(itemCode: accommodation.paymentMethods)
    }
    
    init(restaurant: TATRestaurant) {
        self.name = restaurant.name.isEmpty ? "-" : restaurant.name
        self.address = setTextAddress(location : restaurant.location)
        self.detail = restaurant.information?.detail
        self.tel = restaurant.contact?.phones?.first
        self.website = restaurant.contact?.urls?.first?.absoluteString
        self.facilities = connectString(itemCode: restaurant.facilities)
        self.services = connectString(itemCode: restaurant.services)
        self.paymentOptions = connectString(itemCode: restaurant.paymentMethods)
    }
    
    init(shop: TATShop) {
        self.name = shop.name.isEmpty ? "-" : shop.name
        self.address = setTextAddress(location : shop.location)
        self.detail = shop.information?.detail
        self.tel = shop.contact?.phones?.first
        self.website = shop.contact?.urls?.first?.absoluteString
        self.facilities = connectString(itemCode: shop.facilities)
        self.services = connectString(itemCode: shop.services)
        self.paymentOptions = connectString(itemCode: shop.paymentMethods)
    }
    
    init(other: TATOtherPlace) {
        self.name = other.name.isEmpty ? "-" : other.name
        self.address =  setTextAddress(location : other.location)
        self.detail = other.information?.detail
        self.tel = other.contact?.phones?.first
        self.website = other.contact?.urls?.first?.absoluteString
        self.facilities = "-"
        self.services = "-"
        self.paymentOptions = "-"
    }
    
    func connectString(itemCode: [TATItemCode]?) -> String {
        guard let itemCode = itemCode else { return "-" }
        var text : [String] = []
        for info in itemCode {
           text.append(info.itemDescription)
        }
        return text.joined(separator: ", ")
    }
    
    func setTextAddress(location : TATLocation?) -> String {
        var text = ""
        guard let location = location else { return "-" }
        if !location.address.isEmpty {
            text = "\(location.address) "
        }
        
        if !location.subDistrict.isEmpty {
            text += "\(location.subDistrict) "
        }
        
        if !location.district.isEmpty {
            text += "\(location.district) "
        }
        
        if !location.province.isEmpty {
            text += "\(location.province) "
        }
        
        if !location.postcode.isEmpty {
            text += "\(location.postcode) "
        }
        
        return text.isEmpty ? "-" : text
    }
}
