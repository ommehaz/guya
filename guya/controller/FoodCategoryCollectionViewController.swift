//
//  CategoryCollectionViewController.swift
//  guya
//
//  Created by Yusuf Tezel on 07/06/2018.
//  Copyright © 2018 Yusuf Tezel. All rights reserved.
//

import Foundation
import UIKit

class FoodCategoryCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataContainer.shared.foodCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
