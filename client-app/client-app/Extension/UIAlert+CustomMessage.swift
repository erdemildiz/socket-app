//
//  UIAlert+CustomMessage.swift
//  client-app
//
//  Created by Erdem ILDIZ on 23.08.2020.
//  Copyright © 2020 Erdem ILDIZ. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showSuccessMessage() {
        let message = "Next Question"
        let title   = "Congrats!"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showFailMessage() {
        let message = "Sorry, Your answer is wrong!"
        let title   = "Opps!"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
