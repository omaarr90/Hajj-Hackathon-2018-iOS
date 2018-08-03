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

enum SelectionType {
    case chicken
    case seafood
    case vagen
    case meat
}

class VendingMachineCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate, StatefulViewController, StatefulPlaceholderView, FoodPrepViewControllerDelegate {
    
    
    var vendingMachine: VendingMachine!
    var locationManager: CLLocationManager!
    var foodList: NSMutableArray!
    var filterdFoodList =  [FoodItem]()
    var foodType: SelectionType!

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

    var hajjEmptyView: EmptyStateView {
        get {
            let emptyView = EmptyStateView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            emptyView.image = UIImage(named: "empty")
            return emptyView
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
        self.filterFood()
        
        switch self.foodType! {
        case .chicken:
            self.navigationController?.navigationBar.barTintColor = UIColor.chickenColor
        case .seafood:
            self.navigationController?.navigationBar.barTintColor = UIColor.fishColor
        case .vagen:
            self.navigationController?.navigationBar.barTintColor = UIColor.vagenColor
        case .meat:
            self.navigationController?.navigationBar.barTintColor = UIColor.meatColor
        }
        
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
                self.endLoading()
                self.filterFood()
            }
        }
    }
    
    func filterFood()
    {
        switch self.foodType! {
        case .chicken:
            self.filterdFoodList = self.foodList.filter{ object -> Bool in
                let item = object as! FoodItem
                return item.type == "Chicken"
                } as! [FoodItem]
            break;
        case .seafood:
            self.filterdFoodList = self.foodList.filter{ object -> Bool in
                let item = object as! FoodItem
                return item.type == "Fish"
                } as! [FoodItem]
            break;
        case .vagen:
            self.filterdFoodList = self.foodList.filter{ object -> Bool in
                let item = object as! FoodItem
                return item.type == "Vegetables"
                } as! [FoodItem]
            break;
        case .meat:
            self.filterdFoodList = self.foodList.filter{ object -> Bool in
                let item = object as! FoodItem
                return item.type == "Meat"
                } as! [FoodItem]
            break;
        }
        
        self.collectionView?.reloadData()
    }
    
    @objc func showSupplyPage() {
        self.performSegue(withIdentifier: "showSupplyPage", sender: self)
    }
    
    func hasContent() -> Bool {
        return self.filterdFoodList.count > 0
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
        return self.filterdFoodList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FoodItemCollectionViewCell
        
        // Configure the cell
        cell.titleLabel.text = self.filterdFoodList[indexPath.item].nameEn as String
        cell.weightLabel.text = "\(self.filterdFoodList[indexPath.item].weight as! Int) g"
        cell.caloriesLabel.text = "\(self.filterdFoodList[indexPath.item].calories as! Int) Kcal"
        
        switch self.foodType! {
        case .chicken:
            cell.imageView.layer.borderColor = UIColor.chickenColor.cgColor
            cell.imageView.tintColor = UIColor.chickenColor
        case .vagen:
            cell.imageView.layer.borderColor = UIColor.vagenColor.cgColor
            cell.imageView.tintColor = UIColor.vagenColor
        case .seafood:
            cell.imageView.layer.borderColor = UIColor.fishColor.cgColor
            cell.imageView.tintColor = UIColor.fishColor
        case .meat:
            cell.imageView.layer.borderColor = UIColor.meatColor.cgColor
            cell.imageView.tintColor = UIColor.meatColor
        }
        
        if let url = URL(string: self.filterdFoodList[indexPath.item].pictureUrl as String) {
            cell.imageView.downloadedFrom(url: url)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        let foodItem = self.filterdFoodList[indexPath.item]
        let foodId = foodItem.id
        ApiManager.shared.withdraw(food: foodId, fromMachine: self.vendingMachine.id, customerId: 1) {  error in
            if let _ = error {
                //show error alert
            } else {
                for item in self.foodList {
                    let foodItemToDelete = item as! FoodItem
                    if foodItemToDelete.id == foodItem.id {
                        self.foodList.remove(item)
                        self.filterFood()
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
        let width = (self.view.frame.size.width / 2) - 10
        return CGSize(width: width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
}
