//
//  SelectionViewController.swift
//  ActiveSL
//
//  Created by GoEum Cha on 11/19/18.
//  Copyright © 2018 GoEum Cha. All rights reserved.
//

import UIKit

class SelectionViewController: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var selectTableView: UITableView!
    
    var cellTitle = ["Alphabet", "Numbers", "Simple Greetings"]
    var selected = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
            self.selectTableView.delegate = self
        self.selectTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    @IBAction func btnBackPressed(_ sender: Any) {
        super.btnPressedBack()
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SelectTableViewCell
        cell!.lbCell.text = cellTitle[indexPath.row]

        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellTitle.count;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // GO TO LEARNING PHASE
        selected = cellTitle[indexPath.row]
        self.performSegue(withIdentifier: "segueLearning", sender: selected)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "segueLearning" {
            if let vc = segue.destination as? LearningViewController {
                vc.selectedProgram = selected
            }
        }
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
