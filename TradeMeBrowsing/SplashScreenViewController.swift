//
//  SplashScreenViewController.swift
//  TradeMeBrowsing
//
//  Created by Flavio Costa on 30/09/20.
//

import UIKit



class SplashScreenViewController: UIViewController {
    var activityIndicatorView = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setupActivityIndicator()
        setupBottomContent()
        preloadCategories()
    }
    
    //MARK: Activity Indicator
    private func setupActivityIndicator(){
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.startAnimating()
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setupBottomContent(){
        let label = UILabel()
        label.text = "Flavio Costa\niOS Developer"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        
        let constraints = [
            label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            label.heightAnchor.constraint(equalToConstant: 200)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func removeActivityIndicator(){
        activityIndicatorView.stopAnimating()
        activityIndicatorView.removeFromSuperview()
    }
    
    private func preloadCategories(){
        let categories = Categories()
        categories.loadCategories {
            self.goToCategoriesList(categoriesViewModel: CategoriesViewModel(categories: categories.categoriesList))
        }
    }
    
    private func goToCategoriesList(categoriesViewModel: CategoriesViewModel){
        DispatchQueue.main.async {
            self.removeActivityIndicator()
            let navigationController = UINavigationController(rootViewController: CategoriesViewController(categoriesViewModel: categoriesViewModel))
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: false, completion: nil)
        }
    }
    
    
}
