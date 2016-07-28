//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Sean Lin on 22/07/2016.
//  Copyright © 2016 DiUS. All rights reserved.
//

import Nimble
import XCTest
import RealmSwift
@testable import FoodTracker

class FoodTrackerSpec: XCTestCase {

	let realm = try! Realm()

	override func setUp() {
		print("Realm Location:", realm.configuration.fileURL)
	}

	override func tearDown() {
		try! realm.write {
			realm.deleteAll()
		}
	}

	func testMealInitialization() {
		let potentialItem = Meal(name: "Newest meal", rating: 5, photo: nil)
		expect(potentialItem).notTo(beNil())
		let noName = Meal(name: "", rating: 5, photo: nil)
		expect(noName).to(beNil())
		let badRating = Meal(name: "Really bad rating", rating: -1, photo: nil)
		expect(badRating).to(beNil())
	}

	func testMealStorageObjects() {
		let realm = try! Realm()
		let noodle = Ingredient(value: ["name": "Noodle", "unit": "g", "quantity": 100.0])
		let vegetables = Ingredient(value: ["name": "Vegitables", "unit": "g", "quantity": 200.0])
		let vegetableNoodle = MealStorageObject()
		vegetableNoodle.name = "Vegetable Noodle"
		vegetableNoodle.rating = 5
		vegetableNoodle.photo = nil
		vegetableNoodle.ingredients.appendContentsOf([noodle, vegetables])

		try! realm.write {
			realm.add(vegetableNoodle)
		}

		let meals = realm.objects(MealStorageObject.self)

		expect(meals).notTo(beNil())
		expect(meals.count).to(equal(1))

		let theMeal = meals.first
		expect(theMeal).notTo(beNil())
		expect(theMeal?.name ).to(equal("Vegetable Noodle"))

		let ingredients = theMeal?.ingredients
		expect(ingredients).notTo(beNil())
		expect(ingredients?.count).to(equal(2))

		let theNoodle = ingredients?.first
		expect(theNoodle).notTo(beNil())
		expect(theNoodle?.name).to(equal("Noodle"))

		// update and load again
		try! realm.write {
			theNoodle?.name = "Rice Noodle"
		}

		let theSameMeals = realm.objects(MealStorageObject.self)
		expect(theSameMeals.first?.ingredients.first?.name).to(equal("Rice Noodle"))
	}
}
