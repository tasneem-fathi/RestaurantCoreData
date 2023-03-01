//
//  MealData.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 01/03/2023.
//

import Foundation

protocol MealCoreAPI {
    func addMeal(quantity:Int, food:FoodModel, drinks:[DrinkModel], appetizers:[AppetizerModel])
    func getMeals(restaurantId:Int) -> [MealModel]
}

struct MealModel: Identifiable{
    var id: Int
    var quantity : Int
    var food     : FoodModel
    var appetizers  : [AppetizerModel]
    var drinks      : [DrinkModel]

    var mealData : Meal? {
        return CoreDataManager.instance.getItem(entityName: "Meal", id: id) as? Meal
    }

//    static func toMealModel(item : Meal) -> MealModel{
//        return Self.init(id: Int(item.id), quantity: Int(item.quantity), food: FoodModel.toFoodModel(item: item.toFood!), appetizers: item.toAppetizers, drinks: item.toDrinks)
//    }
}

class MealAPI : MealCoreAPI{
    let manager    = CoreDataManager.instance
    let entityName = "Meal"


    func addMeal(quantity: Int, food: FoodModel, drinks: [DrinkModel], appetizers: [AppetizerModel]) {
        let newItem = Meal(context: manager.context)
        newItem.id = 1
        newItem.quantity = Int32(quantity)
        food.foodData?.addToToMeal(newItem)
        for drink in drinks {
            drink.DrinkData?.addToToMeal(newItem)
        }
        for appetizer in appetizers {
            appetizer.appetizerData?.addToToMeal(newItem)
        }

        manager.save()
    }

    func getMeals(restaurantId: Int) -> [MealModel] {
//        let list = manager.getItems(entityName: entityName,sortKeys: \Meal.toFood?.toRestaurant?.id ) as? [Meal] ?? []
//        return  list.map { item in
//            MealModel.toFoodModel(item: item)
//        }

        return []
    }
}


