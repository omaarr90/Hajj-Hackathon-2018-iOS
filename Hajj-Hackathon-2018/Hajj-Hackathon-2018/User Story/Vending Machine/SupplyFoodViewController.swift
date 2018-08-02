//
//  SupplyFoodViewController.swift
//  Hajj-Hackathon-2018
//
//  Created by Omar Alshammari on 01/08/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import UIKit

class SupplyFoodViewController: UIViewController {

    var foodList = NSMutableArray(capacity: 1)
    var vendingMachine: VendingMachine!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.autoGenerateFoodItems()
        
    }
    
    @IBAction func submit(_ sender: UIButton) {
        ApiManager.shared.supplyMachine(self.foodList, machineID: self.vendingMachine.id) {result in
            print("\(result)")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func autoGenerateFoodItems() {
        /**
 var id: Int
 var nameAr: String
 var nameEn: String
 var type: String
 //    var barcode: String
 var timestamp: UInt
 var customerId: Int?
 var vmId: Int?
 var pictureUrl: String
 var calories: Int
 var weight: Int
*/

        
        for _ in 0...5 {
            let diceRoll = Int(arc4random_uniform(8) + 1)

            let foodItem = FoodItem(MealConstants.mealsItemAr[diceRoll] as NSString, nameEn: MealConstants.mealsItemEn[diceRoll] as NSString, type: MealConstants.mealTypes[diceRoll] as NSString, timestamp: NSNumber(integerLiteral: 5), customerId: nil, vmId: self.vendingMachine!.id, pictureUrl: MealConstants.mealUrls[diceRoll] as NSString, calories: NSNumber(integerLiteral: MealConstants.mealCals[diceRoll]), weight: NSNumber(integerLiteral: MealConstants.mealweights[diceRoll]))
            self.foodList.add(foodItem.toDict())
        }
    }

}
