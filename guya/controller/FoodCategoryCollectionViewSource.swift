//
//  FoodCategoryCollectionViewController.swift
//  guya
//
//  Created by Yusuf Tezel on 08/06/2018.
//  Copyright © 2018 Yusuf Tezel. All rights reserved.
//

import UIKit
import FirebaseStorage
import SDWebImage

private let reuseIdentifier = "Cell"

class FoodCategoryCollectionViewSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 6 , height: collectionView.bounds.height)
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return DataContainer.shared.foodCategories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FoodCategoryCell
        cell.categoryImage.sd_setImage(with: URL(string: DataContainer.shared.foodCategories[indexPath.row].imageUrl),
                                       placeholderImage: UIImage(named: "dummypic.png"))
        return cell
    }

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let totalCellWidth = Int(UIScreen.main.bounds.width / 6) * DataContainer.shared.foodCategories.count
        let totalSpacingWidth = 10 * (DataContainer.shared.foodCategories.count - 1)
        
        let leftInset = (UIScreen.main.bounds.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsetsMake(0, leftInset, 0, rightInset)
    }
}
