//
//  ProductDetailViewController.swift
//  RD Application
//
//  Created by Георгий Кашин on 13/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    var images = [UIImage]()
    
    // MARK: - Stored Properties
    let productImageCollectionView = CarouselCollectionView(useTimer: false)
    let sizeSelectionAlert = SizeSelectionAlert()
    var product = Product()
    var sizeButtonsStackView = SizeButtonsStackView()
    lazy var imagePageControl = ImagePageControl(numberOfPages: product.image.count)
    
    // MARK: - IB Outlets
    @IBOutlet var imageViewCollection: [UIImageView]!
    @IBOutlet weak var imageViewCollectionStackView: UIStackView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var sizeView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var compositionLabel: UILabel!
    @IBOutlet weak var sizeTableLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var toCartButton: UIButton!
}

// MARK: - IB Actions
extension ProductDetailViewController {
    @IBAction func segmentedControlSwitched() {
        /// setup label concealment
        descriptionLabel.isHidden.toggle()
        compositionLabel.isHidden.toggle()
    }
    
    @IBAction func toCartButtonPressed() {
        /// add product to cart
        sizeButtonsStackView.addToCart()
    }
}

// MARK: - UIViewController Methods
extension ProductDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for url in product.imageURLs {
//            StorageManager.shared.fetchImage(url: url) { image in
//                guard let image = image else { return }
//                self.images.append(image)
//            }
//        }
        
        for image in product.image {
            self.images.append(UIImage(named: image)!)
        }
        
        DispatchQueue.main.async {
            /// setup user interface
            self.setupUI()
            /// pass images and page control to CarouselCollectionView class
            self.passData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        /// update toCartButton if size button is selected
        if sizeButtonsStackView.selectedSize != nil { updateToCartButton() }
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateToCartButton), name: NSNotification.Name(rawValue: "updateToCartButton"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "updateToCartButton"), object: nil)
    }
}

// MARK: - Setup UI
extension ProductDetailViewController {
    /// setup user interface
    func setupUI() {
        /// add views to content view
        addViews()
        /// constrain views
        constrainViews()
        /// customize interface elements
        customizeInterfaceElements()
        /// configure size buttons stack view with product
        sizeButtonsStackView.configure(withProduct: product)
    }
    
    @objc func updateToCartButton() {
        toCartButton.setTitle("В корзину", for: .normal)
        toCartButton.isEnabled = true
    }
    
    /// add views to content view
    func addViews() {
        /// add product collection view to stack view of image views
        imageViewCollectionStackView.insertArrangedSubview(productImageCollectionView, at: 0)
        /// add page control
        contentView.addSubview(imagePageControl)
        /// add size buttons stack view
        sizeView.addSubview(sizeButtonsStackView.scrollView)
    }
    
    /// constrain views
    func constrainViews() {
        NSLayoutConstraint.activate([
            /// constrain collection view
            productImageCollectionView.widthAnchor.constraint(equalToConstant: view.frame.size.width * 0.66),
            productImageCollectionView.heightAnchor.constraint(equalToConstant: view.frame.size.height * 0.45),
            /// constrain page control
            imagePageControl.bottomAnchor.constraint(equalTo: productImageCollectionView.bottomAnchor),
            imagePageControl.centerXAnchor.constraint(equalTo: productImageCollectionView.centerXAnchor),
            /// constrain size view
            sizeView.topAnchor.constraint(equalTo: productImageCollectionView.bottomAnchor, constant: 10),
            /// constrain size buttons stack view
            sizeButtonsStackView.scrollView.topAnchor.constraint(equalTo: sizeTableLabel.bottomAnchor, constant: 8),
            sizeButtonsStackView.scrollView.leadingAnchor.constraint(equalTo: sizeView.leadingAnchor, constant: 16),
            sizeButtonsStackView.scrollView.trailingAnchor.constraint(equalTo: sizeView.trailingAnchor, constant: -16),
            sizeButtonsStackView.scrollView.heightAnchor.constraint(equalToConstant: 30),
            /// constrain labels
            priceLabel.topAnchor.constraint(equalTo: sizeView.bottomAnchor, constant: 8),
        ])
    }
    
    /// customize interface elements
    func customizeInterfaceElements() {
        title = product.name
        priceLabel.text = "\(product.price.separatedNumber()) ₽"
        descriptionLabel.text = product.specification
        compositionLabel.text = product.composition
        toCartButton.layer.cornerRadius = 8
        /// configure collection view
        productImageCollectionView.isScrollEnabled = true
        productImageCollectionView.layer.cornerRadius = 5
        /// add borders to size view
        addBordersToSizeView()
        /// setup image views
        setupImageViews()
    }
    
    /// add top and bottom borders to size view
    func addBordersToSizeView() {
        sizeView.addBorder(to: .top, with: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), thickness: 1)
        sizeView.addBorder(to: .bottom, with: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), thickness: 1)
    }
    
    /// setup image views appearance
    func setupImageViews() {
//        print(imageViewCollection.count)
//        StorageManager.shared.fetchImage(url: product.imageURLs.first!) { image in
//            DispatchQueue.main.async {
//                self.imageViewCollection[1].image = image
//            }
//        }
        
        for (index, imageView) in imageViewCollection.enumerated() {
            imageView.layer.cornerRadius = 5
            imageView.clipsToBounds = true
//            StorageManager.shared.fetchImage(url: product.imageURLs[index + 1]) { image in
//                guard let image = image else { return }
//                DispatchQueue.main.async {
//                    imageView.image = image
//                }
//            }
            imageView.image = self.images[safe: index + 1]
//            print(imageViewCollection.count)
//            imageView.image = UIImage(named: "allMen")
        }
    }
}

// MARK: - Pass Data
extension ProductDetailViewController {
    /// pass data to CarouselCollectionView class
    func passData() {
        /// create array of images using product image data
//        var productImages = [UIImage]()
//        for imageData in product.imageData {
//            guard let image = UIImage(data: imageData) else { continue }
//            productImages.append(image)
//        }
        
//        for imageURL in product.imageURLs {
//            StorageManager.shared.fetchImage(url: imageURL) { image in
//                guard let image = image else { return }
//                productImages.append(image)
//            }
//        }
        
        self.productImageCollectionView.setProperties(images: images, pageControl: imagePageControl)
    }
}
