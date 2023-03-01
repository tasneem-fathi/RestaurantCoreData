//
//  CoreDataManager.swift
//  CoreDataSwiftUI
//
//  Created by i mac on 12/01/2023.
//

import Foundation
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    let container:NSPersistentContainer
    let context:NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "DB")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Error:\(error.localizedDescription)")
             }
        }
        context = container.viewContext
     }

    func getItems(entityName:String, sortKeys: KeyPath<NSManagedObject,Any?>? = nil) -> [NSManagedObject]{
        let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
        if(sortKeys != nil){
            let sort  = NSSortDescriptor(keyPath: sortKeys!, ascending: true)
            request.sortDescriptors = [sort]
        }
        do {
            return try  context.fetch(request)
        }
        catch(let error){
            fatalError("Error :\(error.localizedDescription)")
        }
    }


    
    func getItem(entityName:String, id: Int) -> NSManagedObject? {
        let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
        request.predicate = NSPredicate(format: "%K == %@","id", NSNumber(value: id))
        request.fetchLimit = 1
        guard let result = try? context.fetch(request) else {return nil}
        guard let  item = result.first else{ return nil}
        return item
    }
    
    func save(complation: @escaping (Error?) -> ()  = { _ in }){
        let context = container.viewContext
        if context.hasChanges {
            do {
               try  container.viewContext.save()
                complation(nil)
                print("Save Done Successfully")
            }catch let error {
                print(error.localizedDescription)
                complation(error)
            }
        }
    }
    
    func delete(_  object : NSManagedObject , complation: @escaping (Error?) -> ()  = { _ in } ) {
        context.delete(object)
        save(complation: complation)
    }

}

// special casses requests
extension CoreDataManager{

    func getItemsByCategoryRestaurantId(entityName:String,restaurantId:Int,categoryId:Int) -> [NSManagedObject]{
        let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
        request.predicate = NSPredicate(format: "toRestaurant.id = %@ AND toCategory.id = %@", NSNumber(value: restaurantId),NSNumber(value: categoryId))
        do {
            return try  context.fetch(request)
        }
        catch(let error){
            fatalError("Error :\(error.localizedDescription)")
        }
    }

    func getItemsByRestaurantId(entityName:String,restaurantId:Int) -> [NSManagedObject]{
        let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
        request.predicate = NSPredicate(format: "toRestaurant.id = %@", NSNumber(value: restaurantId))
        do {
            return try  context.fetch(request)
        }
        catch(let error){
            fatalError("Error :\(error.localizedDescription)")
        }
    }

}
