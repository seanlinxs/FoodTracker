//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Sean Lin on 22/07/2016.
//  Copyright © 2016 DiUS. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	// MARK: Properties
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var photoImageView: UIImageView!
	@IBOutlet weak var ratingControl: RatingControl!
	@IBOutlet weak var saveButton: UIBarButtonItem!

	var meal: Meal?

	override func viewDidLoad() {
		super.viewDidLoad()
		nameTextField.delegate = self
		checkValidMealName()
	}

	// MARK: UITextFieldDelegate
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}

	func textFieldDidBeginEditing(textField: UITextField) {
		saveButton.enabled = false
	}

	func checkValidMealName() {
		let text = nameTextField.text ?? ""
		saveButton.enabled = !text.isEmpty
	}

	func textFieldDidEndEditing(textField: UITextField) {
		checkValidMealName()
		navigationItem.title = nameTextField.text
	}

	// MARK: UIImagePickerControllerDelegate
	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		dismissViewControllerAnimated(true, completion: nil)
	}

	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
		let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
		photoImageView.image = selectedImage
		dismissViewControllerAnimated(true, completion: nil)
	}

	// MARK: Navigation
	@IBAction func cancel(sender: UIBarButtonItem) {
		dismissViewControllerAnimated(true, completion: nil)
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if saveButton === sender {
			let name = nameTextField.text ?? ""
			let photo = photoImageView.image
			let rating = ratingControl.rating

			meal = Meal(name: name, rating: rating, photo: photo)
		}
	}

	// MARK: Actions
	@IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
		nameTextField.resignFirstResponder()
		let imagePickerController = UIImagePickerController()
		imagePickerController.sourceType = .PhotoLibrary
		imagePickerController.delegate = self
		presentViewController(imagePickerController, animated: true, completion: nil)
	}

}

