//
//  AppetizersView.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 28/02/2023.
//

import SwiftUI

struct AppetizersView: View {
    @StateObject var appetizersVM = AppetizersViewModel()
    @State var showAddSheet : Bool = false
    var body: some View {
        VStack{
            Text("Appetizers")
                .font(.title)
            List(appetizersVM.Appetizer){item in
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
                    appetizersVM.deleteAppetizer(item: item)
                })

                .onTapGesture {
                    showAddSheet.toggle()
                    appetizersVM.updatedItem = item
                }
            }
        }.toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    appetizersVM.updatedItem = nil
                    appetizersVM.emptyForm()
                    showAddSheet.toggle()
                } label: {
                    Image(systemName: "plus.rectangle.fill")
                        .foregroundColor(.green)
                        .frame(width: 40, height: 20)
                }
            }
        }
        .sheet(isPresented: $showAddSheet) {
            AddAppetizerForm()
                .environmentObject(appetizersVM)
        }
    }



}

struct AppetizersView_Previews: PreviewProvider {
    static var previews: some View {
        AppetizersView()
    }
}
