//
//  Meal.swift
//  FoodTracker
//
//  Created by Sean Lin on 25/07/2016.
//  Copyright © 2016 DiUS. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {
	// MARK: Properties

	var name: String
	var rating: Int
	var photo: UIImage?

	// MARK: Archiving Paths

	static let DocumentsDirectory =
		NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
	static let ArchivingURL = DocumentsDirectory.URLByAppendingPathComponent("meals")

	// MARK: Types

	struct PropertyKey {
		static let nameKey = "name"
		static let ratingKey = "rating"
		static let photoKey = "photo"
	}

	// MARK: Initialization

	init?(name: String, rating: Int, photo: UIImage?) {
		self.name = name
		self.rating = rating
		self.photo = photo

		super.init()

		if name.isEmpty || rating < 0 {
			return nil
		}
	}

	// MARK: NSCoding

	func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
		aCoder.encodeInteger(rating, forKey: PropertyKey.ratingKey)
		aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
	}

	required convenience init?(coder aDecoder: NSCoder) {
		let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
		let rating = aDecoder.decodeIntegerForKey(PropertyKey.ratingKey)
		let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage

		self.init(name: name, rating: rating, photo: photo)
	}
}
