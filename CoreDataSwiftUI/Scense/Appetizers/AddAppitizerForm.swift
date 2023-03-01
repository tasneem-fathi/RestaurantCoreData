//
//  AddAppetizerForm.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 28/02/2023.
//

import SwiftUI

struct AddAppetizerForm: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appetizersVM : AppetizersViewModel

    @State var showWarningTxt : Bool = false
    @State var AppetizerImages = ["bread","potato","toast"]

    var body: some View {
        Form {
            Text("Add Appetizer Form")
                .font(.title)

            TextField("Name", text: $appetizersVM.name)
                .padding(.top, 30)

            TextField("price", text: $appetizersVM.price)
                .keyboardType(.asciiCapableNumberPad)
                .padding(.top, 10)

            Menu {
                ForEach(appetizersVM.restaurants){ item in
                    Button(item.name) {
                        appetizersVM.restaurant = item
                    }
                }

            } label: {
                HStack{
                    Text(appetizersVM.restaurant?.name ?? "select restaurant")
                    Spacer()
                    Image(systemName: "chevron.down")
                }
            }
            .padding(.top, 20)

            Text("select Image")
                .padding(.top, 30)

            ScrollView{
                HStack{
                    ForEach(AppetizerImages , id: \.self){item in
                        Image(item)
                            .resizable()
                            .cornerRadius(5)
                            .overlay{
                                RoundedRectangle(cornerRadius: 5)
                                    .strokeBorder( appetizersVM.image == item ? .blue : .clear , lineWidth: 2)
                                    .frame(width: 50, height: 40)

                            }
                            .frame(width: 50, height: 40)
                            .onTapGesture {
                                appetizersVM.image = item
                            }

                    }
                }
            }

            if(showWarningTxt){
                Text("please fill all fields above")
                    .foregroundColor(.red)
            }
            Button("Save") {
                if(appetizersVM.isFormValid()){
                    showWarningTxt = false
                    if(appetizersVM.isEdit){
                        appetizersVM.updateAppetizer()
                    }else{
                        appetizersVM.addAppetizer(id: appetizersVM.Appetizer.count + 1)
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
            appetizersVM.fetchRestaurants()
            // if item need to update
            appetizersVM.fillFormToUpdate()
        }

    }
}

struct AddAppetizerForm_Previews: PreviewProvider {
    static var previews: some View {
        AddAppetizerForm()
            .environmentObject(AppetizersViewModel())
    }
}
