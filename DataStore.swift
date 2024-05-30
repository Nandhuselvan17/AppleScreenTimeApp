//
//  DataStore.swift
//  appleScreenTimeApp
//
//  Created by apple on 5/30/24.
//

import Foundation
class DataStore {
    static let shared = DataStore()
    
    private init() {}
    
    var selectedCategories: [String] = []
}
