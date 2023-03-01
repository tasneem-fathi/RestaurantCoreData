//
//  DrinksViewModel.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 28/02/2023.
//

import Foundation

class DrinksViewModel: ObservableObject{
    let restaurantApi = RestaurantAPI()
    let DrinkApi       = DrinkAPI()

    @Published var drink : [DrinkModel] = []
    @Published var restaurants  : [RestaurantModel] = []

    var updatedItem : DrinkModel? = nil

    var isEdit : Bool{
        return updatedItem != nil
    }
    @Published var name: String = ""
    @Published var price: String = ""
    @Published var image: String = ""
    @Published var restaurant: RestaurantModel? = nil



    init() {
        fetchDrinks()
    }

    func fetchDrinks(){
       drink =  DrinkApi.getDrinks()
    }

    func addDrink(id:Int){
        let item = DrinkModel(id:id, name: name, image: image, price: Double(price) ?? 0.0,  restaurant: restaurant!)
        DrinkApi.addDrink(item: item)
        fetchDrinks()
    }
    func updateDrink(){
        guard let updatedItem = updatedItem else{return}
        let item = DrinkModel(id:updatedItem.id, name: name, image: image, price: Double(price) ?? 0.0,  restaurant: restaurant!)
        DrinkApi.updateDrink(item: item)
        fetchDrinks()
    }
    func deleteDrink(item:DrinkModel){
        DrinkApi.deleteDrink(item: item)
        fetchDrinks()
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
