//
//  FinishViewController.swift
//  iQuiz
//
//  Created by Joyce Huang on 2/16/18.
//  Copyright © 2018 Joyce Huang. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {
    var score:Int = 0
    var totalQs = 0
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "You got \(score) out of \(totalQs)!"
        if score == totalQs {
            textLabel.text = "Perfect score!"
            textLabel.textColor = UIColor.cyan
        }else{
            textLabel.text = "Better luck next time!"
            textLabel.textColor = UIColor.brown
        }
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func swipeHandler(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case UISwipeGestureRecognizerDirection.right:
            self.performSegue(withIdentifier: "back", sender: nil)
        case UISwipeGestureRecognizerDirection.left:
            self.performSegue(withIdentifier: "back", sender: nil)
        default:
            break
        }
    }
    
}
