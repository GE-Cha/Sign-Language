//
//  MainViewController.swift
//  ActiveSL
//
//  Created by GoEum Cha on 11/19/18.
//  Copyright © 2018 GoEum Cha. All rights reserved.
//

import UIKit

class MainViewController: ViewController {

    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var csLeadingMenuView: NSLayoutConstraint!
    
    var boolMenuButton: Bool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        boolMenuButton = false
        self.csLeadingMenuView.constant = -190

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    

    

    @IBAction func clickedMenuButton(_ sender: Any) {
        
        if(self.boolMenuButton == true)
        {
            self.csLeadingMenuView.constant = -190
            self.boolMenuButton = false
        }
        else
        {
            self.csLeadingMenuView.constant = 0
            self.boolMenuButton = true
        }
//        self.performSegue(withIdentifier: @"", sender: nil)
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
