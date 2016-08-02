//
//  AppDelegate.swift
//  FoodTracker
//
//  Created by Sean Lin on 22/07/2016.
//  Copyright © 2016 DiUS. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		let migrationBlock: MigrationBlock = { migration, oldSchemaVersion in
			if oldSchemaVersion < 1 {
				print("\(oldSchemaVersion) -> 1")
				migration.enumerate(Person.className()) { oldObject, newObject in
					let firstName = oldObject!["firstName"] as! String
					let lastName = oldObject!["lastName"] as! String
					newObject!["fullName"] = "\(firstName) \(lastName)"
				}
			}

			if oldSchemaVersion < 2 {
				print("\(oldSchemaVersion) -> 2")
			}

			if oldSchemaVersion < 3 {
				print("\(oldSchemaVersion) -> 3")
			}

			print("Migration completed.")
		}

		Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 3, migrationBlock: migrationBlock)

		let realm = try! Realm()

		// Debugging purpose
		print(realm.configuration.fileURL!)

		//		// Create object in v0
		//		try! realm.write {
		//			realm.create(Person.self, value: ["employeeId": "A168837", "firstName": "Sean", "lastName": "Lin", "age": 25], update: true)
		//		}

		//		// Create object in v1
		//		try! realm.write {
		//			realm.create(Person.self, value: ["employeeId": "A168838", "fullName": "John Woo", "age": 35], update: true)
		//		}

		//			// Adding new model does't need migration, only changing does
		//		try! realm.write {
		//			let nimo = Dog(value: ["name": "Nimo", "age": 1])
		//			realm.add(nimo)
		//		}

//		// Create object in v2
//		try! realm.write {
//			let george = Person(value: ["employeeId": "A168839", "fullName": "George Lee", "age": 22])
//			realm.add(george)
//
//			if let nimo = realm.objects(Dog.self).filter("name = 'Nimo' AND age = 1").first {
//				george.dogs.append(nimo)
//			}
//		}

		try! realm.write {
			realm.create(Person.self, value: ["employeeId": "A168840", "fullName": "Lydia Von", "age": 28, "email": "lvon@example.com"], update: true)
		}

		return true
	}

	func applicationWillResignActive(application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(application: UIApplication) {
		// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}
	
	
}
