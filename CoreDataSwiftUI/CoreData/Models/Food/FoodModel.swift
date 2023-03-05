//
//  FoodModel.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 03/03/2023.
//

import Foundation

struct FoodModel: Identifiable {
     var id:Int
     var name:String
     var image:String
     var price:Double
     var category:CategoryModel
     var restaurant:RestaurantModel

}

extension FoodModel{
    static func toFoodModel(item : Food) -> FoodModel{
        return Self.init(id: Int(item.id) , name: item.name ?? "" , image: item.image ?? "", price: item.price, category: CategoryModel.toCategoryModel(item: item.toCategory!), restaurant: RestaurantModel.toRestaurantModel(item: item.toRestaurant!))
    }
}
