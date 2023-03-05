//
//  AddMealsForm.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 03/03/2023.
//

import SwiftUI

struct AddMealsForm: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var mealsVM : MealsViewModel

    @State var showWarningTxt : Bool = false
    var body: some View {
        Form {
            Text("Add Appetizer Form")
                .font(.title)

            Menu {
                ForEach(mealsVM.restaurants){ item in
                    Button(item.name) {
                        mealsVM.selectedRestaurant = item
                    }
                }

            } label: {
                HStack{
                    Text(mealsVM.selectedRestaurant?.name ?? "select restaurant")
                    Spacer()
                    Image(systemName: "chevron.down")
                }
            }
            .padding(.top, 20)

            if(mealsVM.selectedRestaurant != nil){

                VStack(alignment: .leading, spacing: 10){
                    Text("Select Food")
                        .padding(.top, 30)

                    ScrollView{
                        HStack{
                            ForEach(mealsVM.foods){item in
                                VStack{
                                    Image(item.image)
                                        .resizable()
                                        .cornerRadius(5)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 5)
                                                .strokeBorder( mealsVM.selectedFood?.id == item.id ? .blue : .clear , lineWidth: 2)
                                                .frame(width: 50, height: 40)

                                        }
                                        .frame(width: 50, height: 40)
                                        .onTapGesture {
                                            mealsVM.selectedFood = item
                                        }
                                    Text(item.name)
                                }

                            }
                        }
                    }

                    Text("Select Drink")
                        .padding(.top, 30)

                    ScrollView{
                        HStack{
                            ForEach(mealsVM.drinks){item in
                                VStack{
                                    Image(item.image)
                                        .resizable()
                                        .cornerRadius(5)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 5)
                                                .strokeBorder( mealsVM.isDrinkSelected(item: item) ? .blue : .clear , lineWidth: 2)
                                                .frame(width: 50, height: 40)

                                        }
                                        .frame(width: 50, height: 40)
                                        .onTapGesture {
                                            mealsVM.toggleDrink(item: item)
                                        }
                                    Text(item.name)
                                }

                            }
                        }


                    }

                    Text("Select Appetizer")
                        .padding(.top, 30)

                    ScrollView{
                        HStack{
                            ForEach(mealsVM.appetizers){item in
                                VStack{
                                    Image(item.image)
                                        .resizable()
                                        .cornerRadius(5)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 5)
                                                .strokeBorder( mealsVM.isAppetizerSelected(item: item) ? .blue : .clear , lineWidth: 2)
                                                .frame(width: 50, height: 40)

                                        }
                                        .frame(width: 50, height: 40)
                                        .onTapGesture {
                                            mealsVM.toggleAppetizer(item: item)
                                        }
                                    Text(item.name)
                                }

                            }
                        }
                    }

                    TextField("Quantity", text: $mealsVM.quantity)
                        .keyboardType(.asciiCapableNumberPad)
                        .padding(.top, 30)

                }

            }
            if(showWarningTxt){
                Text("please fill all fields above")
                    .foregroundColor(.red)
            }
            Button("Save") {
                if(mealsVM.isFormValid()){
                    showWarningTxt = false
                    mealsVM.addMeal()
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
            mealsVM.fetchRestaurants()

        }
    }
}

struct AddMealsForm_Previews: PreviewProvider {
    static var previews: some View {
        AddMealsForm()
            .environmentObject(MealsViewModel())

    }
}
