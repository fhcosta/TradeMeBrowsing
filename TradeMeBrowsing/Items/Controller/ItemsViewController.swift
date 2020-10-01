//
//  ItemsViewController.swift
//  TradeMeBrowsing
//
//  Created by Flavio Costa on 30/09/20.
//

import UIKit

class ItemsViewController: UIViewController {
    
    //MARK: UI Components
    @IBOutlet var itemsCollectionView: UICollectionView!
    
    //MARK: Properties
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    var itemsViewModel: ItemsViewModel!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    init(category: Category){
        super.init(nibName: "ItemsViewController", bundle: nil)
        let itemsViewModel = ItemsViewModel(category: category)
        self.itemsViewModel = itemsViewModel
        title = category.name
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}


//MARK: CollectionView
extension ItemsViewController {
    
        func setupCollectionView(){
            itemsCollectionView.delegate = self
            itemsCollectionView.register(UINib(nibName: ItemCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ItemCollectionViewCell.reuseIdentifier)
            configureDataSource()
            updateCollectionView(animated: false)
        }
    
       func configureDataSource() {
            dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: itemsCollectionView) {
                (collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell? in
                if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.reuseIdentifier, for: indexPath) as? ItemCollectionViewCell  {
                    if let url = URL(string: item.image) {
                        itemCell.itemImageView.load(url: url)
                        
                    }else{
                        itemCell.itemImageView.image = UIImage(systemName: "photo")
                    }
                    
                    itemCell.itemTitleLabel.text = item.title
                    itemCell.itemIDLabel.text = "\(item.listingID)"
                    return itemCell
                }
                return UICollectionViewCell(frame: CGRect.zero)
            }
            
        }
    
        func updateCollectionView(animated: Bool) {
            var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
            snapshot.appendSections([.main])
            snapshot.appendItems(itemsViewModel.items)
            dataSource.apply(snapshot, animatingDifferences: animated)
        }
}


extension ItemsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }

}
