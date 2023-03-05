//
//  FoodAPI.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 03/03/2023.
//

import Foundation
import CoreData

protocol FoodCoreAPI {
    func getFoods() -> [FoodModel]
    func getFoods(restaurantId:Int, categoryId:Int)  -> [FoodModel]
    func getFoods(restaurantId:Int)  -> [FoodModel]
    func getFood(id:Int)  -> FoodModel?
    func addFood(item:FoodModel)
    func updateFood(item:FoodModel)
    func deleteFood(item:FoodModel)
}

class FoodAPI : FoodCoreAPI{
    let manager    = CoreDataManager.instance
    let entityName = "Food"
    private var foods : [Food] = []

    init() {
        foods = manager.getItems(entityName: entityName) as? [Food] ?? []
    }

    func getFoods() -> [FoodModel]{
        return  foods.map { item in
            FoodModel.toFoodModel(item: item)
        }
    }
    func getFoods(restaurantId: Int, categoryId: Int) -> [FoodModel] {
        let list = foods.filter { food in
            ((food.toRestaurant?.id ?? 0)  == restaurantId) && ((food.toCategory?.id ?? 0)  == categoryId)
        }
        return  list.map { item in
            FoodModel.toFoodModel(item: item)
        }
    }
    func getFoods(restaurantId: Int) -> [FoodModel] {
        let list = foods.filter { food in
            ((food.toRestaurant?.id ?? 0)  == restaurantId)
        }
        return  list.map { item in
            FoodModel.toFoodModel(item: item)
        }
    }
    func getFood(id: Int) -> FoodModel? {
        let item = foods.first { food in
            food.id == id
        }
        guard let item = item else {return nil}
        return FoodModel.toFoodModel(item: item)
    }

    func addFood(item: FoodModel){
        let newItem = Food(context: manager.context)
        newItem.id = Int32(item.id)
        newItem.name = item.name
        newItem.image = item.image
        newItem.price = item.price
        CategoryAPI.getCategory(id:item.category.id)?.addToToFood(newItem)
        RestaurantAPI.getRestaurant(id: item.id)?.addToToFood(newItem)
        manager.save()
    }

    func updateFood(item: FoodModel) {
        let newItem = foods.first { food in
            food.id == item.id
        }
        guard let newItem = newItem else {return }
        newItem.id = Int32(item.id)
        newItem.name = item.name
        newItem.image = item.image
        newItem.price = item.price
        CategoryAPI.getCategory(id:item.category.id)?.addToToFood(newItem)
        RestaurantAPI.getRestaurant(id: item.id)?.addToToFood(newItem)
        manager.save()
    }

    func deleteFood(item: FoodModel){
        let item = foods.first { food in
            food.id == item.id
        }
        guard let item = item else {return }
        manager.delete(item)
    }
}

extension FoodAPI{
    static func getFood(id:Int) -> Food?{
        return CoreDataManager.instance.getItem(entityName: "Food", id: id) as? Food

    }
}





