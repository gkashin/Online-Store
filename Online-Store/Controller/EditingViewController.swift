//
//  EditingViewController.swift
//  RD Application
//
//  Created by Георгий Кашин on 09/07/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class EditingViewController: UIViewController {

    // MARK: - Stored Properties
    var profile = Profile()
    
    // MARK: - IB Outlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet var textFieldCollection: [UITextField]!
    
    // MARK: - IB Actions
    @IBAction func exitButtonPressed() {
        dismiss(animated: true)
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        /// set value to profile for key depending on text field
        let textFieldIndex = textFieldCollection.firstIndex(of: sender)!
        let key = profile.keys[textFieldIndex]
        let text = sender.text ?? ""
        profile.setValue(text, forKey: key)
    }
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        /// setup user interface
        setupUI()
        /// add observers for appearance and hiding keyboard
        registerForKeyboardNotifications()
        /// add tap gesture recognizer to hide keyboard when tapped outside it
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
    }
}

// MARK: - UI
extension EditingViewController {
    /// setup user interface
    func setupUI() {
        /// setup appearance of interface elements
        setupInterfaceElements()
        /// update text fields text with current profile
        updateTextFields()
    }
    
    /// update text fields text with current profile properties
    func updateTextFields() {
        for (index, textField) in textFieldCollection.enumerated() {
            textField.text = profile.values[index] as? String
        }
    }
    
    /// setup appearance of interface elements
    func setupInterfaceElements() {
        contentView.layer.cornerRadius = 8
        saveButton.layer.cornerRadius = 8
    }
}

// MARK: - Keyboard
extension EditingViewController {
    /// add observers for appearance and hiding keyboard
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardDidShow(_ notification: NSNotification) {
        guard let info = notification.userInfo else { return }
        guard let keyboardFrameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        /// add edge insets to scroll view
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets
    }
    
    @objc func keyboardWillHide() {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
    }
}

// MARK: - UITextFieldDelegate
extension EditingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let textFieldIndex = textFieldCollection.firstIndex(of: textField)!
        /// pass to next text field if it is not last one, else save changes
        if textFieldCollection[textFieldIndex] != textFieldCollection.last {
            textFieldCollection[textFieldIndex + 1].becomeFirstResponder()
        } else {
            performSegue(withIdentifier: "toOfficeSegue", sender: nil)
        }
        return true
    }
}
