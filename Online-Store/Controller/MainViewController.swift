//
//  MainViewController.swift
//  RD Application
//
//  Created by Георгий Кашин on 03/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var categoryButtonsCollection: [UIButton]!
    
    // MARK: - Stored Properties
    let newsCollectionView = CarouselCollectionView(useTimer: true)
    let newsPageControl = ImagePageControl(numberOfPages: NewsImage.allCases.count)
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        /// setup user interface
        setupUI()
        /// pass data to NewsCollectionView class
        newsCollectionView.setProperties(images: NewsImage.fetchImages(), pageControl: newsPageControl)
    }
}

// MARK: - IB Actions
extension MainViewController {
    @IBAction func categoryButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toCategorySegue", sender: sender)
    }
}

// MARK: - Setup Appearance
extension MainViewController {
    /// setup user interface
    func setupUI() {
        addNavigationTitleImageView()
        addCollectionView()
        addPageControl()
        configureButtonsAppearance()
        configureNavigationBackButton()
    }
    
    /// add navigation title image view
    func addNavigationTitleImageView() {
        /// create container for image view
        let containerImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: TitleImageViewConstants.width, height: TitleImageViewConstants.height))

        let titleImage = UIImage(named: TitleImageViewConstants.imageName)
        let titleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: TitleImageViewConstants.width, height: TitleImageViewConstants.height))
    
        /// configure image view
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.image = titleImage
        
        /// add title view with container image view
        containerImageView.addSubview(titleImageView)
        navigationItem.titleView = containerImageView
    }
    
    /// configure navigation back button
    func configureNavigationBackButton() {
        /// hide back bar button title
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    /// add buttons background
    func configureButtonsAppearance() {
        for button in categoryButtonsCollection {
            button.layer.cornerRadius = 10
            button.imageView?.contentMode  = .scaleAspectFit
            button.subviews.first?.contentMode = .scaleAspectFill
            button.clipsToBounds = true
        }
    }
    
    /// add page control
    func addPageControl() {
        view.addSubview(newsPageControl)
        /// constrain page control
        newsPageControl.bottomAnchor.constraint(equalTo: newsCollectionView.bottomAnchor).isActive = true
        newsPageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    /// add collection view
    func addCollectionView() {
        view.addSubview(newsCollectionView)
        
        /// constrain collection view
        newsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        newsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        newsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        newsCollectionView.heightAnchor.constraint(equalToConstant: view.frame.size.height * 0.4).isActive = true
    }
}

// MARK: - Navigation
extension MainViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toCategorySegue" else { return }
        guard let destination = segue.destination as? CategoryTableViewController else { return }
        guard let button = sender as? UIButton else { return }
        /// pass data to CategoryTableViewController
        destination.pressedButton = button
    }
}
