//
//  QuizViewController.swift
//  iQuiz
//
//  Created by Joyce Huang on 2/15/18.
//  Copyright © 2018 Joyce Huang. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    var questionSet:[String] = []
    var answers:[String] = []
    var topic:String = ""
    var selectedAns:String = ""
    var numQuestion = 0
    var score:Int = 0
    @IBOutlet weak var answerChoices: UITableView!
    @IBOutlet weak var qLabel: UILabel!
    
    let mathQs = ["What is 3 + 0 - 6 * 0?":["0","6","3","-3"],
                  "What is 3 * 8?":["24","11","32","36"],
                  "What is 0 - 1?":["-1","1","23","100"]]
    let heroQs = ["Who plays the character Peter Quill?":["Robert Downey Jr.","Chris Pratt","James Gunn","Vin Diesel"],
                  "Wonder Woman is a Marvel character":["true","false"]]
    let sciQs = ["What is the powerhouse of a cell?":["Nucleus","Mitochondria","Chloroplast","Cell membrane"],
                  "Is the sun a star or a planet?":["Star","Planet"],
                  "What is the largest land animal in the world?":["Killer whale", "Blue whale", "Elephant", "T-rex"]]
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "back", sender: nil)
    }
    @IBAction func submitBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "submit", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAns = answers[indexPath.row]
        NSLog("User selected row at \(selectedAns)")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        NSLog("indexPath in question \(indexPath)")
        let index = indexPath.row
        NSLog("ARRAY \(answers)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        cell.textLabel?.text = answers[index]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("rows in answers: \(answers.count)")
        return answers.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerChoices.tableFooterView = UIView()
        answerChoices.dataSource = self
        answerChoices.delegate = self
        
        if topic == "Mathematics" {
            qLabel.text = Array(mathQs.keys)[numQuestion]
            answers = Array(mathQs.values)[numQuestion]
            questionSet = Array(mathQs.keys)
        }
        if topic == "Marvel Super Heroes" {
            qLabel.text = Array(heroQs.keys)[numQuestion]
            answers = Array(heroQs.values)[numQuestion]
            questionSet = Array(heroQs.keys)
        }
        if topic == "Science" {
            qLabel.text = Array(sciQs.keys)[numQuestion]
            answers = Array(sciQs.values)[numQuestion]
            questionSet = Array(sciQs.keys)
        }
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @IBAction func swipeHandler(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case UISwipeGestureRecognizerDirection.right:
            self.performSegue(withIdentifier: "back", sender: nil)
        case UISwipeGestureRecognizerDirection.left:
            self.performSegue(withIdentifier: "submit", sender: nil)
        default:
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "submit"{
            let answerView = segue.destination as! AnswerViewController
            answerView.topic = topic
            answerView.selectedAns = selectedAns
            answerView.numQuestion = numQuestion
            answerView.score = score
            answerView.question = questionSet[numQuestion]
            answerView.totalQs = questionSet.count
            NSLog("\(questionSet.count)")
        }
        
        
    }
 

}
