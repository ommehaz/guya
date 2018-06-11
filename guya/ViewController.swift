//
//  ViewController.swift
//  guya
//
//  Created by Yusuf Tezel on 26/04/2018.
//  Copyright © 2018 Yusuf Tezel. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var isCategoryMenuOpen = false
    lazy var defaultHeight = self.view.bounds.height / 9
    var foodCategoryCollectionViewLeadingConstraint: Constraint? = nil
    var bodyTopConstraint: Constraint? = nil
    let foodCategoryCollectionViewSource = FoodCategoryCollectionViewSource()
    
    var topBar: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        return v
    }()
    
    var body: UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        return v
    }()
    
    var amountLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 30.0)
        l.textColor = .white
        l.text = "12930 kr"
        return l
    }()
    
    var loadingLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 20.0)
        l.textColor = .white
        l.text = "Henter data..."
        return l
    }()
    
    lazy var foodCategoryCollectionView: UICollectionView = {
        let cfl = UICollectionViewFlowLayout()
        cfl.scrollDirection = .horizontal
        var cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: cfl)
        cv.backgroundColor = .clear
        cv.dataSource = foodCategoryCollectionViewSource
        cv.delegate = foodCategoryCollectionViewSource
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(FoodCategoryCell.self, forCellWithReuseIdentifier: "Cell")
        return cv
    }()
    
    var plusButton: UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        b.setTitle("+", for: .normal)
        b.titleLabel?.font = b.titleLabel?.font.withSize(40)
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        self.view.addSubview(loadingLabel)

        loadingLabel.snp.makeConstraints {
            let topOffsetFromActivityIndicator = 50
            $0.centerX.equalToSuperview()
            $0.top.equalTo(activityIndicator).offset(topOffsetFromActivityIndicator)
        }
        
        DataContainer.shared.fetchData {
            self.loadingLabel.removeFromSuperview()
            activityIndicator.stopAnimating()
            self.view.backgroundColor = .white
            
            //add topbar and subitems
            self.view.addSubview(self.topBar)
            self.topBar.addSubview(self.plusButton)
            self.topBar.addSubview(self.amountLabel)
            
            //add foodCategoryCollectionView
            self.view.addSubview(self.foodCategoryCollectionView)
            
            self.view.addSubview(self.body)
            
            //add contraints
            self.snapUI()
        }
    }
    
    @objc func plusButtonTapped(sender: UIButton){
        let screenWidthSize = UIScreen.main.bounds.width
        isCategoryMenuOpen = !isCategoryMenuOpen

        foodCategoryCollectionViewLeadingConstraint?.update(offset: self.isCategoryMenuOpen ? 0: screenWidthSize)
        bodyTopConstraint?.update(offset: self.isCategoryMenuOpen ? (defaultHeight + 2): 0)
        
        UIView.animate(withDuration: 0.25) {
            self.plusButton.transform = self.isCategoryMenuOpen ? CGAffineTransform(rotationAngle: -CGFloat.pi/4): CGAffineTransform.identity
            self.view.layoutIfNeeded()
        }
    }
    
    func snapUI(){
        
        topBar.snp.makeConstraints {
            $0.leading.equalTo(view).labeled("topBarLeading")
            $0.trailing.equalTo(view).labeled("topBarTrailing")
            $0.top.equalTo(view).labeled("topBarTop")
            $0.height.equalTo(defaultHeight).labeled("topBarHeight")
        }
        
        // this will be tableview
        body.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.leading.equalToSuperview()
            bodyTopConstraint = $0.top.equalTo(topBar.snp.bottom).constraint
        }
        
        plusButton.snp.makeConstraints {
            let trailingOffset = -20
            $0.trailing.equalToSuperview().offset(trailingOffset).labeled("plusButtonTrailing")
            $0.bottom.equalToSuperview().labeled("plusButtonBottom")
        }
        
        amountLabel.snp.makeConstraints {
            let bottomOffset = -10
            $0.centerX.equalToSuperview().labeled("amountLabelCenterX")
            $0.bottom.equalToSuperview().offset(bottomOffset).labeled("amountLabelBottom")
        }
        
        foodCategoryCollectionView.snp.makeConstraints {
            let topOffset = 1
            foodCategoryCollectionViewLeadingConstraint = $0.leading.equalToSuperview().offset(UIScreen.main.bounds.width).labeled("foodCategoryCollectionViewLeading").constraint
            $0.top.equalTo(topBar.snp.bottom).offset(topOffset).labeled("foodCategoryCollectionViewTop")
            $0.width.equalToSuperview().labeled("foodCategoryCollectionViewWidth")
            $0.height.equalTo(defaultHeight).labeled("foodCategoryCollectionViewHeight")
        }
    }
}

