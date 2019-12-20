//
//  SearchViewController.swift
//  RD Application
//
//  Created by Георгий Кашин on 17/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Stored Properties
    var productList = [Product]()
    var filteredProductList = [Product]()
    var alert = SizeSelectionAlert() 
    let searchController = UISearchController(searchResultsController: nil)
    lazy var gestureRecognizer = UITapGestureRecognizer()

    // MARK: - Computed Properties
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    /// property indicating whether content is filtered
    var isFiltered: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // MARK: - IB Outlets
    @IBOutlet weak var productCollection: UICollectionView!
}

// MARK: - IB Actions
extension SearchViewController {
    @IBAction func toCartButtonPressed(_ sender: UIButton) {
        /// configure alert with product
        let product = isFiltered ? filteredProductList[sender.tag] : productList[sender.tag]
        alert.configure(withProduct: product)
        /// add gesture recognizer to view
        navigationController?.view.addGestureRecognizer(gestureRecognizer)
        
        /// add subview to view
        view.addSubview(alert.blurEffectView)
        view.addSubview(alert)
        
        /// disable interaction with search and tab bar
        toggleUserInteraction()
    }
}

// MARK: - UIViewController Methods
extension SearchViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        /// load products from Realm to product list
//        StorageManager.loadData(to: &productList)
        /// setup user interface
        setupUI()
//        StorageManager.shared.fetchProducts() { products in
//            guard let products = products else { return }
//            self.updateUI(with: products)
//        }
        productList = StorageManager.shared.loadProducts(for: 0, and: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        /// add observer to perform close actions
        addObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        /// remove observer
        removeObserver()
    }
}

// MARK: - UI
extension SearchViewController {
    /// setup user interface
    func setupUI() {
        /// setup search controller
        setupSearchController()
        /// hide back bar button title
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        /// setup size selection alert
        setupAlert()
        /// setup tap gesture recognizer
        setupTapGestureRecognizer()
    }
    
    func updateUI(with products: [Product]) {
        productList = products
        DispatchQueue.main.async {
            self.productCollection.reloadData()
        }
    }
    
    /// setup size selection alert
    func setupAlert() {
        alert = Bundle.main.loadNibNamed("SizeSelectionAlert", owner: nil, options: nil)?.first as! SizeSelectionAlert
        alert.center = view.center
    }
    
    func addObserver() {
        /// add observer to setup alert closing
        NotificationCenter.default.addObserver(self, selector: #selector(performClosingActions), name: NSNotification.Name(rawValue: "performClosingActions"), object: nil)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "performClosingActions"), object: nil)
    }
    
    /// setup tap gesture recognizer
    func setupTapGestureRecognizer() {
        gestureRecognizer.addTarget(self, action: #selector(handleTap))
    }
    
    /// toggle user interaction with search and tab bar
    func toggleUserInteraction() {
        searchController.searchBar.isUserInteractionEnabled.toggle()
        tabBarController?.tabBar.isUserInteractionEnabled.toggle()
    }
    
    /// perform actions when alert is closed
    @objc func performClosingActions() {
        /// toggle user interaction with search and tab bar
        toggleUserInteraction()
        navigationController?.view.removeGestureRecognizer(gestureRecognizer)
    }
    
    /// close alert if tapped outside it
    @objc func handleTap() {
        let location = gestureRecognizer.location(in: alert)
        if !alert.point(inside: location, with: nil) {
            /// perform closing alert with animation
            alert.animatedClose()
        }
    }
}

// MARK: - Setup SearchController
extension SearchViewController {
    /// setup search controller
    func setupSearchController() {
        /// search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Что бы Вы хотели..?"
//        searchController.searchBar.setValue("Отмена", forKey: "_cancelButtonText")
        searchController.searchBar.tintColor = .black
        /// navigation item
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        
        definesPresentationContext = true
    }
}

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentBySearchText(searchController.searchBar.text!)
    }
    /// Filter content by text in the search bar
    ///
    /// - Parameter searchText: search bar text
    func filterContentBySearchText(_ searchText: String) {
        filteredProductList = productList.filter({ (product) -> Bool in
            return product.name.lowercased().contains(searchText.lowercased())
        })
        productCollection.reloadData()
    }
}

// MARK: - UICollectionView Data Source
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltered ? filteredProductList.count : productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        let product = isFiltered ? filteredProductList[indexPath.row] : productList[indexPath.row]
        /// configure cell with product
        cell.configure(with: product, at: indexPath)
        return cell
    }
}

// MARK: - Navigation
extension SearchViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toProductDetailSegue" else { return }
        guard let destination = segue.destination as? ProductDetailViewController else { return }
        guard let indexPath = productCollection.indexPathsForSelectedItems?.first else { return }
        /// pass selected product to ProductDetailViewController
        let product = isFiltered ? filteredProductList[indexPath.row] : productList[indexPath.row]
        destination.product = product
    }
}
