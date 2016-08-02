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
	dynamic var firstName = ""
	dynamic var lastName = ""
	dynamic var age = 0

	override static func primaryKey() -> String? {
		return "employeeId"
	}
}
