//
//  ProductViewController.swift
//  RD Application
//
//  Created by Георгий Кашин on 10/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    
    // MARK: - Stored Properties
    var productList = [Product]()
    /// current subcategory
//    var subcategory: Subcategory!
    /// alerts
    var sortingAlert = UIAlertController()
    var sizeSelectionAlert = SizeSelectionAlert()
    /// gesture recognizer
    lazy var gestureRecognizer = UITapGestureRecognizer()
    
    var category: Int!
    var subcategory: Int!

    // MARK: - IB Outlets
    @IBOutlet weak var productCollection: UICollectionView!
    @IBOutlet weak var sortingButton: UIButton!
}

// MARK: - IB Actions
extension ProductViewController {
    @IBAction func sortingButtonPressed() {
        present(sortingAlert, animated: true)
    }
    
    @IBAction func toCartButtonPressed(_ sender: UIButton) {
        /// configure alert with selected product
        let product = productList[sender.tag]
        sizeSelectionAlert.configure(withProduct: product)
        /// add gesture recognizer to view
        navigationController?.view.addGestureRecognizer(gestureRecognizer)
        
        /// add subview to view
        view.addSubview(sizeSelectionAlert.blurEffectView)
        view.addSubview(sizeSelectionAlert)
        
        /// disable interaction with tab bar
        toggleUserInteraction()
    }
}

// MARK: - UIViewController Methods
extension ProductViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        productCollection.dataSource = self
        /// load products from Realm to product list
//        StorageManager.loadData(to: &productList, with: category)
        /// setup user interface
        setupUI()
        
//        StorageManager.shared.fetchProducts(forCategory: category, andSubcategory: subcategory) { products in
//            guard let products = products else { return }
//            self.updateUI(with: products)
//        }
        productList = StorageManager.shared.loadProducts(for: category, and: subcategory)
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
extension ProductViewController {
    /// setup user interface
    func setupUI() {
//        title = subcategory.name
        /// setup alert
        sortingAlert = setupSortingAlert()
        /// add bottom border to sortingButton button
        sortingButton.addBorder(to: .bottom, with: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), thickness: 1)
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
    
    func addObserver() {
        /// add observer to setup alert closing
        NotificationCenter.default.addObserver(self, selector: #selector(performClosingActions), name: NSNotification.Name(rawValue: "performClosingActions"), object: nil)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "performClosingActions"), object: nil)
    }
    
    /// Setup sorting alert with picker view
    ///
    /// - Returns: alert with picker view
    func setupSortingAlert() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let sortingPicker = UIPickerView(frame: CGRect(x: 0, y: 0, width: alert.view.frame.size.width - 15, height: 150))
        sortingPicker.dataSource = self
        sortingPicker.delegate = self
        
        let doneAction = UIAlertAction(title: "Готово", style: .cancel) { [unowned self] _ in
            let selectedRow = sortingPicker.selectedRow(inComponent: 0)
            /// set title for sorting button
            let title = SortingVariations.allCases[selectedRow].rawValue
            self.sortingButton.setTitle("    \(title)", for: .normal)
            /// reload collection view
            self.productCollection.reloadData()
        }
        alert.addAction(doneAction)
        alert.view.addSubview(sortingPicker)
        /// add height constraint for alert
        alert.view.heightAnchor.constraint(equalToConstant: sortingPicker.frame.size.height + 55).isActive = true
        
        return alert
    }
    
    /// setup size selection alert
    func setupAlert() {
        sizeSelectionAlert = Bundle.main.loadNibNamed("SizeSelectionAlert", owner: nil, options: nil)?.first as! SizeSelectionAlert
        sizeSelectionAlert.center = view.center
    }
    
    /// setup tap gesture recognizer
    func setupTapGestureRecognizer() {
        gestureRecognizer.addTarget(self, action: #selector(handleTap))
    }
    
    /// toggle user interaction with tab bar
    func toggleUserInteraction() {
        tabBarController?.tabBar.isUserInteractionEnabled.toggle()
    }
    
    /// perform actions when alert is closed
    @objc func performClosingActions() {
        /// toggle user interaction with tab bar
        toggleUserInteraction()
        navigationController?.view.removeGestureRecognizer(gestureRecognizer)
    }
    
    /// close alert if tapped outside it
    @objc func handleTap() {
        let location = gestureRecognizer.location(in: sizeSelectionAlert)
        if !sizeSelectionAlert.point(inside: location, with: nil) {
            /// perform closing alert with animation
            sizeSelectionAlert.animatedClose()
        }
    }
}

// MARK: - Navigation
extension ProductViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toProductDetailSegue" else { return }
        guard let destination = segue.destination as? ProductDetailViewController else { return }
        guard let indexPath = productCollection.indexPathsForSelectedItems?.first else { return }
        /// pass selected product to ProductDetailViewController
        destination.product = productList[indexPath.row]
    }
}

// MARK: - UICollectionViewDataSource
extension ProductViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        let product = productList[indexPath.row]
        /// configure cell with product at index path
        cell.configure(with: product, at: indexPath)
        return cell
    }
}

// MARK: - UIPickerViewDataSource
extension ProductViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SortingVariations.allCases.count
    }
}

// MARK: - UIPickerViewDelegate
extension ProductViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return SortingVariations.allCases[row].rawValue
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        /// sort according to the selected row
        switch row {
        case 0:
            productList = productList.sorted { $0.date > $1.date }
        case 1:
            productList = productList.sorted { $0.price < $1.price }
        case 2:
            productList = productList.sorted { $0.price > $1.price }
        default:
            break
        }
    }
}
