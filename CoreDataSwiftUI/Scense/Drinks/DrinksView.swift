//
//  DrinksView.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 28/02/2023.
//

import SwiftUI

struct DrinksView: View {
    @StateObject var drinksVM = DrinksViewModel()
    @State var showAddSheet : Bool = false
    var body: some View {
        VStack{
            Text("Drinks")
                .font(.title)
            List(drinksVM.drink){item in
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
                .background(.white)
                .cornerRadius(5)
                .frame(maxWidth: .infinity, minHeight: 60)
                .modifier(DeleteSwipeModifier{
                    drinksVM.deleteDrink(item: item)
                })
                .onTapGesture {
                    showAddSheet.toggle()
                    drinksVM.updatedItem = item
                }
            }
        }.toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    drinksVM.updatedItem = nil
                    drinksVM.emptyForm()
                    showAddSheet.toggle()
                } label: {
                    Image(systemName: "plus.rectangle.fill")
                        .foregroundColor(.green)
                        .frame(width: 40, height: 20)
                }
            }
        }
        .sheet(isPresented: $showAddSheet) {
            AddDrinkForm()
                .environmentObject(drinksVM)
        }
    }



}

struct DrinksView_Previews: PreviewProvider {
    static var previews: some View {
        DrinksView()
    }
}
