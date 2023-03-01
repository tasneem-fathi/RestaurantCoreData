//
//  HomeView.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 27/02/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeVM = HomeViewModel()
    var body: some View {
        NavigationView{
            VStack{
                Text("Welcome to Core Data Lab")
                    .font(.title)
                    .padding(.bottom, 40)

                NavigationLink("Foods") {
                    FoodsView()
                }
                .modifier(HomeButton())

                NavigationLink("Appetizers") {
                    AppetizersView()
                }
                .modifier(HomeButton())

                NavigationLink("Drink") {
                    DrinksView()
                }
                .modifier(HomeButton())
                Spacer()

                NavigationLink("Menu") {
                    MenuView()
                }
                .modifier(HomeButton())

            }
        }
    }
}
struct HomeButton : ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .frame(width: 300, height: 45)
            .background{RoundedRectangle(cornerRadius: 6)
                    .foregroundColor(.gray.opacity(0.5))
            }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
