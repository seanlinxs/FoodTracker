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

	override func tearDown() {
		let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "MyInMemoryRealm"))

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
		let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "MyInMemoryRealm"))

		try! realm.write {
			realm.create(MealStorageObject.self, value: MealStorageObject(value: [
				"name": "Vegetable Noodle",
				"rating": 5,
				"ingredients": [
					["Noodle", "g", 100.0],
					["Vegitables", "g", 200.0]
				]
				]), update: true)
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
			//theNoodle?.name = "Rice Noodle"
			theNoodle?.setValue("Rice Noodle", forKey: "name")
		}

		let theSameMeals = realm.objects(MealStorageObject.self)
		expect(theSameMeals.first?.ingredients.first?.name).to(equal("Rice Noodle"))

		try! realm.write {
			realm.delete(theSameMeals)
		}

		// load again
		let noMeals = realm.objects(MealStorageObject.self)
		expect(noMeals).notTo(beNil())
		expect(noMeals.count).to(equal(0))
	}

	func testQueries() {
		let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "MyInMemoryRealm"))

		try! realm.write {
			realm.create(MealStorageObject.self, value:
				MealStorageObject(value: ["name": "Meal One", "rating": 2, "ingredients": [["Ingredient One", "ml", 100.0]]]), update: true)
			realm.create(MealStorageObject.self, value:
				MealStorageObject(value: ["name": "Meal Two", "rating": 4, "ingredients": [["Ingredient Two", "g", 1000.0]]]), update: true)
		}

		let meals = realm.objects(MealStorageObject.self)
		expect(meals).notTo(beNil())
		expect(meals.count).to(equal(2))

		// Test query using predicate string
		let mealOne = meals.filter("name = 'Meal One' AND rating = 2")
		expect(mealOne).notTo(beNil())
		expect(mealOne.count).to(equal(1))
		expect(mealOne.first?.name).to(equal("Meal One"))

		// Test query using NSPredicate
		let predicate = NSPredicate(format: "name = %@ AND rating = %i", "Meal Two", 4)
		let mealTwo = meals.filter(predicate)
		expect(mealTwo).notTo(beNil())
		expect(mealTwo.count).to(equal(1))
		expect(mealTwo.first?.name).to(equal("Meal Two"))
	}

	func testSorting() {
		let meal1 = MealStorageObject(value: ["name": "meal1", "rating": 2])
		let meal2 = MealStorageObject(value: ["name": "meal2", "rating": 2])
		let meal3 = MealStorageObject(value: ["name": "meal11","rating": 5])

		let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "MyInMemoryRealm"))
		try! realm.write {
			realm.add(meal1)
			realm.add(meal2)
			realm.add(meal3)
		}

		// Single sorting field
		let sortedMealsOne = realm.objects(MealStorageObject.self).sorted("name", ascending: true)
		expect(sortedMealsOne).notTo(beNil())
		expect(sortedMealsOne.count).to(equal(3))
		expect(sortedMealsOne[0].name).to(equal("meal1"))
		expect(sortedMealsOne[1].name).to(equal("meal11"))
		expect(sortedMealsOne[2].name).to(equal("meal2"))

		// Sorting chain
		let sortingProperties = [SortDescriptor(property: "rating", ascending: true), SortDescriptor(property: "name", ascending: true)]
		let sortedMealsTwo = realm.objects(MealStorageObject.self).sorted(sortingProperties)
		expect(sortedMealsTwo).notTo(beNil())
		expect(sortedMealsTwo.count).to(equal(3))
		expect(sortedMealsTwo[0].name).to(equal("meal1"))
		expect(sortedMealsTwo[1].name).to(equal("meal2"))
		expect(sortedMealsTwo[2].name).to(equal("meal11"))
	}
}
