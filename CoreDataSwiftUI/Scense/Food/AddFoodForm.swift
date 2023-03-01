//
//  AddFoodForm.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 28/02/2023.
//

import SwiftUI

struct AddFoodForm: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var foodsVM : FoodsViewModel

    @State var showWarningTxt : Bool = false
    @State var foodImages = ["pizza","pasta","steak"]

    var body: some View {
        Form {
            Text("Add Appetizer Form")
                .font(.title)

            TextField("Name", text: $foodsVM.name)
                .padding(.top, 30)

            TextField("price", text: $foodsVM.price)
                .keyboardType(.asciiCapableNumberPad)
                .padding(.top, 10)

            Menu {
                ForEach(foodsVM.restaurants){ item in
                    Button(item.name) {
                        foodsVM.restaurant = item
                    }
                }

            } label: {
                HStack{
                    Text(foodsVM.restaurant?.name ?? "select restaurant")
                    Spacer()
                    Image(systemName: "chevron.down")
                }
            }
            .padding(.top, 20)

            Menu {
                ForEach(foodsVM.categories){ item in
                    Button(item.name) {
                        foodsVM.category = item
                    }
                }

            } label: {
                HStack{
                    Text(foodsVM.category?.name ?? "select category")
                    Spacer()
                    Image(systemName: "chevron.down")
                }
            }
            .padding(.top, 20)

            Text("select Image")
                .padding(.top, 30)

            ScrollView{
                HStack{
                    ForEach(foodImages , id: \.self){item in
                        Image(item)
                            .resizable()
                            .cornerRadius(5)
                            .overlay{
                                RoundedRectangle(cornerRadius: 5)
                                    .strokeBorder( foodsVM.image == item ? .blue : .clear , lineWidth: 2)
                                    .frame(width: 50, height: 40)

                            }
                            .frame(width: 50, height: 40)
                            .onTapGesture {
                                foodsVM.image = item
                            }

                    }
                }
            }

            if(showWarningTxt){
                Text("please fill all fields above")
                    .foregroundColor(.red)
            }
            Button("Save") {
                if(foodsVM.isFormValid()){
                    showWarningTxt = false
                    if(foodsVM.isEdit){
                        foodsVM.updateFood()
                    }else{
                        foodsVM.addFood(id: foodsVM.food.count + 1)
                    }
                    presentationMode.wrappedValue.dismiss()
                }else{
                    showWarningTxt = true
                }

            }
            .foregroundColor(.blue)
            .modifier(HomeButton())
            .padding(.vertical, 40)

        }
        .onAppear{
            foodsVM.fetchRestaurants()
            foodsVM.fetchCategories()
            // if item need to update
            foodsVM.fillFormToUpdate()
        }

    }
}

struct AddFoodForm_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodForm()
            .environmentObject(FoodsViewModel())
    }
}
