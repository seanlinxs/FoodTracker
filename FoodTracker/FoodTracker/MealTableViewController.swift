//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Sean Lin on 26/07/2016.
//  Copyright © 2016 DiUS. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {

	// MARK: Properties

	var meals = [Meal]()

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.leftBarButtonItem = editButtonItem()
		loadSampleMeals()
	}

	func loadSampleMeals() {
		let photo1 = UIImage(named: "meal1")!
		let meal1 = Meal(name: "Caprese Salad", rating: 5, photo: photo1)!

		let photo2 = UIImage(named: "meal2")!
		let meal2 = Meal(name: "Chicken and Potatoes", rating: 3, photo: photo2)!

		let photo3 = UIImage(named: "meal3")!
		let meal3 = Meal(name: "Pasta with Meatballs", rating: 2, photo: photo3)!

		meals += [meal1, meal2, meal3]
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// MARK: - Table view data source

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return meals.count
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("MealTableViewCell", forIndexPath: indexPath) as! MealTableViewCell
		let meal = meals[indexPath.row]

		cell.nameLabel.text = meal.name
		cell.ratingControl.rating = meal.rating
		cell.photoImageView.image = meal.photo

		return cell
	}

	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		if editingStyle == .Delete {
			meals.removeAtIndex(indexPath.row)
			tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
		}
		else if editingStyle == .Insert {

		}
	}

	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		return true
	}

	// MARK: Navigation

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "ShowDetail" {
			let mealViewController = segue.destinationViewController as! MealViewController
			if let selectedMealCell = sender as? MealTableViewCell {
				let indexPath = tableView.indexPathForCell(selectedMealCell)
				let selectedMeal = meals[indexPath!.row]
				mealViewController.meal = selectedMeal
			}
		}
		else if segue.identifier == "AddItem" {
			print("Adding new meal.")
		}
	}

	@IBAction func unwindToMealList(sender: UIStoryboardSegue) {
		if let sourceViewController = sender.sourceViewController as? MealViewController, meal = sourceViewController.meal {
			if let selectedIndexPath = tableView.indexPathForSelectedRow {
				meals[selectedIndexPath.row] = meal
				tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
			}
			else {
				let newIndexPath = NSIndexPath(forRow: meals.count, inSection: 0)
				meals.append(meal)
				tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
			}
		}
	}
}
