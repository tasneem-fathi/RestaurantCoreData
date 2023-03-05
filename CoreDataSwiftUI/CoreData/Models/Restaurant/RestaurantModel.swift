//
//  RestaurantData.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 03/03/2023.
//

import Foundation

struct RestaurantModel: Identifiable {
    var id:Int
    var name:String
}

extension RestaurantModel{
    static func toRestaurantModel(item : Restaurant) -> RestaurantModel{
        return Self.init(id: Int(item.id), name: item.name ?? "")
    }
}
