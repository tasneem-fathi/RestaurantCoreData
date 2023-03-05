//
//  DrinkAPI.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 03/03/2023.
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

class DrinkAPI : DrinkCoreAPI{
    let manager    = CoreDataManager.instance
    let entityName = "Drink"
    private var drinks : [Drink] = []

    init(){
        drinks = manager.getItems(entityName: entityName) as? [Drink] ?? []

    }

    func getDrinks() -> [DrinkModel]{
        return  drinks.map { item in
            DrinkModel.toDrinkModel(item: item)
        }
    }

    func getDrinks(restaurantId: Int) -> [DrinkModel] {
        let list = drinks.filter { drink in
            (drink.toRestaurant?.id ?? 0)  == restaurantId
        }

        return  list.map { item in
            DrinkModel.toDrinkModel(item: item)
        }
    }
    func getDrink(id: Int) -> DrinkModel? {
        let item = drinks.first { drink in
            (drink.id) == id
        }
        guard let item = item else {return nil}
        return DrinkModel.toDrinkModel(item: item)
    }

    func addDrink(item: DrinkModel){
        let newItem = Drink(context: manager.context)
        newItem.id = Int32(item.id)
        newItem.name = item.name
        newItem.image = item.image
        newItem.price = item.price
        RestaurantAPI.getRestaurant(id: item.id)?.addToToDrink(newItem)
       manager.save()
    }

    func updateDrink(item: DrinkModel) {
        let newItem = drinks.first { drink in
            (drink.id) == item.id
        }
        guard let newItem = newItem else {return}
        newItem.id = Int32(item.id)
        newItem.name = item.name
        newItem.image = item.image
        newItem.price = item.price
        RestaurantAPI.getRestaurant(id: item.id)?.addToToDrink(newItem)
        manager.save()
    }

    func deleteDrink(item: DrinkModel){
        let newItem = drinks.first { drink in
            (drink.id) == item.id
        }
        guard let newItem = newItem else {return}
        manager.delete(newItem)
    }
}

extension DrinkAPI{
    static func getDrink(id:Int) -> Drink?{
        return CoreDataManager.instance.getItem(entityName: "Drink", id: id) as? Drink

    }
}





