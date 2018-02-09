//
//  ViewController.swift
//  iQuiz
//
//  Created by Joyce Huang on 2/8/18.
//  Copyright © 2018 Joyce Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var topicsTable: UITableView!
    
    let topics = ["Mathematics":"Are you faster than a calculator?",
                  "Marvel Super Heros":"How much of a nerd are you?",
                  "Science":"Only for smartypants."]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("numberOfRowsInSection \(Array(topics.keys).count)")
        return Array(topics.keys).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        NSLog("We are being asked for indexPath \(indexPath)")
        let index = indexPath.row
        let topic = Array(topics.keys)[index]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        cell.textLabel?.text = topic
        cell.detailTextLabel?.text = topics[topic]
        
        var image = UIImage(named: "math")!
        if topic == "Science" {
            image = UIImage(named: "science")!
        }
        if topic == "Marvel Super Heros" {
            image = UIImage(named: "heros")!
        }
        cell.imageView?.image = image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let topic = Array(topics.keys)[indexPath.row]
        NSLog("User selected row at \(topic)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topicsTable.tableFooterView = UIView()
        topicsTable.dataSource = self
        topicsTable.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

