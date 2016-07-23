//
//  ViewController.swift
//  FoodTracker
//
//  Created by Sean Lin on 22/07/2016.
//  Copyright © 2016 DiUS. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

	// MARK: Properties
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var nameLabel: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()
		nameTextField.delegate = self
	}

	// MARK: UITextFieldDelegate
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}

	func textFieldDidEndEditing(textField: UITextField) {
		nameLabel.text = textField.text
	}

	// MARK: Actions
	@IBAction func setDefaultLabelText(sender: UIButton) {
		nameLabel.text = "Default Text"
	}

}

