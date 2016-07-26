//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by Sean Lin on 26/07/2016.
//  Copyright © 2016 DiUS. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

	// MARK: Properties
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var photoImageView: UIImageView!
	@IBOutlet weak var ratingControl: RatingControl!

	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}

	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

}
