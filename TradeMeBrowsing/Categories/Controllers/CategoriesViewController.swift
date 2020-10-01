//
//  CategoriesViewController.swift
//  TradeMeBrowsing
//
//  Created by Flavio Costa on 29/09/20.
//

import UIKit

enum Section: CaseIterable {
    case main
}

class CategoriesViewController: UIViewController {
    
    //MARK: UI Components
    @IBOutlet var categoriesCollectionView: UICollectionView!
    
    //MARK: Properties
    var dataSource: UICollectionViewDiffableDataSource<Section, Category>!
    var categoriesViewModel: CategoriesViewModel!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TM Categories"
        setupCollectionView()
    }
    
    init(categoriesViewModel: CategoriesViewModel){
        super.init(nibName: "CategoriesViewController", bundle: nil)
        self.categoriesViewModel = categoriesViewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}


//MARK: CollectionView
extension CategoriesViewController {
    
    func setupCollectionView(){
        categoriesCollectionView.delegate = self
        categoriesCollectionView.register(UINib(nibName: CategoryCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier)
        configureDataSource()
        updateCollectionView(animated: false)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Category>(collectionView: categoriesCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, category: Category) -> UICollectionViewCell? in
            if let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier, for: indexPath) as? CategoryCollectionViewCell {
                categoryCell.categoryNameLabel.text = category.name
                if let totalCount = category.totalCount {
                    if(category.items.count <= 20){
                        categoryCell.categoryTotalCount.text = "\(totalCount)"
                    }else{
                        categoryCell.categoryTotalCount.text = "20"
                    }
                }
                
                return categoryCell
            }
            return UICollectionViewCell(frame: CGRect.zero)
        }
        
    }
    
    func updateCollectionView(animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Category>()
        snapshot.appendSections([.main])
        snapshot.appendItems(categoriesViewModel.categories)
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
}

extension CategoriesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let category = dataSource.itemIdentifier(for: indexPath) {
            let itemsViewController = ItemsViewController(category: category)
            self.navigationController?.pushViewController(itemsViewController, animated: true)
            
        }
    }
}

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
}
