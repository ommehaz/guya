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
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(topBar)
        topBar.addSubview(plusButton)
        
        plusButton.snp.makeConstraints {
            $0.trailingMargin.equalToSuperview()
            $0.bottomMargin.equalToSuperview()
        }
        
        topBar.snp.makeConstraints { (make) -> Void in
            make.leadingMargin.equalTo(view.snp.leading)
            make.trailingMargin.equalTo(view.snp.trailing)
            make.topMargin.equalTo(view.snp.top)
            make.height.equalTo((view.bounds.height / 6))
        }
    }
}

