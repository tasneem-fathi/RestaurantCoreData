//
//  FoodData.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 27/02/2023.
//

import Foundation
import CoreData

protocol FoodCoreAPI {
    func getFoods() -> [FoodModel]
    func getFoods(restaurantId:Int, categoryId:Int)  -> [FoodModel]
    func getFood(id:Int)  -> FoodModel?
    func addFood(item:FoodModel)
    func updateFood(item:FoodModel)
    func deleteFood(item:FoodModel)
}

struct FoodModel: Identifiable {
     var id:Int
     var name:String
     var image:String
     var price:Double
     var category:CategoryModel
     var restaurant:RestaurantModel

    var foodData : Food? {
        return CoreDataManager.instance.getItem(entityName: "Food", id: id) as? Food
    }

    static func toFoodModel(item : Food) -> FoodModel{
        return Self.init(id: Int(item.id) , name: item.name ?? "" , image: item.image ?? "", price: item.price, category: CategoryModel.toCategoryModel(item: item.toCategory!), restaurant: RestaurantModel.toRestaurantModel(item: item.toRestaurant!))
    }
}

class FoodAPI : FoodCoreAPI{
    let manager    = CoreDataManager.instance
    let entityName = "Food"

    func getFoods() -> [FoodModel]{
        let list = manager.getItems(entityName: entityName) as? [Food] ?? []
        return  list.map { item in
            FoodModel.toFoodModel(item: item)
        }
    }
    func getFoods(restaurantId: Int, categoryId: Int) -> [FoodModel] {
        let list = manager.getItemsByCategoryRestaurantId(entityName: entityName, restaurantId: restaurantId, categoryId: categoryId) as? [Food] ?? []
        return  list.map { item in
            FoodModel.toFoodModel(item: item)
        }
    }
    func getFood(id: Int) -> FoodModel? {
        guard let item = manager.getItem(entityName: entityName, id: id) as? Food else {return nil}
        return FoodModel.toFoodModel(item: item)
    }

    func addFood(item: FoodModel){
        let newItem = Food(context: manager.context)
        newItem.id = Int32(item.id)
        newItem.name = item.name
        newItem.image = item.image
        newItem.price = item.price
        item.category.categoryData?.addToToFood(newItem)
        item.restaurant.restaurantData?.addToToFood(newItem)
        manager.save()
    }

    func updateFood(item: FoodModel) {
        guard let newItem = manager.getItem(entityName: entityName, id: item.id) as? Food else {return }
        newItem.id = Int32(item.id)
        newItem.name = item.name
        newItem.image = item.image
        newItem.price = item.price
        item.category.categoryData?.addToToFood(newItem)
        item.restaurant.restaurantData?.addToToFood(newItem)
        manager.save()
    }

    func deleteFood(item: FoodModel){
        guard let newItem = manager.getItem(entityName: entityName, id: item.id) as? Food else {return }
        manager.delete(newItem)
    }
}





