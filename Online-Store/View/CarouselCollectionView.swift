//
//  CarouselCollectionView.swift
//  RD Application
//
//  Created by Георгий Кашин on 04/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class CarouselCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Stored Properties
    var images = [UIImage]()
    var pageControl = UIPageControl()
    var isTimerUsed = false
    
    // MARK: - Initializers
    init(useTimer: Bool) {
        /// create layout
        let layout = UICollectionViewFlowLayout()
        /// setup layout
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        super.init(frame: .zero, collectionViewLayout: layout)
        isTimerUsed = useTimer
        /// configure collection view
        configureCollectionView()
        /// run timer for scrolling images
        if isTimerUsed { startTimerForScrolling() }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CollectionView Methods
extension CarouselCollectionView {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
}

// MARK: - ScrollView Methods
extension CarouselCollectionView {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        /// change page for manual scrolling
        pageControl.currentPage = Int(contentOffset.x / frame.width)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        /// change page for automatic scrolling
        pageControl.currentPage = Int(contentOffset.x / frame.width) % images.count
    }
    
    /// scroll to next cell
    @objc func scrollToNextCell() {
        scrollRectToVisible(CGRect(x: contentOffset.x + frame.width, y: contentOffset.y, width: frame.width, height: frame.height), animated: true)
    }
}

// MARK: - Setup CollectionView
extension CarouselCollectionView {
    /// configure collection view
    func configureCollectionView() {
        register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: CarouselCollectionViewCell.reuseIdentifier)
        delegate = self
        dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        backgroundColor = .white
        isScrollEnabled = false
        isPagingEnabled = true
    }
    
    /// Set images and page control for collection view
    ///
    /// - Parameters:
    ///   - images: array of images
    ///   - pageControl: instance of ImagePageControl class
    func setProperties(images: [UIImage], pageControl: UIPageControl) {
        self.pageControl = pageControl
        self.images = images
    }
    
    /// run timer for scrolling images
    func startTimerForScrolling() {
        _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(scrollToNextCell), userInfo: nil, repeats: true)
    }
}

// MARK: - CollectionViewDataSource Methods
extension CarouselCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isTimerUsed ? Int(Int16.max) : images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.reuseIdentifier, for: indexPath) as! CarouselCollectionViewCell
        cell.imageView.image = images[indexPath.row % images.count]
        
        return cell
    }
}
