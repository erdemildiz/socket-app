//
//  QuestionViewModel.swift
//  client-app
//
//  Created by Erdem ILDIZ on 23.08.2020.
//  Copyright © 2020 Erdem ILDIZ. All rights reserved.
//

import Foundation

class QuestionViewModel {
    
    let socket = Socket()
    var didGetNewQuestion: ((_ question: Question) -> Void)?
    var didAdminReplyedQuestion: ((_ reply: Bool) -> Void)?
    var didPermitted: (() -> Void)?
    var didCompletedExam: ((_ rightAnswer: Int) -> Void)?    
    
    init() {
        // Set delegate
        socket.eventDelegate = self
    }
    
}

// MARK: SocketEventDelegate
extension QuestionViewModel: SocketEventDelegate {
    
    // Start Permission
    func didPermittedStart(_ permitted: Bool) {
        if permitted {
            didPermitted?()            
        }
    }
    
   // New Question
    func didGetNewQuestion(question: Question) {
        didGetNewQuestion?(question)  
    }
    
    // Question Admin reply
    func didAdminReplyedQuestion(reply: Bool) {
        didAdminReplyedQuestion?(reply)
    }
    
    // User Answer
    func sendAnswer(answer: String)  {
        socket.sendAnswer(answer: answer)
    }
    
    func didCompleted(_ rightAnswer: Int) {
        didCompletedExam?(rightAnswer)
    }
}

