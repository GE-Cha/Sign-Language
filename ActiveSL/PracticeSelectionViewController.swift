//
//  PracticeSelectionViewController.swift
//  ActiveSL
//
//  Created by GoEum Cha on 12/2/18.
//  Copyright © 2018 GoEum Cha. All rights reserved.
//

import UIKit

class PracticeSelectionViewController: ViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var practiceSelectTableView: UITableView!
    
    var practiceCellTitle = [["STEP1-1: Alphabets", "STEP1-2: Alphabets conversely", "STEP1-3: Confusing Alphabets"], ["STEP2-1: Numbers", "STEP2-2: Numbers conversely", "STEP2-3: Combinations"], ["Words"]]
    var sectionTitle = ["Alphabets", "Numbers", "Words with Speed"]
    var configurer = [["11", "12", "13"], ["21", "22", "23"], ["30"]]
    var selected = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnPressedBack(_ sender: Any) {
        super.btnPressedBack()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PracticeCell") as? PracticeSelectionTableViewCell
        cell!.lbCell.text = practiceCellTitle[indexPath.section][indexPath.row]
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section];
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return 3;
    }
    
//    func tableVi
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 2){
            return 1;
        }
        else {
            return 3;
        }
//        return self.practiceCellTitle.count;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // GO TO LEARNING PHASE
        selected = configurer[indexPath.section][indexPath.row]
        self.performSegue(withIdentifier: "seguePractice", sender: selected)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "seguePractice" {
            if let vc = segue.destination as? PracticeViewController {
                vc.selectedProgram = selected
            }
        }
    }

}
