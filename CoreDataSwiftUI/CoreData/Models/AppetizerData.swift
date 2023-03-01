//
//  AppetizerData.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 27/02/2023.
//

import Foundation
import CoreData

protocol AppetizerCoreAPI {
    func getAppetizers() -> [AppetizerModel]
    func getAppetizers(restaurantId:Int) -> [AppetizerModel]
    func getAppetizer(id:Int)  -> AppetizerModel?
    func addAppetizer(item:AppetizerModel)
    func updateAppetizer(item:AppetizerModel)
    func deleteAppetizer(item:AppetizerModel)
}

struct AppetizerModel: Identifiable {
     var id:Int
     var name:String
     var image:String
     var price:Double
     var restaurant:RestaurantModel

    var appetizerData : Appetizer? {
        return CoreDataManager.instance.getItem(entityName: "Appetizer", id: id) as? Appetizer
    }

    static func toAppetizerModel(item : Appetizer) -> AppetizerModel{
        return Self.init(id: Int(item.id) , name: item.name ?? "" , image: item.image ?? "",price: item.price, restaurant: RestaurantModel.toRestaurantModel(item: item.toRestaurant!))
    }
}

class AppetizerAPI : AppetizerCoreAPI{


    let manager    = CoreDataManager.instance
    let entityName = "Appetizer"

    func getAppetizers() -> [AppetizerModel]{
        let list = manager.getItems(entityName: entityName) as? [Appetizer] ?? []
        return  list.map { item in
            AppetizerModel.toAppetizerModel(item: item)
        }
    }

    func getAppetizers(restaurantId: Int) -> [AppetizerModel] {
        let list = manager.getItemsByRestaurantId(entityName: entityName, restaurantId: restaurantId) as? [Appetizer] ?? []
        return  list.map { item in
            AppetizerModel.toAppetizerModel(item: item)
        }
    }

    func getAppetizer(id: Int) -> AppetizerModel? {
        guard let item = manager.getItem(entityName: entityName, id: id) as? Appetizer else {return nil}
        return AppetizerModel.toAppetizerModel(item: item)
    }

    func addAppetizer(item: AppetizerModel){
        let newItem = Appetizer(context: manager.context)
        newItem.id = Int32(item.id)
        newItem.name = item.name
        newItem.image = item.image
        newItem.price = item.price
        item.restaurant.restaurantData?.addToToAppetizer(newItem)
       manager.save()
    }

    func updateAppetizer(item: AppetizerModel) {
        guard let newItem = manager.getItem(entityName: entityName, id: item.id) as? Appetizer else {return }
        newItem.id = Int32(item.id)
        newItem.name = item.name
        newItem.image = item.image
        newItem.price = item.price
        item.restaurant.restaurantData?.addToToAppetizer(newItem)
        manager.save()
    }

    func deleteAppetizer(item: AppetizerModel){
        guard let newItem = manager.getItem(entityName: entityName, id: item.id) as? Appetizer else {return }
        manager.delete(newItem)
    }
}





