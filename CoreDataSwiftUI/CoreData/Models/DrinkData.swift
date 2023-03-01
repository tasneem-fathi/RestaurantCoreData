//
//  DrinkData.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 27/02/2023.
//

import Foundation
import CoreData

protocol DrinkCoreAPI {
    func getDrinks() -> [DrinkModel]
    func getDrinks(restaurantId:Int) -> [DrinkModel]
    func getDrink(id:Int)  -> DrinkModel?
    func addDrink(item:DrinkModel)
    func updateDrink(item:DrinkModel)
    func deleteDrink(item:DrinkModel)
}

struct DrinkModel: Identifiable {
     var id:Int
     var name:String
     var image:String
     var price:Double
     var restaurant:RestaurantModel

    var DrinkData : Drink? {
        return CoreDataManager.instance.getItem(entityName: "Drink", id: id) as? Drink
    }

    static func toDrinkModel(item : Drink) -> DrinkModel{
        return Self.init(id: Int(item.id) , name: item.name ?? "" , image: item.image ?? "",price: item.price, restaurant: RestaurantModel.toRestaurantModel(item: item.toRestaurant!))
    }
}

class DrinkAPI : DrinkCoreAPI{


    let manager    = CoreDataManager.instance
    let entityName = "Drink"

    func getDrinks() -> [DrinkModel]{
        let list = manager.getItems(entityName: entityName) as? [Drink] ?? []
        return  list.map { item in
            DrinkModel.toDrinkModel(item: item)
        }
    }

    func getDrinks(restaurantId: Int) -> [DrinkModel] {
        let list = manager.getItemsByRestaurantId(entityName: entityName, restaurantId: restaurantId) as? [Drink] ?? []
        return  list.map { item in
            DrinkModel.toDrinkModel(item: item)
        }
    }
    func getDrink(id: Int) -> DrinkModel? {
        guard let item = manager.getItem(entityName: entityName, id: id) as? Drink else {return nil}
        return DrinkModel.toDrinkModel(item: item)
    }

    func addDrink(item: DrinkModel){
        let newItem = Drink(context: manager.context)
        newItem.id = Int32(item.id)
        newItem.name = item.name
        newItem.image = item.image
        newItem.price = item.price
        item.restaurant.restaurantData?.addToToDrink(newItem)
       manager.save()
    }

    func updateDrink(item: DrinkModel) {
        guard let newItem = manager.getItem(entityName: entityName, id: item.id) as? Drink else {return }
        newItem.id = Int32(item.id)
        newItem.name = item.name
        newItem.image = item.image
        newItem.price = item.price
        item.restaurant.restaurantData?.addToToDrink(newItem)
        manager.save()
    }

    func deleteDrink(item: DrinkModel){
        guard let newItem = manager.getItem(entityName: entityName, id: item.id) as? Drink else {return }
        manager.delete(newItem)
    }
}





