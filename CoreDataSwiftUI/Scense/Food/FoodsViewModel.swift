//
//  FoodsViewModel.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 28/02/2023.
//

import Foundation

class FoodsViewModel: ObservableObject{
    let categoryApi   = CategoryAPI()
    let restaurantApi = RestaurantAPI()
    let foodApi       = FoodAPI()

    @Published var food : [FoodModel] = []
    @Published var categories   : [CategoryModel] = []
    @Published var restaurants  : [RestaurantModel] = []

    var updatedItem : FoodModel? = nil

    var isEdit : Bool{
        return updatedItem != nil
    }
    @Published var name: String = ""
    @Published var price: String = ""
    @Published var image: String = ""
    @Published var category: CategoryModel? = nil
    @Published var restaurant: RestaurantModel? = nil



    init() {
        fetchFoods()
    }

    func fetchFoods(){
       food =  foodApi.getFoods()
    }

    func addFood(id:Int){
        let item = FoodModel(id:id, name: name, image: image, price: Double(price) ?? 0.0, category: category!, restaurant: restaurant!)
        foodApi.addFood(item: item)
        fetchFoods()
    }
    func updateFood(){
        guard let updatedItem = updatedItem else{return}
        let item = FoodModel(id:updatedItem.id, name: name, image: image, price: Double(price) ?? 0.0, category: category!, restaurant: restaurant!)
        foodApi.updateFood(item: item)
        fetchFoods()
    }
    func deleteFood(item:FoodModel){
        foodApi.deleteFood(item: item)
        fetchFoods()
    }

    func fetchCategories(){
        categories =  categoryApi.getCatrogries()
    }

    func fetchRestaurants(){
        restaurants =  restaurantApi.getRestaurants()
    }


    func emptyForm(){
        name = ""
        price = ""
        image = ""
        category = nil
        restaurant = nil
    }
    func fillFormToUpdate(){
        guard let updatedItem = updatedItem else {return}
        name = updatedItem.name
        price = String(updatedItem.price)
        image = updatedItem.image
        category = updatedItem.category
        restaurant = updatedItem.restaurant
    }


    func isFormValid() -> Bool{
        return name != "" && price != "" && image != "" && category != nil && restaurant != nil
    }
}
