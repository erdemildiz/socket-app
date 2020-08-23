//
//  QuestionViewController.swift
//  client-app
//
//  Created by Erdem ILDIZ on 23.08.2020.
//  Copyright © 2020 Erdem ILDIZ. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    // Loading
    @IBOutlet weak var waitingView: UIStackView!
    @IBOutlet weak var waitingText: UILabel!
    // Question
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerA: AnswerView!
    @IBOutlet weak var answerB: AnswerView!
    @IBOutlet weak var answerC: AnswerView!
    @IBOutlet weak var answerD: AnswerView!
    @IBOutlet weak var timerLabel: UILabel!
    // View Model
    let viewModel = QuestionViewModel()
    var timer: Timer?
    var totalRightAnswer = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set observers
        setObservers()
    }
    
    func setObservers(){
        // Start Permission
        viewModel.didPermitted = { [weak self] in
            guard let self = self else { return }
            self.waitingView.isHidden = true
            self.questionView.isHidden = false
        }
        // New question
        viewModel.didGetNewQuestion = { [weak self] question in
            guard let self = self else { return }
            self.questionLabel.text = question.question
            self.answerA.setTitle(question.answer.A, for: .normal)
            self.answerB.setTitle(question.answer.B, for: .normal)
            self.answerC.setTitle(question.answer.C, for: .normal)
            self.answerD.setTitle(question.answer.D, for: .normal)
            self.timer?.invalidate()
            self.startTimer()
            self.totalRightAnswer += 1
        }
        // Replay Answer
        viewModel.didAdminReplyedQuestion = { replay in
            self.resetSelection()
            self.hideLoading()
            
            if replay {
                self.showSuccessMessage()
            }
        }
        // Complete
        viewModel.didCompletedExam = { rightAnswer in
            self.goFinalScreen(rightAnswer)
        }
    }
    
    fileprivate func startTimer() {
        var time = 0
        if #available(iOS 10.0, *) {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
                DispatchQueue.main.async {
                    if time < AppConfig.timeOutInterval {
                        time += 1
                        self?.timerLabel.text = "\(Constats.restOfTime) \(time)"
                    } else {
                        self?.timer?.invalidate()
                        self?.goFinalScreen((self?.totalRightAnswer)!)
                    }
                }
            }
        }
    }
    
    fileprivate func resetSelection() {
        answerA.makeUnSelected()
        answerB.makeUnSelected()
        answerC.makeUnSelected()
        answerD.makeUnSelected()
    }
    
    func showLoading() {
        waitingView.isHidden = false
        questionView.alpha = 0.3
        waitingText.text = Constats.waitingApproval
        answerA.isUserInteractionEnabled = false
        answerB.isUserInteractionEnabled = false
        answerC.isUserInteractionEnabled = false
        answerD.isUserInteractionEnabled = false
    }
    
    func hideLoading() {
        waitingView.isHidden = true
        questionView.alpha = 1
        answerA.isUserInteractionEnabled = true
        answerB.isUserInteractionEnabled = true
        answerC.isUserInteractionEnabled = true
        answerD.isUserInteractionEnabled = true
    }
    
    // Redirect Final Screen
    func goFinalScreen(_ rightAnswer: Int) {
        let finalViewController = FinalViewController()
        finalViewController.modalPresentationStyle = .fullScreen
        finalViewController.totalRightAnswer = rightAnswer
        present(finalViewController, animated: true, completion: nil)
    }
    
    
    // MARK: Handle Answer Events
    @IBAction func handleAnswerActionA(_ sender: Any) {
        answerA.makeSelected()
        showLoading()
        viewModel.sendAnswer(answer: "A")
    }
    
    @IBAction func handleAnswerActionB(_ sender: Any) {
        answerB.makeSelected()
        showLoading()
        viewModel.sendAnswer(answer: "B")
    }
    
    @IBAction func handleAnswerActionC(_ sender: Any) {
        answerC.makeSelected()
        showLoading()
        viewModel.sendAnswer(answer: "C")
    }
    
    
    @IBAction func handleAnswerActionD(_ sender: Any) {
        answerD.makeSelected()
        showLoading()
        viewModel.sendAnswer(answer: "D")
    }
    
}


