//
//  MealAPI.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 03/03/2023.
//

import Foundation
import CoreData

protocol MealCoreAPI {
    func addMeal(quantity:Int, food:FoodModel, drinks:[DrinkModel], appetizers:[AppetizerModel])
    func getMeals() -> [MealModel]
    func deleteMeal(item:MealModel)
    func isExists() -> Bool
}

class MealAPI : MealCoreAPI{

    let manager    = CoreDataManager.instance
    let entityName = "Meal"
    private var meals : [Meal] = []

    init() {
        meals = manager.getItems(entityName: entityName) as? [Meal] ?? []
    }

    func addMeal(quantity: Int, food: FoodModel, drinks: [DrinkModel], appetizers: [AppetizerModel]) {
        let newItem = Meal(context: manager.context)
        newItem.id = Int32(meals.count + 1)
        newItem.quantity = Int32(quantity)
        FoodAPI.getFood(id: food.id)?.addToToMeal(newItem)

        for drink in drinks {
            DrinkAPI.getDrink(id: drink.id)?.addToToMeal(newItem)
        }

        for appetizer in appetizers {
            AppetizerAPI.getAppetizer(id:appetizer.id)?.addToToMeal(newItem)
        }

        manager.save()
    }

    func getMeals() -> [MealModel] {
        return  meals.map { item in
            MealModel.toMealModel(item: item)
        }
    }

    func deleteMeal(item:MealModel) {
        guard let newItem = meals.first(where: { meal in
            meal.id == item.id
        })else {return}
        manager.delete(newItem)
    }

    func isExists() -> Bool{
        return meals.count > 0
    }

}
