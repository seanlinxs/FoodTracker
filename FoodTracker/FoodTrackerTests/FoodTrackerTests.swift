//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Sean Lin on 22/07/2016.
//  Copyright © 2016 DiUS. All rights reserved.
//

import Nimble
import XCTest
@testable import FoodTracker

class FoodTrackerSpec: XCTestCase {

	func testMealInitialization() {
		let potentialItem = Meal(name: "Newest meal", rating: 5, photo: nil)
		expect(potentialItem).notTo(beNil())
		let noName = Meal(name: "", rating: 5, photo: nil)
		expect(noName).to(beNil())
		let badRating = Meal(name: "Really bad rating", rating: -1, photo: nil)
		expect(badRating).to(beNil())
	}
}
