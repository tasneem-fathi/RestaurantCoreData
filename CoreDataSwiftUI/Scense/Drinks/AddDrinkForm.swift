//
//  AddDrinkForm.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 28/02/2023.
//

import SwiftUI

struct AddDrinkForm: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var drinksVM : DrinksViewModel

    @State var showWarningTxt : Bool = false
    @State var drinkImages = ["cocacola","pepsi","sprite"]

    var body: some View {
        Form {
            Text("Add Drink Form")
                .font(.title)

            TextField("Name", text: $drinksVM.name)
                .padding(.top, 30)

            TextField("price", text: $drinksVM.price)
                .keyboardType(.asciiCapableNumberPad)
                .padding(.top, 10)

            Menu {
                ForEach(drinksVM.restaurants){ item in
                    Button(item.name) {
                        drinksVM.restaurant = item
                    }
                }

            } label: {
                HStack{
                    Text(drinksVM.restaurant?.name ?? "select restaurant")
                    Spacer()
                    Image(systemName: "chevron.down")
                }
            }
            .padding(.top, 20)

            Text("select Image")
                .padding(.top, 30)

            ScrollView{
                HStack{
                    ForEach(drinkImages , id: \.self){item in
                        Image(item)
                            .resizable()
                            .cornerRadius(5)
                            .overlay{
                                RoundedRectangle(cornerRadius: 5)
                                    .strokeBorder( drinksVM.image == item ? .blue : .clear , lineWidth: 2)
                                    .frame(width: 50, height: 40)

                            }
                            .frame(width: 50, height: 40)
                            .onTapGesture {
                                drinksVM.image = item
                            }

                    }
                }
            }

            if(showWarningTxt){
                Text("please fill all fields above")
                    .foregroundColor(.red)
            }
            Button("Save") {
                if(drinksVM.isFormValid()){
                    showWarningTxt = false
                    if(drinksVM.isEdit){
                        drinksVM.updateDrink()
                    }else{
                        drinksVM.addDrink(id: drinksVM.drink.count + 1)
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
            drinksVM.fetchRestaurants()
            // if item need to update
            drinksVM.fillFormToUpdate()
        }

    }
}

struct AddDrinkForm_Previews: PreviewProvider {
    static var previews: some View {
        AddDrinkForm()
            .environmentObject(DrinksViewModel())
    }
}
