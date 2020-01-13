//
//  TestingSelectionViewController.swift
//  ActiveSL
//
//  Created by GoEum Cha on 12/3/18.
//  Copyright © 2018 GoEum Cha. All rights reserved.
//

import UIKit

class TestingSelectionViewController: ViewController, UITableViewDelegate, UITableViewDataSource {

    var testing = [["[Alphabets] Try it yourself", "[Alphabets] Understanding ASL"], ["[Numbers] Try it yourself", "[Numbers] Understand ASL"]]
    // 0: Recognize, 1: Understand
    var sectionTitle = ["Alphabets", "Numbers"]
    var configurer = [["10", "11"], ["20", "21"]]
    
    var selected :String! = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestingCell") as? TesingSelectionTableViewCell
        cell!.lbTitle.text = testing[indexPath.section][indexPath.row]
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.testing.count;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // GO TO LEARNING PHASE
        selected = configurer[indexPath.section][indexPath.row]
        self.performSegue(withIdentifier: "segueTesting", sender: selected)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueTesting" {
            if let vc = segue.destination as? TestingViewController {
                vc.selectedProgram = selected
            }
        }
    }
    
    @IBAction func btnBackPressed(_ sender: Any) {
        super.btnPressedBack()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
