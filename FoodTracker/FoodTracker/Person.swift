//
//  Person.swift
//  FoodTracker
//
//  Created by Sean Lin on 2/08/2016.
//  Copyright © 2016 DiUS. All rights reserved.
//

import Foundation
import RealmSwift

class Person: Object {
	dynamic var employeeId = ""
	dynamic var fullName = ""
	dynamic var age = 0
	let dogs = List<Dog>()

	override static func primaryKey() -> String? {
		return "employeeId"
	}
}
