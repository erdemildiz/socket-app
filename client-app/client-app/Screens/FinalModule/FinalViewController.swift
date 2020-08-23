//
//  FinalViewController.swift
//  client-app
//
//  Created by Erdem ILDIZ on 23.08.2020.
//  Copyright © 2020 Erdem ILDIZ. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {
    
    @IBOutlet weak var totalRightAnswerLabel: UILabel!
    @IBOutlet weak var totalScoreLabel: UILabel!
    
    var totalRightAnswer: Int = 0 {
        didSet {
            viewModel.totalRightAnswer = self.totalRightAnswer
        }
    }
    let viewModel = FinalViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set observers
        setObservers()
        // Calculate
        calculateResult()
    }
    
    fileprivate func setObservers() {
        viewModel.didCalculated = { [weak self] score in
            guard let self = self else { return }
            self.totalRightAnswerLabel.text = "\(self.totalRightAnswer)/\(AppConfig.allowedTotalQuestions)"
            self.totalScoreLabel.text = "\(score)"
        }
    }
    
    fileprivate func calculateResult() {
        viewModel.calculateResult()
    }

}
