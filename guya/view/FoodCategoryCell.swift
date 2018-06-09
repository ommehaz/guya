//
//  FoodCategoryCell.swift
//  guya
//
//  Created by Yusuf Tezel on 08/06/2018.
//  Copyright © 2018 Yusuf Tezel. All rights reserved.
//

import UIKit

class FoodCategoryCell: UICollectionViewCell {
    
    var categoryImage: UIImageView = {
        var i = UIImageView()
        i.contentMode = .scaleAspectFit
        return i
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(categoryImage)
        
        categoryImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
