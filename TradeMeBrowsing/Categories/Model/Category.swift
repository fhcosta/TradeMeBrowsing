//
//  Category.swift
//  TradeMeBrowsing
//
//  Created by Flavio Costa on 29/09/20.
//

import Foundation

protocol TradeMeCategory {
    var name: String { get set }
}


struct Category: TradeMeCategory, Hashable {
    
    var name: String
    var number: String
    var totalCount: Int?
   
    var items: [Item]
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.number == rhs.number
    }

}

class Categories {
   
    lazy var categoriesList: [Category] = []


    func loadCategories(completion: @escaping () -> Void){
        
        let tradeMeAPI = TradeMeAPI()
        tradeMeAPI.loadRoot { root in
            guard let rawList = root.rawList else { return }
            for category in rawList {
                if let subcategoryName = category["Name"] as? String, let subcategoryNumber = category["Number"] as? String {
                    tradeMeAPI.loadItemsForCategoryNumber(subcategoryNumber) { categoryData in
                        if self.categoriesList.count < 20 {
                            if let totalCount = categoryData["TotalCount"] as? Int, let list = categoryData["List"] as? [[String:AnyHashable]] {
                                var items: [Item] = []
                                    for item in list {
                                        let listingID = item["ListingId"] as? Int32 ?? 0
                                        let title = item["Title"] as? String ?? ""
                                        let image = item["PictureHref"] as? String ?? ""
                                        items.append(Item(title: title, listingID: listingID, image: image))
                                    }
                                self.categoriesList.append(Category(name: subcategoryName, number: subcategoryNumber, totalCount: totalCount, items: items))
                            }
                        }else{
                            completion()
                        }
                    }
                    
                }
            }
        }
    }
    
}

