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
                    tradeMeAPI.loadItemsForCategoryNumber(subcategoryNumber) { [weak self] categoryData in
                        guard let self = self else { return }
                        let count: Int = self.categoriesList.count
                        if count < 20 {
                            self.parseList(categoryData: categoryData, subCategoryName: subcategoryName, subcategoryNumber: subcategoryNumber)
                        }else{
                            completion()
                        }
                    }
                }
            }
        }
    }
    
    func parseList(categoryData: [String: Any], subCategoryName: String, subcategoryNumber: String){
        if let totalCount = categoryData["TotalCount"] as? Int, let list = categoryData["List"] as? [[String:AnyHashable]] {
            
            self.categoriesList.append(Category(name: subCategoryName, number: subcategoryNumber, totalCount: totalCount, items: getAllItems(categoryList: list)))
        }
    }
    
    func getAllItems(categoryList: [[String:AnyHashable]]) -> [Item]{
        let items: [Item] = categoryList.map { item in
            let listingID = item["ListingId"] as? Int ?? 0
            let title = item["Title"] as? String ?? ""
            let image = item["PictureHref"] as? String ?? ""
            return Item(title: title, listingID: listingID, image: image)
        }
        return items
    }
    
}

