//
//  AppetizerAPI.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 03/03/2023.
//

import Foundation

protocol AppetizerCoreAPI {
    func getAppetizers() -> [AppetizerModel]
    func getAppetizers(restaurantId:Int) -> [AppetizerModel]
    func getAppetizer(id:Int)  -> AppetizerModel?
    func addAppetizer(item:AppetizerModel)
    func updateAppetizer(item:AppetizerModel)
    func deleteAppetizer(item:AppetizerModel)
}

class AppetizerAPI : AppetizerCoreAPI{
    let manager    = CoreDataManager.instance
    let entityName = "Appetizer"
    private var appetizers : [Appetizer] = []

    init(){
        appetizers = manager.getItems(entityName: entityName) as? [Appetizer] ?? []
    }

    func getAppetizers() -> [AppetizerModel]{
        return  appetizers.map { item in
            AppetizerModel.toAppetizerModel(item: item)
        }
    }

    func getAppetizers(restaurantId: Int) -> [AppetizerModel] {
        let list = appetizers.filter { appetizer in
            (appetizer.toRestaurant?.id ?? 0) == restaurantId
        }
        return  list.map { item in
            AppetizerModel.toAppetizerModel(item: item)
        }
    }

    func getAppetizer(id: Int) -> AppetizerModel? {
        let item = appetizers.first { appetizer in
            appetizer.id == id
        }
        guard let item = item else {return nil}
        return AppetizerModel.toAppetizerModel(item: item)
    }

    func addAppetizer(item: AppetizerModel){
        let newItem = Appetizer(context: manager.context)
        newItem.id = Int32(item.id)
        newItem.name = item.name
        newItem.image = item.image
        newItem.price = item.price
        RestaurantAPI.getRestaurant(id: item.id)?.addToToAppetizer(newItem)
       manager.save()
    }

    func updateAppetizer(item: AppetizerModel) {
        guard let newItem = appetizers.first(where: { appetizer in
            appetizer.id == item.id
        })else {return}
        newItem.id = Int32(item.id)
        newItem.name = item.name
        newItem.image = item.image
        newItem.price = item.price
        RestaurantAPI.getRestaurant(id: item.id)?.addToToAppetizer(newItem)
        manager.save()
    }

    func deleteAppetizer(item: AppetizerModel){
        guard let newItem = appetizers.first(where: { appetizer in
            appetizer.id == item.id
        })else {return}
        manager.delete(newItem)
    }
}


extension AppetizerAPI{
    static func getAppetizer(id:Int) -> Appetizer? {
        return CoreDataManager.instance.getItem(entityName: "Appetizer", id: id) as? Appetizer
    }

}
