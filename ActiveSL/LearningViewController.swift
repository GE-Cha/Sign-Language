//
//  LearningViewController.swift
//  ActiveSL
//
//  Created by GoEum Cha on 11/29/18.
//  Copyright © 2018 GoEum Cha. All rights reserved.
//

import UIKit
import AVFoundation

class LearningViewController: ViewController {
    
    var selectedProgram : String = ""
    var initialState :String! = "a"
    var cnt :Int! = 0
    var imgName :String! = "%s_labelled_T.png"

    @IBOutlet weak var imgSign: UIImageView!
    
    @IBOutlet weak var imgStarSecond: UIImageView!
    @IBOutlet weak var imgStar: UIImageView!
    @IBOutlet weak var lbImageName: UILabel!
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lbDescription: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("selected: \(String(describing: self.selectedProgram))")
        
        btnPrev.isHidden = true
        
        if(selectedProgram == "Alphabet")
        {
            // Alphabets Initializer
            imgSign.image = UIImage(named: "a")
            lbImageName.text = "A"
            lbDescription.text = alphabetsDescription[alphabets[0]]
        }
        
        if(selectedProgram == "Numbers")
        {
            // Numbers initializer
            imgSign.image = UIImage(named: "0")
            lbImageName.text = "0"
            lbDescription.text = numbersDescription[numbers[0]]
            
        }

//        let synthesizer = AVSpeechSynthesizer()
//        let utterance = AVSpeechUtterance(string:"Hello this is tts")
//        // Do any additional setup after loading the view.
//        utterance.rate = 0.5
//        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
//        synthesizer.speak(utterance)
    }
    
    
    @IBAction func btnBackPressed(_ sender: Any) {
        super.btnPressedBack()
    }
    
    @IBAction func btnPrevSignPressed(_ sender: Any) {
        
        if(selectedProgram == "Alphabet")
        {
            if cnt > 0 {
                btnNext.isHidden = false
                cnt = cnt - 1
                lbImageName.text = alphabets[cnt].uppercased()
                lbDescription.text = alphabetsDescription[alphabets[cnt]]
            }
            if cnt == 0 {
                btnPrev.isHidden = true
            }
            
            imgSign.image = UIImage(named:String(format: "%@", alphabets[cnt]))
            
            checkAlphabetDifficulty(cnt: cnt)
        }
        
        if(selectedProgram == "Numbers")
        {
            if cnt > 0 {
                btnNext.isHidden = false
                cnt = cnt - 1
                lbImageName.text = numbers[cnt]
                lbDescription.text = numbersDescription[numbers[cnt]]
            }
            if cnt == 0 {
                btnPrev.isHidden = true
            }
            
            imgSign.image = UIImage(named:String(format: "%@", numbers[cnt]))
            
//            checkNumberDifficulty(cnt: cnt)
        }
        
        
    }
    
    @IBAction func btnNextSignPressed(_ sender: Any) {
        
        if(selectedProgram == "Alphabet") {
            if cnt < 25 {
                btnPrev.isHidden = false
                cnt = cnt + 1
                lbImageName.text = alphabets[cnt].uppercased()
                lbDescription.text = alphabetsDescription[alphabets[cnt]]
            }
            if cnt == 25 {
                btnNext.isHidden = true
            }
            imgSign.image = UIImage(named:String(format: "%@", alphabets[cnt]))
            checkAlphabetDifficulty(cnt: cnt)
        }
        
        if(selectedProgram == "Numbers")
        {
            if cnt < 9 {
                btnPrev.isHidden = false
                cnt = cnt + 1
                lbImageName.text = numbers[cnt]
                lbDescription.text = numbersDescription[numbers[cnt]]
            }
            if cnt == 9 {
                btnNext.isHidden = true
            }
            
            imgSign.image = UIImage(named:String(format: "%@", numbers[cnt]))
            
//            checkNumberDifficulty(cnt: cnt)
        }
        
    }
    
    func checkAlphabetDifficulty(cnt:NSInteger){
        let targetAlphabet = alphabets[cnt]
        
        let levelTwo :String! = phase["LEV2"]
        let levelThree :String! = phase["LEV3"]
        print(targetAlphabet)
        print(phase["LEV2"]!)
        
        if levelTwo.contains(targetAlphabet) {
            print("LEV2")
            imgStar.isHidden = false
            imgStarSecond.isHidden = true
        }
        else if levelThree.contains(targetAlphabet) {
            print("LEV3")
            imgStar.isHidden = false
            imgStarSecond.isHidden = false
        }
        else {
            print("LEV1")
            imgStar.isHidden = true
            imgStarSecond.isHidden = true
        }
        
    }
    
}
