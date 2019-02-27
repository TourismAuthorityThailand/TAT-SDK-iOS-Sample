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
    
    init(attraction: TATAttractionDetailResult) {
        self.name = attraction.name.isEmpty ? "-" : attraction.name
        self.address = setTextAddress(location : attraction.location)
        self.detail = !attraction.info.detail.isEmpty ? attraction.info.detail : "-"
        self.tel = attraction.contact.phones != nil && attraction.contact.phones.count > 0 ? attraction.contact.phones[0] : "-"
        self.website = attraction.contact.urls != nil && attraction.contact.urls.count > 0 ?  attraction.contact.urls[0] : "-"
        self.facilities = attraction.facilities.count > 0 ? connectString(itemCode: attraction.facilities) : "-"
        self.services = attraction.services.count > 0 ? connectString(itemCode: attraction.services) : "-"
        self.paymentOptions = attraction.payments.count > 0 ? connectString(itemCode: attraction.payments) : "-"
    }
    
    init(accommodation: TATAccommodationDetailResult) {
        self.name = accommodation.name.isEmpty ? "-" : accommodation.name
        self.address = setTextAddress(location : accommodation.location)
        self.detail = !accommodation.info.detail.isEmpty ? accommodation.info.detail : "-"
        self.tel = accommodation.contact.phones != nil && accommodation.contact.phones.count > 0 ?  accommodation.contact.phones[0] : "-"
        self.website = accommodation.contact.urls != nil && accommodation.contact.urls.count > 0 ?  accommodation.contact.urls[0] : "-"
        self.facilities = accommodation.facilities.count > 0 ? connectString(itemCode: accommodation.facilities) : "-"
        self.services = accommodation.services.count > 0 ? connectString(itemCode: accommodation.services) : "-"
        self.paymentOptions = accommodation.payments.count > 0 ? connectString(itemCode: accommodation.payments) : "-"
    }
    
    init(restaurant: TATRestaurantDetailResult) {
        self.name = restaurant.name.isEmpty ? "-" : restaurant.name
        self.address = setTextAddress(location : restaurant.location)
        self.detail = !restaurant.info.detail.isEmpty ? restaurant.info.detail : "-"
        self.tel = restaurant.contact.phones != nil && restaurant.contact.phones.count > 0 ?  restaurant.contact.phones[0] : "-"
        self.website = restaurant.contact.urls != nil &&  restaurant.contact.urls.count > 0 ?  restaurant.contact.urls[0] : "-"
        self.facilities = restaurant.facilities.count > 0 ? connectString(itemCode: restaurant.facilities) : "-"
        self.services = restaurant.services.count > 0 ? connectString(itemCode: restaurant.services) : "-"
        self.paymentOptions = restaurant.payments.count > 0 ? connectString(itemCode: restaurant.payments) : "-"
    }
    
    init(shop: TATShopDetailResult) {
        self.name = shop.name.isEmpty ? "-" : shop.name
        self.address = setTextAddress(location : shop.location)
        self.detail = !shop.info.detail.isEmpty ? shop.info.detail : "-"
        self.tel = shop.contact.phones != nil && shop.contact.phones.count > 0 ?  shop.contact.phones[0] : "-"
        self.website = shop.contact.urls != nil && shop.contact.urls.count > 0 ?  shop.contact.urls[0] : "-"
        self.facilities = shop.facilities.count > 0 ? connectString(itemCode: shop.facilities) : "-"
        self.services = shop.services.count > 0 ? connectString(itemCode: shop.services) : "-"
        self.paymentOptions = shop.payments.count > 0 ? connectString(itemCode: shop.payments) : "-"
    }
    
    init(other: TATOtherPlaceDetailResult) {
        self.name = other.name.isEmpty ? "-" : other.name
        self.address =  setTextAddress(location : other.location)
        self.detail = !other.info.detail.isEmpty ? other.info.detail : "-"
        self.tel = other.contact.phones != nil && other.contact.phones.count > 0 ? other.contact.phones[0] : "-"
        self.website = other.contact.urls != nil && other.contact.urls.count > 0 ? other.contact.urls[0] : "-"
        self.facilities = "-"
        self.services = "-"
        self.paymentOptions = "-"
    }
    
    func connectString(itemCode: [TATItemCode]) -> String {
        var text : [String] = []
        for info in itemCode {
           text.append(info.itemDescription)
        }
        return text.joined(separator: ", ")
    }
    
    func setTextAddress(location : TATFullLocation) -> String{
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
