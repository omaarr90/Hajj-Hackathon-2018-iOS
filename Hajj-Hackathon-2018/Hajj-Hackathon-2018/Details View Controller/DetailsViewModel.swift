//
//  DetailsViewModel.swift
//  CollectionViewDemoApp
//
//  Created by Omar Alshammari on 09/11/1439 AH.
//  Copyright © 1439 Omar Alshammari. All rights reserved.
//

import Foundation
import UIKit

//  هذا ال  Enum يمثل انواع الواجهات التي سنحتاجها في تطبيقنا
// مثلا هنا نحتاج ترأيس للمحتويات و نحتاج عبارات وأزرار و خلية بدون محتويات لإضافة فراغ بين المحتويات
enum DetailsCellType {
    case header
    case details
    case button
    case empty
    case person
}

// أي Struct ينتهي بكلمة Property سوف يحمل المعلومات اللتي تحتاجها كل خلية لعرض محتوياتها
struct HeaderCellProperty {
    let title: String
}

struct DetailsCellProperty {
    let title: String
    let subtitle: String
}

struct ButtonCellProperty {
    let buttonTitle: String
    let buttonColor: UIColor
    let buttonTitleColor: UIColor
    let buttonClickHandler: () -> Void
}

struct EmptyCellProperty {
}

struct PersonCellProperty {
    let title: String
    let image: UIImage
}

// هذا هو ال View Model ويحتوي على جميع الخصائص المذكورة سابقا
struct DetailsViewModel {
    var cellType: DetailsCellType
    
    var headerCellProperty: HeaderCellProperty?
    var detailsCellProperty: DetailsCellProperty?
    var buttonCellProperty: ButtonCellProperty?
    var emptyCellProperty: EmptyCellProperty?
    var personCellProperty: PersonCellProperty?
    
    init(headerCellProperty: HeaderCellProperty) {
        self.cellType = .header
        self.headerCellProperty = headerCellProperty
    }
    init(detailsCellProperty: DetailsCellProperty) {
        self.cellType = .details
        self.detailsCellProperty = detailsCellProperty
    }
    init(buttonCellProperty: ButtonCellProperty) {
        self.cellType = .button
        self.buttonCellProperty = buttonCellProperty
    }
    
    init(emptyCellProperty: EmptyCellProperty) {
        self.cellType = .empty
        self.emptyCellProperty = emptyCellProperty
    }
    
    init(personCellProperty: PersonCellProperty) {
        self.cellType = .person
        self.personCellProperty = personCellProperty
    }
    
    func reuseIdentifier() -> String {
        switch self.cellType {
        case .header:
            return "HeaderNameCollectionViewCell"
        case .details:
            return "DetailTextCollectionViewCell"
        case .button:
            return "ButtonCollectionViewCell"
        case .empty:
            return "EmptyCollectionViewCell"
        case .person:
            return "PerosnCollectionViewCell"
        }
    }
}
