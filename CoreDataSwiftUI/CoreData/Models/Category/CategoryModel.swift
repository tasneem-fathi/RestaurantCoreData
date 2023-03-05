//
//  CategoryModel.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 03/03/2023.
//

import Foundation

struct CategoryModel: Identifiable {
    var id:Int
    var name:String
}

extension CategoryModel{
    static func toCategoryModel(item : Category) -> CategoryModel{
        return Self.init(id: Int(item.id), name: item.name ?? "")
    }
}
