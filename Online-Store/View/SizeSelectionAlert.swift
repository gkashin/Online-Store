//
//  SizeSelectionAlert.swift
//  RD Application
//
//  Created by Георгий Кашин on 22/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class SizeSelectionAlert: UIView {
    
    // MARK: - Stored Properties
    var blurEffectView = UIVisualEffectView()
    var sizeButtonsStackView: SizeButtonsStackView!
    
    // MARK: - UIView Methods
    override func awakeFromNib() {
        /// setup user interface
        setupUI()
    }
}

// MARK: - UI
extension SizeSelectionAlert {
    /// setup user interface
    func setupUI() {
        /// setup blur effect view
        setupBlurEffectView()
        /// setup alert appearance
        layer.cornerRadius = 10
    }
    
    /// Configure alert with product
    ///
    /// - Parameter product: selected product
    func configure(withProduct product: Product) {
        /// create stack view for size buttons
        sizeButtonsStackView = SizeButtonsStackView()
        sizeButtonsStackView.configure(withProduct: product)
        
        /// remove old stack view from alert if exists
        let oldStackView = viewWithTag(sizeButtonsStackView.tag)
        oldStackView?.removeFromSuperview()
        
        /// add size buttons stack view to alert
        addSubview(sizeButtonsStackView.scrollView)
        /// constrain stack view
        sizeButtonsStackView.scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        sizeButtonsStackView.scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        sizeButtonsStackView.scrollView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        sizeButtonsStackView.scrollView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        /// setup open animation
        animatedOpen()
    }
    
    /// setup opening animation
    func animatedOpen() {
        alpha = 0
        blurEffectView.alpha = 0
        
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1
            self.blurEffectView.alpha = 1
        }
        /// add observer for alert closing with animation
        NotificationCenter.default.addObserver(self, selector: #selector(animatedClose), name: NSNotification.Name("animatedClose"), object: nil)
    }
    
    /// close alert with animation
    @objc func animatedClose() {
        /// setup animation
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
            self.blurEffectView.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
        /// post notification to setup UX after closing
        NotificationCenter.default.post(name: NSNotification.Name("performClosingActions"), object: nil)
        /// remove observer
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "animatedClose"), object: nil)
    }
    
    /// setup blur effect view
    func setupBlurEffectView() {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = UIScreen.main.bounds
    }
}
