//
//  Extensions.swift
//  CoreDataSwiftUI
//
//  Created by tasneem .. on 27/02/2023.
//

import Foundation

extension Int {
    func string(){
        NSExpression(forKeyPath: String(self)).keyPath
    }
}
