//
//  MealsView.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 03/03/2023.
//

import SwiftUI

struct MealsView: View {
    @StateObject var mealsVM = MealsViewModel()
    @State var showAddSheet : Bool = false

    var body: some View {

        VStack(alignment: .center, spacing: 10) {
            Text("Meals")
                .font(.title)

            List(mealsVM.meals){ item in
                HStack(alignment: .center, spacing: 9) {
                    Image(item.food.image)
                        .resizable()
                        .cornerRadius(5)
                        .frame(width: 50, height: 30)
                    VStack(alignment: .leading){
                        HStack(alignment: .center, spacing: 9) {
                            Text(item.food.name)
                                .lineLimit(1)
                                .font(.headline)
                                .minimumScaleFactor(0.5)
                            Spacer()
                            Text("Qt : ") +  Text("\(item.quantity)")
                        }

                        Text("Drinks : ")
                              +  Text(item.drinksString)
                                .foregroundColor(.black.opacity(0.5))

                        Text("Appetizers : ")
                              +  Text(item.appetizersString)
                                .foregroundColor(.black.opacity(0.5))
                    }

                }
                .padding(.horizontal, 10)
                .background(.white)
                .cornerRadius(5)
                .frame(maxWidth: .infinity, minHeight: 100)
                .modifier(DeleteSwipeModifier{
                    mealsVM.deleteMeal(item: item)
                })

                .onTapGesture {
                    showAddSheet.toggle()
                }
            }
            }.toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddSheet.toggle()
                    } label: {
                        Image(systemName: "plus.rectangle.fill")
                            .foregroundColor(.green)
                            .frame(width: 40, height: 20)
                    }
                }
            }
            .sheet(isPresented: $showAddSheet) {
                AddMealsForm()
                    .environmentObject(mealsVM)
            }

    }
}

struct MealsView_Previews: PreviewProvider {
    static var previews: some View {
        MealsView()
    }
}
