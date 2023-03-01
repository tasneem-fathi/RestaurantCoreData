//
//  RestaurantData.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 27/02/2023.
//

import Foundation
import CoreData

protocol RestaurantCoreAPI {
    func getRestaurants() -> [RestaurantModel]
    func isExists() -> Bool
    func addRestaurant(item:RestaurantModel)

}

struct RestaurantModel: Identifiable {
    var id:Int
    var name:String

    var restaurantData : Restaurant? {
        return CoreDataManager.instance.getItem(entityName: RestaurantAPI.entityName, id: id) as? Restaurant

    }

    static func toRestaurantModel(item : Restaurant) -> RestaurantModel{
        return Self.init(id: Int(item.id), name: item.name ?? "")
    }
}

class RestaurantAPI : RestaurantCoreAPI{


    let manager    = CoreDataManager.instance
    static let entityName = "Restaurant"

    func getRestaurants() -> [RestaurantModel]{
        let list = manager.getItems(entityName: RestaurantAPI.entityName) as? [Restaurant] ?? []
       return list.map { item in
           RestaurantModel.toRestaurantModel(item: item)
       }
    }
   
    func isExists() -> Bool{
        return manager.getItems(entityName: RestaurantAPI.entityName).count > 0
    }

    func addRestaurant(item: RestaurantModel){
        let newItem = Restaurant(context: manager.context)
        newItem.setValue(item.id, forKey: "id")
        newItem.setValue(item.name, forKey: "name")
        manager.save()
    }
}


