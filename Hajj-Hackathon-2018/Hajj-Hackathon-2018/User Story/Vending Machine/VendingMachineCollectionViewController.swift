//
//  VendingMachineCollectionViewController.swift
//  Hajj-Hackathon-2018
//
//  Created by Omar Alshammari on 01/08/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import UIKit
import CoreLocation
import StatefulViewController

private let reuseIdentifier = "FoodItemCollectionViewCell"

class VendingMachineCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate, StatefulViewController, FoodPrepViewControllerDelegate {
    
    
    var vendingMachine: VendingMachine!
    var locationManager: CLLocationManager!
    var foodList: NSMutableArray!
    
    var hajjLoadingView: UILabel {
        get {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
            label.text = "Loading...."
            label.textAlignment = .center
            return label
        }
    }

    var hajjErrorView: UILabel {
        get {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
            label.text = "An Error Occured"
            label.textAlignment = .center
            return label
        }
    }

    var hajjEmptyView: UILabel {
        get {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
            label.text = "No Food At The Moment"
            label.textAlignment = .center
            return label
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
        let foodItemCellNib = UINib(nibName: "FoodItemCollectionViewCell", bundle: Bundle.main)
        self.collectionView?.register(foodItemCellNib, forCellWithReuseIdentifier: "FoodItemCollectionViewCell")
        
        let supplyButton = UIBarButtonItem(title: "Supply", style: .done, target: self, action: #selector(showSupplyPage))
        self.navigationItem.rightBarButtonItem = supplyButton
        
        self.title = "Foods"
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.startUpdatingLocation()
        
        loadingView = self.hajjLoadingView
        errorView = self.hajjErrorView
        emptyView = self.hajjEmptyView
        
        self.foodList = self.vendingMachine.foodList.mutableCopy() as! NSMutableArray
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupInitialViewState()
        
        getFoodList()
    }
    
    func didFinishPreparingFood(controller: FoodPrepViewController) {
        controller.dismiss(animated: true) {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }

    
    func getFoodList() {
        startLoading()
        ApiManager.shared.getMachineInfo(for: self.vendingMachine.id) { (vendingMachine, error) in
            if let vm = vendingMachine {
                self.foodList = vm.foodList.mutableCopy() as! NSMutableArray
                self.endLoading(animated: true, error: error, completion: nil)
                self.collectionView?.reloadData()
            }
        }
    }
    
    @objc func showSupplyPage() {
        self.performSegue(withIdentifier: "showSupplyPage", sender: self)
    }
    
    func hasContent() -> Bool {
        return self.foodList.count > 0
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if let destinationVC = segue.destination as? SupplyFoodViewController {
            destinationVC.vendingMachine = self.vendingMachine
        } else if let destinationVC = segue.destination as? FoodPrepViewController {
            destinationVC.delegate = self
        }
    }
    
    @objc func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        
        ApiManager.shared.updateLocation(self.vendingMachine.id, lat: NSNumber(value: location.coordinate.latitude), lon: NSNumber(value: location.coordinate.longitude))
    }
}

extension VendingMachineCollectionViewController {
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.foodList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FoodItemCollectionViewCell
        
        // Configure the cell
        cell.titleLabel.text = (self.foodList[indexPath.item] as! FoodItem).nameEn as String
        cell.weightLabel.text = "\((self.foodList[indexPath.item] as! FoodItem).weight as! Int) g"
        cell.caloriesLabel.text = "\((self.foodList[indexPath.item] as! FoodItem).calories as! Int) Kcal"
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        let foodItem = self.foodList[indexPath.item] as! FoodItem
        let foodId = foodItem.id
        ApiManager.shared.withdraw(food: foodId, fromMachine: self.vendingMachine.id, customerId: 1) {  error in
            if let _ = error {
                //show error alert
            } else {
                for item in self.foodList {
                    let foodItemToDelete = item as! FoodItem
                    if foodItemToDelete.id == foodItem.id {
                        self.foodList.remove(item)
                    }
                }
                self.performSegue(withIdentifier: "showFoodPrep", sender: self)
            }
        }
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width / 2) - 20
        return CGSize(width: width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 20, left: 5, bottom: 20, right: 5)
    }
}
