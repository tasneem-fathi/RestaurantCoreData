//
//  MenuView.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 27/02/2023.
//

import SwiftUI

struct MenuView: View {
    @StateObject var menuVM  = MenuViewModel()
    @State var selection : Int = 1
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("Restaurants Menu")
                .font(.title)

            Menu {
                ForEach(menuVM.restaurants){ item in
                    Button(item.name) {
                        menuVM.selectedRestaurant = item
                        menuVM.fetchMenuByRestaurant()
                    }
                }

            }
            label: {
                HStack{
                    Text(menuVM.selectedRestaurant?.name ?? "select restaurant")
                    Spacer()
                    Image(systemName: "chevron.down")
                }
            }
            .padding(20)

            TabView(selection: $selection) {
                ForEach(menuVM.categories){ category in
                    VStack(alignment: .leading){
                        Text("Foods")
                            .font(.headline)

                        List(menuVM.foods){ food in
                            MenuItem(name: food.name, image: food.image)
                        }


                    }
                    .tabItem {
                        Text(category.name)
                    }
                }
                VStack(alignment: .leading){
                    Text("Appetizers")
                        .font(.headline)
                    List(menuVM.appetizers){ appitizer in
                        MenuItem(name: appitizer.name, image: appitizer.image)
                    }

                }
                .tabItem {
                    Text("Appetizers")
                }

                VStack(alignment: .leading) {
                    Text("Drinks")
                        .font(.headline)
                    List(menuVM.appetizers){ appitizer in
                        MenuItem(name: appitizer.name, image: appitizer.image)
                    }
                }
                .tabItem {
                    Text("Drinks")
                }
            }
            .padding(.horizontal, 16)
            
        }.onChange(of: selection) { newValue in
            if(selection <= menuVM.categories.count ){
                menuVM.selectedCategory = menuVM.categories[newValue - 1]
                menuVM.fetchFoodByCategory()
            }
        }

        
    }
}

struct MenuItem: View{
     var name : String = ""
     var image : String = ""

    var body : some View{
        HStack(alignment: .center, spacing: 10) {
            Image(image)
                .resizable()
                .frame(width: 70, height: 50)
            Text(name)
                .foregroundColor(.black)
                .font(.body)
        }
        .frame(maxWidth: .infinity, minHeight: 60 , alignment: .leading)
        .foregroundColor(.white)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
