//
//  ViewController.swift
//  iQuiz
//
//  Created by Joyce Huang on 2/8/18.
//  Copyright © 2018 Joyce Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var topic:String = ""
    var score = 0
    @IBOutlet weak var topicsView: UITableView!
    
    @IBAction func settingsBtn(_ sender: UIBarButtonItem) {
        let alertVC = UIAlertController(title: "Settings",
                                        message: "Settings go here",
            preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            alertVC.dismiss(animated: true)
        })
        self.present(alertVC, animated: true)
    }
    
    let topics = ["Mathematics":"Are you faster than a calculator?",
                  "Marvel Super Heroes":"How much of a nerd are you?",
                  "Science":"Only for smartypants."]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("numberOfRowsInSection \(Array(topics.keys).count)")
        return Array(topics.keys).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        NSLog("We are being asked for indexPath \(indexPath)")
        let index = indexPath.row
        let topic = Array(topics.keys)[index]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = topic
        cell.detailTextLabel?.text = topics[topic]
        
        var image = UIImage(named: "math")!
        if topic == "Science" {
            image = UIImage(named: "science")!
        }
        if topic == "Marvel Super Heroes" {
            image = UIImage(named: "heros")!
        }
        cell.imageView?.image = image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        topic = Array(topics.keys)[indexPath.row]
        NSLog("User selected row at \(topic)")
        
        self.performSegue(withIdentifier: "questionVC", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        topicsView.tableFooterView = UIView()
        topicsView.dataSource = self
        topicsView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let questionView = segue.destination as! QuestionViewController
        questionView.topic = topic
        questionView.score = score
    }
}

