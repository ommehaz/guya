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
    
    var topBar: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        return v
    }()
    
    var plusButton: UIButton = {
       let b = UIButton()
        b.setTitle("+", for: .normal)
        b.titleLabel?.font = b.titleLabel?.font.withSize(40)
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(topBar)
        topBar.addSubview(plusButton)
        
        plusButton.snp.makeConstraints {
            $0.trailingMargin.equalToSuperview().offset(-20)
            $0.bottomMargin.equalToSuperview()
        }
        
        topBar.snp.makeConstraints {
            $0.leadingMargin.equalTo(view.snp.leading)
            $0.trailingMargin.equalTo(view.snp.trailing)
            $0.topMargin.equalTo(view.snp.top)
            $0.height.equalTo((view.bounds.height / 5))
        }
    }
}

