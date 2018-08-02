//
//  SelectMachineViewController.swift
//  Hajj-Hackathon-2018
//
//  Created by Omar Alshammari on 01/08/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import UIKit

private let reuseIdentifier = "VendingMachineCollectionViewCell"

class SelectMachineViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var vendingMachines: [VendingMachine]?
    var selectedVendingMachine: VendingMachine?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Select Vending Machine"
        self.loadAllMachines()
        
        let vendingMachineCellNib = UINib(nibName: "VendingMachineCollectionViewCell", bundle: Bundle.main)
        self.collectionView?.register(vendingMachineCellNib, forCellWithReuseIdentifier: "VendingMachineCollectionViewCell")        
    }
    
    func loadAllMachines() {
        ApiManager.shared.getAllMachines { (vendingMachines, error) in
            if let _ = error {
                // handle Error
            } else {
                self.vendingMachines = vendingMachines
                self.collectionView?.reloadData()
            }
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let destiationNavVC = segue.destination as? UINavigationController, let destinationVC = destiationNavVC.viewControllers.first as? LandingViewController {
            destinationVC.vendingMachine = self.selectedVendingMachine
        }
    }

}

extension SelectMachineViewController
{
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vendingMachines?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! VendingMachineCollectionViewCell
        
        cell.titleLabel.text = self.vendingMachines![indexPath.item].name as String
        cell.contentView.backgroundColor = .orange
        // Configure the cell
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedVendingMachine = self.vendingMachines![indexPath.item]
        
        
        ApiManager.shared.login("vm", withPassword: "123") { (user, error) in
            //
            if let _ = user {
                print("Recived User \(String(describing: user))")
                //save user token
                KeychainHelper.shared.saveUserToken(user!.token!)
                // show next page
                self.performSegue(withIdentifier: "showLandingPage", sender: self)
            } else {
                print("Recived Error \(error!)")
                //showErrorPage
                KeychainHelper.shared.deleteUserToken()
            }
        }
    }
    
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
        let width = (self.view.frame.size.width) - 20
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
