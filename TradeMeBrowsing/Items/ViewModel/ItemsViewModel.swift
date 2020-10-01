//
//  ItemsViewModel.swift
//  TradeMeBrowsing
//
//  Created by Flavio Costa on 2/10/20.
//

import Foundation

class ItemsViewModel {
    
    var items: [Item] = []
    
    init(category: Category) {
        items = category.items
    }
}

