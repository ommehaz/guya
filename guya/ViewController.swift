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
    
    var topBar: UIView = {
        let v = UIView()
        v.backgroundColor = .red
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
    
    var topBarExtension: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        return v
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
            $0.centerX.equalToSuperview()
            $0.top.equalTo(activityIndicator).offset(50)
        }
        
        DataContainer.shared.fetchData {
            activityIndicator.stopAnimating()
            print(DataContainer.shared.foodCategories)
            self.view.backgroundColor = .white
            self.view.addSubview(self.topBar)
            self.view.addSubview(self.topBarExtension)
            self.topBar.addSubview(self.plusButton)
            self.topBar.addSubview(self.amountLabel)
            self.snpControls()
        }
    }
    
    @objc func plusButtonTapped(sender: UIButton){
        self.isCategoryMenuOpen = !self.isCategoryMenuOpen
        if(self.isCategoryMenuOpen){
            topBarExtension.snp.updateConstraints {
                $0.height.equalTo(100)
            }
            UIView.animate(withDuration: 0.25) {
                self.plusButton.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/4)
                self.view.layoutIfNeeded()
            }
        } else {
            topBarExtension.snp.updateConstraints {
                $0.height.equalTo(0)
            }
            UIView.animate(withDuration: 0.25, animations: {
                self.plusButton.transform = .identity
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func snpControls(){
        plusButton.snp.makeConstraints {
            $0.trailingMargin.equalToSuperview().offset(-20)
            $0.bottomMargin.equalToSuperview()
        }
        
        topBar.snp.makeConstraints {
            $0.leadingMargin.equalTo(view.snp.leading)
            $0.trailingMargin.equalTo(view.snp.trailing)
            $0.topMargin.equalTo(view.snp.top)
            $0.height.equalTo((view.bounds.height / 6))
        }
        
        amountLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        topBarExtension.snp.makeConstraints {
            $0.leadingMargin.equalTo(view.snp.leading)
            $0.trailingMargin.equalTo(view.snp.trailing)
            $0.topMargin.equalTo(topBar.snp.bottom)
            $0.height.equalTo(0)
        }
    }
}

