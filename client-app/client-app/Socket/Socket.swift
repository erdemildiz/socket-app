//
//  Socket.swift
//  client-app
//
//  Created by Erdem ILDIZ on 23.08.2020.
//  Copyright © 2020 Erdem ILDIZ. All rights reserved.
//

import Foundation
import SocketIO

protocol SocketEventDelegate: AnyObject {
    func didPermittedStart(_ permitted: Bool)
    func didGetNewQuestion(question: Question)
    func didAdminReplyedQuestion(reply: Bool)
    func didCompleted(_ rightAnswer: Int)
}

class Socket {
    
    private var socketManager: SocketManager?
    private var socket: SocketIOClient?    
    weak var eventDelegate: SocketEventDelegate?
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.initialSocketSetup()
            self.setupEvents()
            self.connectSocket()
        }
        
    }
    
    fileprivate func initialSocketSetup() {
        guard let socketUrl = URL(string: SocketConfig.SOCKET_URL) else { return }
        socketManager = SocketManager(socketURL: socketUrl, config: [])
        socket = socketManager?.defaultSocket
    }
    
    fileprivate func setupEvents() {
        guard let socket = socket else { return }
        guard let eventDelegate = eventDelegate else { return }
        
        socket.on("new-start-request-status") { data, _ in
            guard let startStatus = data[0] as? Int else { return }
            let status: Bool = startStatus == 1
            eventDelegate.didPermittedStart(status)
        }
        
        socket.on("new-question") { data, _ in
            guard let currentQuestion = data[0] as? Dictionary<String, Any>  else { return }
            guard let id = currentQuestion["id"] as? Int else { return }
            guard let question = currentQuestion["question"] as? String else { return }
            guard let rightAnswer = currentQuestion["rightAnswer"] as? String else { return }
            guard let answers = currentQuestion["answers"] as? Dictionary<String, String> else { return }
            guard let A = answers["A"] else { return }
            guard let B = answers["B"] else { return }
            guard let C = answers["C"] else { return }
            guard let D = answers["D"] else { return }
            
            let userQuestion = Question(id: id, question: question, answer: Answer(A: A, B: B, C: C, D: D), rightAnswer: rightAnswer)
            eventDelegate.didGetNewQuestion(question: userQuestion)
        }
        
        socket.on("reply") { data, _ in
            guard let reply = data[0] as? Int  else { return }
            let replyStatus: Bool = reply == 1
            eventDelegate.didAdminReplyedQuestion(reply: replyStatus)
        }
        
        socket.on("complete") { data, _ in
            guard let rightAnswer = data[0] as? Int  else { return }
            eventDelegate.didCompleted(rightAnswer)
        }
        
    }
    
    fileprivate func connectSocket(){
        guard let socket = socket else { return }
        socket.connect()
    }
    
    func sendAnswer(answer: String){
        guard let socket = socket else { return }
        socket.emit("user-answered", answer)
    }
}
