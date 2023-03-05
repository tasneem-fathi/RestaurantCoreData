//
//  MenuViewModel.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 27/02/2023.
//

import Foundation

class MenuViewModel:ObservableObject{

    let restaurantApi   = RestaurantAPI()
    let categoryApi     = CategoryAPI()
    let foodApi         = FoodAPI()
    let drinkApi        = DrinkAPI()
    let appetizersApi   = AppetizerAPI()

    @Published var restaurants : [RestaurantModel] = []
    @Published var categories  : [CategoryModel] = []
    @Published var foods       : [FoodModel] = []
    @Published var appetizers  : [AppetizerModel] = []
    @Published var drinks      : [DrinkModel] = []

    @Published var selectedRestaurant : RestaurantModel? = nil
    @Published var selectedCategory   : CategoryModel? = nil

    init(){
      fetchRestaurants()
      fetchCategories()
    }

    func fetchRestaurants(){
       restaurants = restaurantApi.getRestaurants()
    }

    func fetchCategories(){
        categories = categoryApi.getCatrogries()
    }

    func fetchMenuByRestaurant(){
        foods       = foodApi.getFoods(restaurantId: selectedRestaurant?.id ?? 0, categoryId: categories[0].id)
        appetizers  = appetizersApi.getAppetizers(restaurantId: selectedRestaurant?.id ?? 0)
        drinks      = drinkApi.getDrinks(restaurantId: selectedRestaurant?.id ?? 0)
    }

    func fetchFoodByCategory(){
        foods = foodApi.getFoods(restaurantId: selectedCategory?.id ?? 0, categoryId: selectedCategory?.id ?? 0)
    }

}
