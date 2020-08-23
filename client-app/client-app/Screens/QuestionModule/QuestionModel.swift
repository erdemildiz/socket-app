//
//  QuestionModel.swift
//  client-app
//
//  Created by Erdem ILDIZ on 23.08.2020.
//  Copyright © 2020 Erdem ILDIZ. All rights reserved.
//

import Foundation

struct Answer {
    let A: String
    let B: String
    let C: String
    let D: String
}

struct Question {
    let id: Int
    let question: String
    let answer: Answer
    let rightAnswer: String
}
