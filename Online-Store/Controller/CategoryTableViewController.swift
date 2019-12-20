//
//  CategoryTableViewController.swift
//  RD Application
//
//  Created by Георгий Кашин on 08/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    // MARK: - Stored Properties
    var subcategories = [Subcategory]()
//    var subcategories = [String]()
    var pressedButton: UIButton!
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        /// setup user interface
        setupUI()
        subcategories = StorageManager.shared.loadSubcategories(for: pressedButton.tag)
//        StorageManager.shared.fetchSubcategories(for: pressedButton.tag) { subcategories in
//            guard let subcategories = subcategories else { return }
//            self.updateUI(with: subcategories)
//        }
    }
}

// MARK: - UI
extension CategoryTableViewController {
    /// setup user interface
    func setupUI() {
        self.title = self.pressedButton.titleLabel?.text
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 0))
        /// hide back bar button title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func updateUI(with subcategories: [Subcategory]) {
        self.subcategories = subcategories
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Navigation
extension CategoryTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toProductSegue" else { return }
        guard let destination = segue.destination as? ProductViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        /// pass data to ProductViewController
        // let category = Category.englishNotationName[pressedButton.tag][indexPath.row]
//        let title = subcategories[indexPath.row]
        destination.title = subcategories[indexPath.row].name
        destination.category = pressedButton.tag
        destination.subcategory = indexPath.row + 1
//        destination.title = title
    }
}

// MARK: - UITableViewDataSource
extension CategoryTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subcategories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
        let title = subcategories[indexPath.row].name
//        let imageName = Category.englishNotationName[pressedButton.tag][indexPath.row]
        //        guard let image = UIImage(named: imageName) else { return cell }
        let image = UIImage(named: subcategories[indexPath.row].image)!
//        let imageURL = subcategories[indexPath.row].imageURL
        
        cell.configure(with: image, titled: title)
//        StorageManager.shared.fetchImage(url: imageURL) { image in
//            guard let image = image else { return }
//            DispatchQueue.main.async {
//                /// configure cell with image and title
//                cell.configure(with: image, titled: title)
//            }
//        }
        return cell
    }
}
