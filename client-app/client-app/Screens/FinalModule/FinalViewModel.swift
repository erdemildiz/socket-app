//
//  FinalViewModel.swift
//  client-app
//
//  Created by Erdem ILDIZ on 23.08.2020.
//  Copyright © 2020 Erdem ILDIZ. All rights reserved.
//

import Foundation

class FinalViewModel {
    
    var didCalculated: ((_ score: Int) -> Void)?
    var totalRightAnswer: Int = 0 
    
    func calculateResult() {
        let score = self.totalRightAnswer * AppConfig.eachQuestionTotalPoint
        self.didCalculated?(score)
    }
}
