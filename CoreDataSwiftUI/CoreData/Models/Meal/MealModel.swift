//
//  MealModel.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 03/03/2023.
//

import Foundation
import CoreData

struct MealModel: Identifiable{
    var id: Int
    var quantity : Int
    var food     : FoodModel
    var appetizers  : [AppetizerModel]
    var drinks      : [DrinkModel]

    var drinksString : String {
        var item = ""
        drinks.forEach { drink in
            item += "\(drink.name) ,"
        }
         item.removeLast()
        return item
    }
    
    var appetizersString : String {
        var item = ""
        appetizers.forEach { appetizer in
            item += "\(appetizer.name) ,"
        }
        item.removeLast()
        return item
    }
}

extension MealModel {

    static func toMealModel(item : Meal) -> MealModel{
        return Self.init(id: Int(item.id), quantity: Int(item.quantity), food: FoodModel.toFoodModel(item: item.toFood!), appetizers: parseToAppetizers(set: item.toAppetizers) , drinks:parseToDrinks(set: item.toDrinks) )
    }


    static func parseToAppetizers(set:NSSet?) -> [AppetizerModel]{
            set?.toArray(Appetizer.self).map { item in
                AppetizerModel.toAppetizerModel(item: item)
            } ?? []
    }


    static func parseToDrinks(set:NSSet?) -> [DrinkModel]{
        set?.toArray(Drink.self).map { item in
            DrinkModel.toDrinkModel(item: item)
        } ?? []
    }
}

