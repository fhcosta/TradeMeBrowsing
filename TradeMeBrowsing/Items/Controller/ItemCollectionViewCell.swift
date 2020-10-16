//
//  ItemCollectionViewCell.swift
//  TradeMeBrowsing
//
//  Created by Flavio Costa on 2/10/20.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    //MARK: Properties
    static let reuseIdentifier = "ItemCollectionViewCell"
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var itemTitleLabel: UILabel!
    @IBOutlet var itemIDLabel: UILabel!
    @IBOutlet var containerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        itemImageView.image = UIImage(systemName: "photo")
        itemTitleLabel.text = ""
        itemIDLabel.text = ""
    }

}
