//
//  MealsViewModel.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 03/03/2023.
//

import Foundation
import SwiftUI

class MealsViewModel : ObservableObject {
    let restaurantApi   = RestaurantAPI()
    let foodApi         = FoodAPI()
    let drinkApi        = DrinkAPI()
    let appetizersApi   = AppetizerAPI()
    let mealsApi        = MealAPI()

    @Published var restaurants : [RestaurantModel] = []
    @Published var foods       : [FoodModel] = []
    @Published var appetizers  : [AppetizerModel] = []
    @Published var drinks      : [DrinkModel] = []
    @Published var meals       : [MealModel] = []


    @Published var quantity : String = "0"
    @Published var selectedFood : FoodModel? = nil
    @Published var selectedDrinks : [DrinkModel] = []
    @Published var selectedAppetizers : [AppetizerModel] = []
    @Published var selectedRestaurant: RestaurantModel? = nil
    {
        didSet{
            fetchMenu()
            resetForm()
        }
    }

    init(){
        fetchMeals()
    }

    func fetchMeals(){
        meals = mealsApi.getMeals()
    }
    func fetchRestaurants(){
        restaurants = restaurantApi.getRestaurants()
    }

    func fetchMenu(){
        guard let selectedRestaurant = selectedRestaurant else {return}
        foods = foodApi.getFoods(restaurantId: selectedRestaurant.id)
        appetizers = appetizersApi.getAppetizers(restaurantId: selectedRestaurant.id)
        drinks = drinkApi.getDrinks(restaurantId: selectedRestaurant.id)
    }

    func addMeal(){
        mealsApi.addMeal(quantity: Int(quantity) ?? 0, food: selectedFood!, drinks: selectedDrinks, appetizers: selectedAppetizers)
        fetchMeals()
    }

    func deleteMeal(item:MealModel){
        mealsApi.deleteMeal(item: item)
        fetchMeals()
    }

    func isDrinkSelected(item:DrinkModel) -> Bool{
        return selectedDrinks.contains { drink in
            item.id == drink.id
        }
    }

    func resetForm(){
        quantity = "0"
        selectedFood = nil
        selectedAppetizers = []
        selectedDrinks = []
    }
    
    func toggleDrink(item:DrinkModel){
        if(isDrinkSelected(item: item)){
            selectedDrinks.removeAll { drink in
                item.id == drink.id
            }
        }else{
            selectedDrinks.append(item)
        }
    }


    func isAppetizerSelected(item:AppetizerModel) -> Bool{
        return selectedAppetizers.contains { appetizer in
            item.id == appetizer.id
        }
    }

    func toggleAppetizer(item:AppetizerModel){
        if(isAppetizerSelected(item: item)){
            selectedAppetizers.removeAll { appetizer in
                item.id == appetizer.id
            }
        }else{
            selectedAppetizers.append(item)
        }
    }

    func isFormValid() -> Bool{
        return quantity != "0" && selectedFood != nil && selectedDrinks.count > 0 && selectedAppetizers.count > 0
    }

    
}
