//
//  CategoryAPI.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 03/03/2023.
//

import Foundation
import CoreData

protocol CategoryCoreAPI {
    func getCatrogries() -> [CategoryModel]
    func isExists() -> Bool
    func addCategory(item:CategoryModel)
}


class CategoryAPI : CategoryCoreAPI{
    let manager    = CoreDataManager.instance
    let entityName = "Category"
    private var categories : [Category] = []

    init(){
        categories = manager.getItems(entityName: entityName) as? [Category] ?? []
    }

    func getCatrogries() -> [CategoryModel]{
       return categories.map { item in CategoryModel.toCategoryModel(item: item)}
    }

    func isExists() -> Bool{
        return categories.count > 0
    }

    func addCategory(item: CategoryModel){
        let newItem = Category(context: manager.context)
        newItem.setValue(item.id, forKey: "id")
        newItem.setValue(item.name, forKey: "name")
        manager.save()
    }
}

extension CategoryAPI{
    static func getCategory(id:Int) -> Category? {
        return CoreDataManager.instance.getItem(entityName: "Category", id: id) as? Category
    }
}
