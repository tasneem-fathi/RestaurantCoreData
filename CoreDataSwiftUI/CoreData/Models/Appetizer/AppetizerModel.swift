//
//  AppetizerModel.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 03/03/2023.
//

import Foundation


struct AppetizerModel: Identifiable {
     var id:Int
     var name:String
     var image:String
     var price:Double
     var restaurant:RestaurantModel
}

extension AppetizerModel {
    static func toAppetizerModel(item : Appetizer) -> AppetizerModel{
        return Self.init(id: Int(item.id) , name: item.name ?? "" , image: item.image ?? "",price: item.price, restaurant: RestaurantModel.toRestaurantModel(item: item.toRestaurant!))
    }
}
