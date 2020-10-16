//
//  Item.swift
//  TradeMeBrowsing
//
//  Created by Flavio Costa on 2/10/20.
//

import Foundation


struct Item: Hashable{
    
    let id = UUID()
    let title: String
    let listingID: Int
    let image: String
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
    
}
