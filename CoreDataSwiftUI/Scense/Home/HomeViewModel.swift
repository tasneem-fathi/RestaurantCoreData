//
//  HomeViewModel.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 27/02/2023.
//

import Foundation

class HomeViewModel:ObservableObject{

    let restaurants = [RestaurantModel(id: 1, name: "Restaurant1"),RestaurantModel(id: 2, name: "Restaurant2"),RestaurantModel(id: 3, name: "Restaurant3"),RestaurantModel(id: 4, name: "Restaurant4")]
    let categories : [CategoryModel] = [CategoryModel(id: 1, name: "Category1"),CategoryModel(id: 2, name: "Category2")]



    let restaurantApi = RestaurantAPI()
    let categoryApi = CategoryAPI()

    init(){
        if(!categoryApi.isExists()){
            for item in categories {
                categoryApi.addCategory(item: item)
            }
        }
        if(!restaurantApi.isExists()){
            for item in restaurants {
                restaurantApi.addRestaurant(item: item)
            }
        }

        print("categories \(categoryApi.getCatrogries())")
        print("-----------------------------------------")
        print("-----------------------------------------")
        print("restaurants \(restaurantApi.getRestaurants())")
        print("-----------------------------------------")
        print("-----------------------------------------")
    }

}
