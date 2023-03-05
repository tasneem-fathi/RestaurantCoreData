//
//  Extensions.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 27/02/2023.
//

import Foundation


extension NSSet {
    func toArray<S>(_ of: S.Type) -> [S] {
        let array = self.map({$0 as! S})
        return array
    }

}
