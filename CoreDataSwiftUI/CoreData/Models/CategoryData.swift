//
//  CategoryData.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 27/02/2023.
//

import Foundation
import CoreData

protocol CategoryCoreAPI {
    func getCatrogries() -> [CategoryModel]
    func isExists() -> Bool
    func addCategory(item:CategoryModel)
}
struct CategoryModel :Identifiable{
    var id:Int
    var name:String

    var categoryData : Category? {
        return CoreDataManager.instance.getItem(entityName: "Category", id: id) as? Category
    }

    static func toCategoryModel(item : Category) -> CategoryModel{
        return Self.init(id: Int(item.id), name: item.name ?? "")
    }
}

class CategoryAPI : CategoryCoreAPI{
    let manager    = CoreDataManager.instance
    let entityName = "Category"

    func getCatrogries() -> [CategoryModel]{
        let list = manager.getItems(entityName: entityName) as? [Category] ?? []
       return list.map { item in
           CategoryModel.toCategoryModel(item: item)
       }
    }



    func isExists() -> Bool{
        return manager.getItems(entityName: entityName).count > 0
    }

    func addCategory(item: CategoryModel){
        let newItem = Category(context: manager.context)
        newItem.setValue(item.id, forKey: "id")
        newItem.setValue(item.name, forKey: "name")
        manager.save()
    }
}
