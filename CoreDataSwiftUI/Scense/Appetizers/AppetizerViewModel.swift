//
//  AppetizersViewModel.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 28/02/2023.
//

import Foundation

class AppetizersViewModel: ObservableObject{
    let restaurantApi = RestaurantAPI()
    let AppetizerApi       = AppetizerAPI()

    @Published var Appetizer : [AppetizerModel] = []
    @Published var restaurants  : [RestaurantModel] = []

    var updatedItem : AppetizerModel? = nil

    var isEdit : Bool{
        return updatedItem != nil
    }
    @Published var name: String = ""
    @Published var price: String = ""
    @Published var image: String = ""
    @Published var restaurant: RestaurantModel? = nil



    init() {
        fetchAppetizers()
    }

    func fetchAppetizers(){
       Appetizer =  AppetizerApi.getAppetizers()
    }

    func addAppetizer(id:Int){
        let item = AppetizerModel(id:id, name: name, image: image, price: Double(price) ?? 0.0,  restaurant: restaurant!)
        AppetizerApi.addAppetizer(item: item)
        fetchAppetizers()
    }
    func updateAppetizer(){
        guard let updatedItem = updatedItem else{return}
        let item = AppetizerModel(id:updatedItem.id, name: name, image: image, price: Double(price) ?? 0.0,  restaurant: restaurant!)
        AppetizerApi.updateAppetizer(item: item)
        fetchAppetizers()
    }
    func deleteAppetizer(item:AppetizerModel){
        AppetizerApi.deleteAppetizer(item: item)
        fetchAppetizers()
    }



    func fetchRestaurants(){
        restaurants =  restaurantApi.getRestaurants()
    }


    func emptyForm(){
        name = ""
        price = ""
        image = ""
        restaurant = nil
    }
    func fillFormToUpdate(){
        guard let updatedItem = updatedItem else {return}
        name = updatedItem.name
        price = String(updatedItem.price)
        image = updatedItem.image
        restaurant = updatedItem.restaurant
    }


    func isFormValid() -> Bool{
        return name != "" && price != "" && image != "" && restaurant != nil
    }
}
