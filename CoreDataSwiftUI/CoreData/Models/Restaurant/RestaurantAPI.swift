//
//  RestaurantAPI.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 03/03/2023.
//

import Foundation
import CoreData

protocol RestaurantCoreAPI {
    func getRestaurants() -> [RestaurantModel]
    func isExists() -> Bool
    func addRestaurant(item:RestaurantModel)

}



class RestaurantAPI : RestaurantCoreAPI{
    let manager    = CoreDataManager.instance
    let entityName = "Restaurant"
    private var restaurants : [Restaurant] = []

    init() {
        restaurants = manager.getItems(entityName: entityName) as? [Restaurant] ?? []
    }

    func getRestaurants() -> [RestaurantModel]{
       return restaurants.map { item in
           RestaurantModel.toRestaurantModel(item: item)
       }
    }

    func isExists() -> Bool{
        return restaurants.count > 0
    }

    func addRestaurant(item: RestaurantModel){
        let newItem = Restaurant(context: manager.context)
        newItem.setValue(item.id, forKey: "id")
        newItem.setValue(item.name, forKey: "name")
        manager.save()
    }

}

extension RestaurantAPI{
    static func getRestaurant(id:Int) -> Restaurant?{
        return CoreDataManager.instance.getItem(entityName: "Restaurant", id: id) as? Restaurant
    }
}


