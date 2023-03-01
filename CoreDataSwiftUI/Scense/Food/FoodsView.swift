//
//  FoodsView.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 28/02/2023.
//

import SwiftUI

struct FoodsView: View {
    @StateObject var foodsVM = FoodsViewModel()
    @State var showAddSheet : Bool = false
    var body: some View {
        VStack{
            Text("Foods")
                .font(.title)
            List(foodsVM.food){item in
                HStack(alignment: .center, spacing: 9) {
                    Image(item.image)
                        .resizable()
                        .cornerRadius(5)
                        .frame(width: 50, height: 30)
                    VStack(alignment: .leading){
                        Text(item.name)
                        Text(item.restaurant.name).foregroundColor(.black.opacity(0.5))
                    }
                    Spacer()
                    Text("\(item.price, specifier: "%.1f")") + Text(" $")
                }
                .padding(.horizontal, 10)
                .modifier(DeleteSwipeModifier{
                    foodsVM.deleteFood(item: item)
                })
                .onTapGesture {
                    showAddSheet.toggle()
                    foodsVM.updatedItem = item
                }
            }
        }.toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    foodsVM.updatedItem = nil
                    foodsVM.emptyForm()
                    showAddSheet.toggle()
                } label: {
                    Image(systemName: "plus.rectangle.fill")
                        .foregroundColor(.green)
                        .frame(width: 40, height: 20)
                }
            }
        }
        .sheet(isPresented: $showAddSheet) {
            AddFoodForm()
                .environmentObject(foodsVM)
        }
    }


    
}

struct FoodsView_Previews: PreviewProvider {
    static var previews: some View {
        FoodsView()
    }
}
