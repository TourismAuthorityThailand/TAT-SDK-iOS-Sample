//
//  DetailObject.swift
//  TATSDKSample
//

import Foundation
import TATSDK

class DetailObject {
    var name : String!
    var address : String!
    var detail : String!
    var tel : String!
    var website : String!
    var facilities : String!
    var services : String!
    var paymentOptions : String!
    
    init(attraction: TATAttraction) {
        self.name = attraction.name.isEmpty ? "-" : attraction.name
        self.address = setTextAddress(location : attraction.location)
        self.detail = !attraction.information.detail.isEmpty ? attraction.information.detail : "-"
        self.tel = attraction.contact.phones != nil && attraction.contact.phones.count > 0 ? attraction.contact.phones[0] : "-"
        self.website = attraction.contact.urls != nil && attraction.contact.urls.count > 0 ?  attraction.contact.urls[0].absoluteString : "-"
        self.facilities = attraction.facilities.count > 0 ? connectString(itemCode: attraction.facilities) : "-"
        self.services = attraction.services.count > 0 ? connectString(itemCode: attraction.services) : "-"
        self.paymentOptions = attraction.paymentMethods.count > 0 ? connectString(itemCode: attraction.paymentMethods) : "-"
    }
    
    init(accommodation: TATAccommodation) {
        self.name = accommodation.name.isEmpty ? "-" : accommodation.name
        self.address = setTextAddress(location : accommodation.location)
        self.detail = !accommodation.information.detail.isEmpty ? accommodation.information.detail : "-"
        self.tel = accommodation.contact.phones != nil && accommodation.contact.phones.count > 0 ?  accommodation.contact.phones[0] : "-"
        self.website = accommodation.contact.urls != nil && accommodation.contact.urls.count > 0 ?  accommodation.contact.urls[0].absoluteString : "-"
        self.facilities = accommodation.facilities.count > 0 ? connectString(itemCode: accommodation.facilities) : "-"
        self.services = accommodation.services.count > 0 ? connectString(itemCode: accommodation.services) : "-"
        self.paymentOptions = accommodation.paymentMethods.count > 0 ? connectString(itemCode: accommodation.paymentMethods) : "-"
    }
    
    init(restaurant: TATRestaurant) {
        self.name = restaurant.name.isEmpty ? "-" : restaurant.name
        self.address = setTextAddress(location : restaurant.location)
        self.detail = !restaurant.information.detail.isEmpty ? restaurant.information.detail : "-"
        self.tel = restaurant.contact.phones != nil && restaurant.contact.phones.count > 0 ?  restaurant.contact.phones[0] : "-"
        self.website = restaurant.contact.urls != nil &&  restaurant.contact.urls.count > 0 ?  restaurant.contact.urls[0].absoluteString : "-"
        self.facilities = restaurant.facilities.count > 0 ? connectString(itemCode: restaurant.facilities) : "-"
        self.services = restaurant.services.count > 0 ? connectString(itemCode: restaurant.services) : "-"
        self.paymentOptions = restaurant.paymentMethods.count > 0 ? connectString(itemCode: restaurant.paymentMethods) : "-"
    }
    
    init(shop: TATShop) {
        self.name = shop.name.isEmpty ? "-" : shop.name
        self.address = setTextAddress(location : shop.location)
        self.detail = !shop.information.detail.isEmpty ? shop.information.detail : "-"
        self.tel = shop.contact.phones != nil && shop.contact.phones.count > 0 ?  shop.contact.phones[0] : "-"
        self.website = shop.contact.urls != nil && shop.contact.urls.count > 0 ?  shop.contact.urls[0].absoluteString : "-"
        self.facilities = shop.facilities.count > 0 ? connectString(itemCode: shop.facilities) : "-"
        self.services = shop.services.count > 0 ? connectString(itemCode: shop.services) : "-"
        self.paymentOptions = shop.paymentMethods.count > 0 ? connectString(itemCode: shop.paymentMethods) : "-"
    }
    
    init(other: TATOtherPlace) {
        self.name = other.name.isEmpty ? "-" : other.name
        self.address =  setTextAddress(location : other.location)
        self.detail = !other.information.detail.isEmpty ? other.information.detail : "-"
        self.tel = other.contact.phones != nil && other.contact.phones.count > 0 ? other.contact.phones[0] : "-"
        self.website = other.contact.urls != nil && other.contact.urls.count > 0 ? other.contact.urls[0].absoluteString : "-"
        self.facilities = "-"
        self.services = "-"
        self.paymentOptions = "-"
    }
    
    func connectString(itemCode: [TATItemCode]) -> String {
        var text : [String] = []
        for info in itemCode {
            guard let itemDescription = info.itemDescription else { continue }
           text.append(itemDescription)
        }
        return text.joined(separator: ", ")
    }
    
    func setTextAddress(location : TATLocation) -> String{
        var text = ""
        if let address = location.address , !address.isEmpty {
            text = "\(address) "
        }
        
        if let subDistrict = location.subDistrict , !subDistrict.isEmpty {
            text += "\(subDistrict) "
        }
        
        if let district = location.district , !district.isEmpty {
            text += "\(district) "
        }
        
        if let province = location.province , !province.isEmpty {
            text += "\(province) "
        }
        
        if let postcode = location.postcode , !postcode.isEmpty {
            text += "\(postcode) "
        }
        
        return text.isEmpty ? "-" : text
    }
}
