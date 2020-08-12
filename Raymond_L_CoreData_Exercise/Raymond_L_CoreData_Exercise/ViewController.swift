//
//  ViewController.swift
//  Raymond_L_CoreData_Exercise
//
//  Created by Raymond Lo on 8/12/20.
//  Copyright © 2020 Raymond. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ViewController: UIViewController {
	
	var dataManager: NSManagedObjectContext!
	var listArray = [NSManagedObject]()
	
	@IBAction func saveRecordButton(_ sender: Any) {
		let newEntity = NSEntityDescription.insertNewObject(forEntityName: "Item", into: dataManager)
		newEntity.setValue(typeText.text!, forKey: "about")
		do{
			try self .dataManager.save()
			listArray.append(newEntity)
		}catch{
			print("Error saving data")
		}
		displayText.text?.removeAll()
		typeText.text?.removeAll()
		fetchData()
	}
	
	@IBAction func deleteRecordButton(_ sender: Any) {
		let deleteItem = typeText.text!
		for item in listArray{
			if item.value(forKey: "about") as! String == deleteItem{
				dataManager.delete(item)
			}
			do{
				try self.dataManager.save()
			}catch{
				print("Error deleting data")
			}
		}
		displayText.text?.removeAll()
		typeText.text?.removeAll()
		fetchData()
	}
	
	@IBOutlet weak var typeText: UITextField!
	

	@IBOutlet weak var displayText: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		dataManager = appDelegate.persistentContainer.viewContext
		displayText.text?.removeAll()
		fetchData()
	}

	func fetchData(){
		let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Item")
		do{
			let result = try dataManager.fetch(fetchRequest)
			listArray = result as! [NSManagedObject]
			for item in listArray{
				let product = item.value(forKey:
				"about") as! String
				displayText.text! += product
			}
			
		}catch{
			print("Error retrieving data")
		}
	}

}

