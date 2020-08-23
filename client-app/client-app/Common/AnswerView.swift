//
//  QuestionView.swift
//  client-app
//
//  Created by Erdem ILDIZ on 23.08.2020.
//  Copyright © 2020 Erdem ILDIZ. All rights reserved.
//

import UIKit

class AnswerView: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        self.init()
    }
    
    fileprivate func setupUI() {
        self.setTitleColor(.black, for: .normal)
        self.clipsToBounds = true
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 4.0
    }
    
    func makeSelected() {
        self.setTitleColor(.white, for: .selected)
        self.backgroundColor = UIColor(red: 0, green: 123, blue: 255, alpha: 1)
    }
    
    func makeUnSelected() {
        self.backgroundColor = .white
        self.setTitleColor(.black, for: .normal)
    }
}
