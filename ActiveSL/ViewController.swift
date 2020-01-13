//
//  ViewController.swift
//  ActiveSL
//
//  Created by GoEum Cha on 11/19/18.
//  Copyright © 2018 GoEum Cha. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    var alphabets: [String] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    
    var alphabetsDescription: [String:String] = ["a":"A closed fist, all finger folded against the palm, thumb is straight, alongside the index finger.",
                                                 "b":"Put your fingers all straight up and touching and then bend your thumb over your palm.",
                                                 "c":"Curl your hands, so it looks to you like a backwards \"C\"",
                                                 "d":"Touch your thumb and every finger but your index finger, which should point straight up.",
                                                 "e":"Thumb is folded across in front of palm but not touching it. All fingers are partially folded with the tips of index, middle and ring fingers touching the thumb between the knuckle and the tip.",
                                                 "f":"Tip of index finger is touching tip of thumb. Middle, ring and little fingers are straight and slightly spread.",
                                                 "g":"Stick out your thumb and index finger about a centimeter apart and hold it sideways. Your palm faces yourself.",
                                                 "h":"Make a \"G\" and stick out your middle finger alongside your index finger. Your palm faces yourself.",
                                                 "i":"Stick your pinkie straight up.",
                                                 "j":"Stick out your pinkie and twist inward in the shape of a \"J\".",
                                                 "k":"Put your middle and index finger up, and put your thumb on your forefinger.",
                                                 "l":"Make an \"L\" with your thumb and index finger.",
                                                 "m":"Point your fore-, middle, and ring fingers forward. Place the thumb beneath them.",
                                                 "n":"Point your forefinger and your middle finger forward. Place the thumb beneath them.",
                                                 "o":"Make an \"O\" with your fingers.",
                                                 "p":"Make a downwards-pointing \"K\" but with your thumb on your middle finger.",
                                                 "q":"Point a \"G\" downwards. your two fingertips should almost touch each other.",
                                                 "r":"Cross your middle finger over your index finger.",
                                                 "s":"Make a fist and put your thumb on top of your fingers. This is often confused with \"A\" so pay careful attention to the thumb position.",
                                                 "t":"Make a fist and put your thumb between your middle finger and index finger.",
                                                 "u":"Orient your middle finger and your index finger upwards together.",
                                                 "v":"Make a \"U\", and separate the fingers.",
                                                 "w":"To a \"V\", add an upwards ring finger-- all fanned out.",
                                                 "x":"Make a fist and then raise and crook your index finger.",
                                                 "y":"Stick out your pinkie and thumb.",
                                                 "z":"Make a \"Z\", as you would write it, with your index finger."]
    
    var numbers: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    var numbersDescription: [String:String] = ["0":"Make an \"O\" with your fingers.",
                                               "1":"Hold up the index finger.",
                                               "2":"Put the index and middle fingers up.",
                                               "3":"put the thumb, index, and middle finger up.",
                                               "4":"Put four fingers of the hand (but not the thumb) up. Keep the thumb inside the palm.",
                                               "5":"Display the entire hand itself.",
                                               "6":"Take the open hand and touch the thumb to the pinky finger.",
                                               "7":"Touch the thumb to the finger next to the pinky finger.",
                                               "8":"Touch the thumb to the middle finger.",
                                               "9":" touch the thumb to the index finger."]
    
    // Automatic recognition of the American sign language fingerspelling alphabet to assist people living with speech or hearing impairments
    var phase: [String: String] = ["LEV1":"abcdefhiklorstuvwy", "LEV2":"jz", "LEV3":"gmntkpq"]
    
    var tester: [String] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    var speedSample = ["hello", "apple", "hi", "morning"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func btnPressedBack() {
//        var btnBack = self.view.viewWithTag(1000)
        navigationController?.popViewController(animated: true)
        
    }
    


}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
