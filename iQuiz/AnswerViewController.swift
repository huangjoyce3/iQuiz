//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Joyce Huang on 2/16/18.
//  Copyright © 2018 Joyce Huang. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    var topic:String = ""
    var selectedAns:String = ""
    var question = ""
    var numQuestion = 0
    var score:Int = 0
    var totalQs = 0
    let answerBank = ["Mathematics": ["3","24","-1"],
                      "Marvel Super Heroes":["Chris Pratt", "false"],
                      "Science":["Star", "Blue whale", "Mitochondria"]]
    @IBOutlet weak var qLabel: UILabel!
    @IBOutlet weak var correctAnswer: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    @IBAction func nextBtn(_ sender: UIButton) {
        if numQuestion == totalQs - 1 {
            self.performSegue(withIdentifier: "finished", sender: nil)
        }
        self.performSegue(withIdentifier: "nextQ", sender: nil)
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "back", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        qLabel.text = question
        correctAnswer.text = answerBank[topic]![numQuestion]
        
        if (answerBank[topic]?.contains(selectedAns))!{
            resultLabel.text = "You got the right answer!"
            resultLabel.textColor = UIColor.orange
            score = score + 1
        }else{
            resultLabel.text = "Womp womp. Wrong!"
            resultLabel.textColor = UIColor.red
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextQ"{
            let questionView = segue.destination as! QuestionViewController
            questionView.topic = topic
            questionView.score = score
            questionView.numQuestion = numQuestion + 1
        }
        if segue.identifier == "finished"{
            let finishedView = segue.destination as! FinishViewController
            finishedView.totalQs = totalQs
            finishedView.score = score
        }
    }

    @IBAction func swipeHandler(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case UISwipeGestureRecognizerDirection.right:
            self.performSegue(withIdentifier: "back", sender: nil)
        case UISwipeGestureRecognizerDirection.left:
            if numQuestion == totalQs - 1 {
                self.performSegue(withIdentifier: "finished", sender: nil)
            }
            self.performSegue(withIdentifier: "nextQ", sender: nil)
        default:
            break
        }
    }
}
