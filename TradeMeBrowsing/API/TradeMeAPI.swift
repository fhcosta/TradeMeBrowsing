//
//  TradeMeAPI.swift
//  TradeMeBrowsing
//
//  Created by Flavio Costa on 29/09/20.
//

import Foundation

class TradeMeAPI {
    
    private let consumerKey = "8EB318E3053F9966909C376DA510068E"
    private let secret = "C2EDC1C377B4177E82467278B8E20B2C"
    private let categoryBrowsingEndpoint = "https://api.tmsandbox.co.nz/v1/Categories/0.json"
    private let generalSearchEndpoint = "https://api.tmsandbox.co.nz/v1/Search/General.json"
    
    func loadRoot(completion: @escaping (Root) -> Void){
        guard let url = URL(string: categoryBrowsingEndpoint) else {
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let categoriesData = data {
                let jsonData = try? JSONSerialization.jsonObject(with: categoriesData, options: .mutableContainers) as? [String:AnyHashable]
                if let name = jsonData?["Name"] as? String, let subcategories = jsonData?["Subcategories"] as? [[String:AnyHashable]] {
                    let root = Root(name: name, rawList: subcategories)
                    completion(root)
                }
            }
        }.resume()
    }
 
    func loadItemsForCategoryNumber(_ categoryNumber: String, completion: @escaping ([String:Any]) -> Void){
        guard let url = URL(string: "\(generalSearchEndpoint)?category=\(categoryNumber)") else {
            return
        }
        var request = URLRequest(url: url)
        request.addValue("OAuth oauth_consumer_key=\"\(consumerKey)\",oauth_signature_method=\"PLAINTEXT\",oauth_signature=\"\(secret)%26\"", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let categoriesData = data {
                if let jsonData = try? JSONSerialization.jsonObject(with: categoriesData, options: .mutableContainers) as? [String:Any] {
                    completion(jsonData)
                }else{
                    completion([:])
                }
            }
        }.resume()
    }
}
