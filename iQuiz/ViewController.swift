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
                                        message: "Download quiz info",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Back", style: .default) { _ in
            alertVC.dismiss(animated: true)
        })
        let settingsDL = UIAlertAction(title: "Okay", style: .default, handler:{(_ action: UIAlertAction) in self.downloadJSON()
            if(Network.isConnected()){
                self.downloadJSON()
            }else{
                let alertVC = UIAlertController(title: "Network not available",
                                                message: "Using local storeage.",
                                                preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "Back", style: .default) { _ in
                    alertVC.dismiss(animated: true)
                })
                self.present(alertVC, animated: true)
            }
        })
        alertVC.addAction(settingsDL)
        self.present(alertVC, animated: true)
    }
    
    
    var topics = //[String]()
        ["Mathematics":"Are you faster than a calculator?",
                  "Marvel Super Heroes":"How much of a nerd are you?",
                  "Science":"Only for smartypants."]
    
    func downloadJSON(){
        var dataDict = topics
        let url = URL(string:"http://tednewardsandbox.site44.com/questions.json")
        let dl = URLSession(configuration: .default).dataTask(with: url!) {(data, response, error) in do{
            if let obj = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSArray {
                for topic in obj {
                    let category = topic as? NSDictionary
                    if category!["title"] as? NSString == "Marvel Super Heroes"{
                        self.topics["Marvel Super Heroes"] = category!["desc"] as? NSString as! String
                    } else if category!["title"] as? NSString == "Science!" {
                        self.topics["Science"] = category!["desc"] as? NSString as! String
                    } else{
                        self.topics["Mathematics"] = category!["desc"] as? NSString as! String
                    }
//                    print(category!["title"])
//                  dataDict.append(category!["title"] as! String)
                    print(self.topics)
                }
            }} catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        dl.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        NSLog("numberOfRowsInSection \(Array(topics.keys).count)")
        return 3
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

