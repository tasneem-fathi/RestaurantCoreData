//
//  DeleteSwipeModifier.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 28/02/2023.
//

import Foundation
import SwiftUI

struct DeleteSwipeModifier : ViewModifier{
    let action: () -> ()
    func body(content: Content) -> some View {
        content
            .listRowSeparator(.hidden)
            .listRowBackground(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .padding([.leading, .trailing] , 20)
                    .padding(.bottom, 10)
            )
            .swipeActions(allowsFullSwipe: true) {
                Button(role: .destructive) {
                    action()
                } label: {
                    Image(systemName: "trash.fill")
                        .frame(width: 100, height: 100)
                }
                .frame(width: 100, height: 100)
            }
    }
}
