//
//  DetailsCollectionViewController.swift
//  CollectionViewDemoApp
//
//  Created by Omar Alshammari on 09/11/1439 AH.
//  Copyright © 1439 Omar Alshammari. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class DetailsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var viewModels = [DetailsViewModel]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headerNameNib = UINib(nibName: "HeaderCollectionViewCell", bundle: Bundle.main)
        self.collectionView?.register(headerNameNib, forCellWithReuseIdentifier: "HeaderNameCollectionViewCell")
        
        let detailsNameNib = UINib(nibName: "LabelCollectionViewCell", bundle: Bundle.main)
        self.collectionView?.register(detailsNameNib, forCellWithReuseIdentifier: "DetailTextCollectionViewCell")

        let personCellNib = UINib(nibName: "PerosnCollectionViewCell", bundle: Bundle.main)
        self.collectionView?.register(personCellNib, forCellWithReuseIdentifier: "PerosnCollectionViewCell")

        let buttonCellNib = UINib(nibName: "ButtonCollectionViewCell", bundle: Bundle.main)
        self.collectionView?.register(buttonCellNib, forCellWithReuseIdentifier: "ButtonCollectionViewCell")

        let emptyCellbutton = UINib(nibName: "EmptyCollectionViewCell", bundle: Bundle.main)
        self.collectionView?.register(emptyCellbutton, forCellWithReuseIdentifier: "EmptyCollectionViewCell")
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModels.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let viewModel = self.viewModels[indexPath.item]
        
        switch viewModel.cellType {
        case .header:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.reuseIdentifier(), for: indexPath) as! HeaderCollectionViewCell
            cell.headerLabel.text = viewModel.headerCellProperty?.title
            return cell
        case .details:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.reuseIdentifier(), for: indexPath) as! LabelCollectionViewCell
            cell.titleLabel.text = viewModel.detailsCellProperty?.title
            cell.subtitleLabel.text = viewModel.detailsCellProperty?.subtitle
            return cell
        case .button:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.reuseIdentifier(), for: indexPath) as! ButtonCollectionViewCell
            cell.button.setTitle(viewModel.buttonCellProperty?.buttonTitle, for: .normal)
            cell.button.backgroundColor = (viewModel.buttonCellProperty?.buttonColor)!
            cell.button.setTitleColor(viewModel.buttonCellProperty?.buttonTitleColor, for: .normal)
            cell.handler = viewModel.buttonCellProperty?.buttonClickHandler
            return cell
        case .empty:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.reuseIdentifier(), for: indexPath) as! EmptyCollectionViewCell
            return cell
        case .person:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.reuseIdentifier(), for: indexPath) as! PerosnCollectionViewCell
            cell.titleLabel.text = viewModel.personCellProperty?.title
            cell.imageView.image = viewModel.personCellProperty?.image
            return cell
        }
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat
        let viewItem = self.viewModels[indexPath.item]
        
        switch viewItem.cellType {
        case .header:
            height = 50
        case .details:
            height = 50
        case.button:
            height = 100
        case .empty:
            height = 20
        case .person:
            height = 50
        }
        
        let width = self.view.frame.size.width
        return CGSize(width: width, height: height)
    }    
}

extension DetailsCollectionViewController {
    func addHeader(with title: String) {
        let headerCellProperty = HeaderCellProperty(title: title)
        let viewModel = DetailsViewModel(headerCellProperty: headerCellProperty)
        self.viewModels.append(viewModel)
    }

    func  addDetails(with title: String, and subtitle: String) {
        let detailsCellProperty = DetailsCellProperty(title: title, subtitle: subtitle)
        let viewModel = DetailsViewModel(detailsCellProperty: detailsCellProperty)
        self.viewModels.append(viewModel)
    }
    
    func addPersonCell(name: String, image: UIImage) {
        let personCellProperty = PersonCellProperty(title: name, image: image)
        let viewItem = DetailsViewModel(personCellProperty: personCellProperty)
        self.viewModels.append(viewItem)
    }
    
    func addButtonCell(title: String, color: UIColor, titleColor: UIColor, handler: @escaping (() -> Void) ) {
        let buttonCellProperty = ButtonCellProperty(buttonTitle: title, buttonColor: color, buttonTitleColor: titleColor, buttonClickHandler: handler)
        let viewItem = DetailsViewModel(buttonCellProperty: buttonCellProperty)
        self.viewModels.append(viewItem)
    }
    
    func addEmptyCell() {
        let emptyCellProperty = EmptyCellProperty()
        let viewItem = DetailsViewModel(emptyCellProperty: emptyCellProperty)
        self.viewModels.append(viewItem)
    }

}
