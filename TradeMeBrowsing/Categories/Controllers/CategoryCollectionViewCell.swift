//
//  CategoryCollectionViewCell.swift
//  TradeMeBrowsing
//
//  Created by Flavio Costa on 30/09/20.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    //MARK: Properties
    static let reuseIdentifier = "CategoryCollectionViewCell"
    
    //MARK: IBOutlets
    @IBOutlet var categoryNameLabel: UILabel!
    @IBOutlet var categoryTotalCount: UILabel!
    @IBOutlet var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 10
    }

}
