//
//  PracticeViewController.swift
//  ActiveSL
//
//  Created by GoEum Cha on 10/29/18.
//  Copyright © 2018 GoEum Cha. All rights reserved.
//

import UIKit
import AVFoundation

class PracticeViewController: ViewController, AVCaptureVideoDataOutputSampleBufferDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var selectedProgram : String = ""
    var confusingAlphabets: [String] = ["j", "z", "g","m", "n", "t", "k", "p", "q"]
  
    @IBOutlet var viewAll: UIView!
    
    @IBOutlet weak var lbSelected: UILabel!
    @IBOutlet weak var viewSigns: UIImageView!
    @IBOutlet weak var viewCamera: UIView!
    @IBOutlet weak var btnTest: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnRepeat: UIButton!
    
    @IBOutlet weak var imgCombiNumberOne: UIImageView!
    @IBOutlet weak var imgCombiNumberTwo: UIImageView!
    @IBOutlet weak var imgArrow: UIImageView!
    
    
    var cnt: NSInteger!
    var combiCnt: NSInteger!
    var speed: Double!
    var wordCnt: NSInteger!
    @IBOutlet weak var lbSpeed: UILabel!
    @IBOutlet weak var btnSpeedUp: UIButton!
    @IBOutlet weak var btnSpeedDown: UIButton!
    
    // Combination number
    var num1: NSInteger!
    var num2: NSInteger!
    
    var isFinished: Bool!
    var speedFlag: Bool!
    
    // Word Speed
    var spelling: String! = ""
    var animationQueue = [() -> Void]()
    var animationNotFinished: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("selected program \(selectedProgram)")
        isFinished = false
        buttonInitializer()
        combiCnt = 0
        wordCnt = 0
        animationNotFinished = false
        speedFlag = false
        
        switch selectedProgram {
        case "11":
            reloader_alphabets_order()
            break
        case "12":
            reloader_alphabets_reversed()
            break
        case "13":
            reloader_alphabets_confusing()
            break
        case "21":
            reloader_numbers_order()
            break
        case "22":
            reloader_numbers_reversed()
            break
        case "23":
            reloader_numbers_combinated()
            break
        case "30":
//            reloader_words_combinated()
            break
        
        default:
            break
        }
        // Default Setting by input
        /*
         11: Alphabets in order
         12: Alphabets in conversed order
         13: Confusing Alphabets
         21: Numbers
         22: Numbers in conversed order
         23: Combinations
         30: Speed
         */

        
    }
    
    func applyNextAnimation () {
        guard !animationQueue.isEmpty else { return }
        let animation = animationQueue.removeFirst()
        
        CATransaction.begin()
        animationNotFinished = true
        CATransaction.setCompletionBlock {
            DispatchQueue.main.asyncAfter(deadline: .now() + self.speed, execute: {
                self.applyNextAnimation()
                if(self.animationQueue.isEmpty) {
                    self.animationNotFinished = false
                }
                
            })
        }
        animation()
        CATransaction.commit()
        
    }
    
    func getAttributedString(targetStr: String, range: NSRange) -> NSMutableAttributedString
    {
        let attributedString = NSMutableAttributedString(string: targetStr)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: range)
        
        return attributedString
    }
    
    func reloader_words_combinated()
    {
        btnTest.isHidden = true
        btnRepeat.isHidden = false
        btnNext.isHidden = false
        lbSpeed.isHidden = false
        btnSpeedUp.isHidden = false
        btnSpeedDown.isHidden = false
        speed = 1.0
        wordCnt = 0
//        var i: Int = 0
//        spelling = speedSample[0]
        repeatAnimation(targetString: speedSample[wordCnt])
        
    }
    
    func repeatAnimation(targetString: String)
    {
        var i: Int = 0
        animationQueue.removeAll()
        
        for letter in targetString {
            animationQueue.append({
                UIView.animate(withDuration: self.speed*10000.0, animations: {
                    self.viewSigns.image = UIImage(named:String(format: "%@", String(letter)))
                    self.lbSelected.attributedText = self.getAttributedString(targetStr: targetString.uppercased(), range: NSMakeRange(i, 1) )
                    i = i + 1
                })
            })
        }
        
        applyNextAnimation()
    }
    
    func buttonInitializer()
    {
        btnTest.isHidden = true
//        btnRepeat.isHidden = true
        btnNext.isHidden = false
        lbSpeed.isHidden = true
        btnSpeedUp.isHidden = true
        btnSpeedDown.isHidden = true
    }
    
    func hideImageCombination(flag :Bool)
    {
        if(flag == true)
        {
            imgCombiNumberOne.isHidden = true
            imgArrow.isHidden = true
            imgCombiNumberTwo.isHidden = true
        } else {
            imgCombiNumberOne.isHidden = false
            imgArrow.isHidden = false
            imgCombiNumberTwo.isHidden = false
        }
    }
    
    func reloader_alphabets_order()
    {
        cnt = 0
        viewSigns.image = UIImage(named: "a")
        lbSelected.text = alphabets[cnt].uppercased()
        hideImageCombination(flag: true)
        viewSigns.isHidden = false
        buttonInitializer()
    }
    
    func reloader_alphabets_reversed()
    {
        cnt = 25
        viewSigns.image = UIImage(named: "z")
        lbSelected.text = alphabets[cnt].uppercased()
        hideImageCombination(flag: true)
        viewSigns.isHidden = false
        buttonInitializer()
    }
    
    func reloader_alphabets_confusing()
    {
        // Confusing var phase: [String: String] = ["LEV1":"abcdefhiklorstuvwy", "LEV2":"jz", "LEV3":"gmntkpq"]
        cnt = 0
        viewSigns.image = UIImage(named: confusingAlphabets[cnt])
        lbSelected.text = confusingAlphabets[cnt].uppercased()
        hideImageCombination(flag: true)
        viewSigns.isHidden = false
        buttonInitializer()
    }
    
    func reloader_numbers_order()
    {
        cnt = 0
        viewSigns.image = UIImage(named: "0")
        lbSelected.text = numbers[cnt]
        
        hideImageCombination(flag: true)
        viewSigns.isHidden = false
        
        buttonInitializer()
    }
    
    func reloader_numbers_reversed()
    {
        cnt = 9
        viewSigns.image = UIImage(named: "9")
        lbSelected.text = numbers[cnt]
        
        hideImageCombination(flag: true)
        viewSigns.isHidden = false
        
        buttonInitializer()
    }
    
    func reloader_numbers_combinated()
    {
        combiCnt = 0
        
        imgCombiNumberOne.isHidden = false
        imgCombiNumberTwo.isHidden = false
        viewSigns.isHidden = true
        hideImageCombination(flag : false)
        numberCombination()
        buttonInitializer()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if(selectedProgram == "30"){
            reloader_words_combinated()
        }
        
        // Camera
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
            else{
                print("No camera!")
                return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            stillImageOutput = AVCapturePhotoOutput()
            
            if(captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput))
            {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error{print("[ERR] Unable to initialize back camera: \(error.localizedDescription)")}
        
    }
    
    func updateAllContents()
    {
        switch selectedProgram {
        case "11":
            // Show next sign
            if(cnt < 25)
            {
                cnt = cnt + 1
                viewSigns.image = UIImage(named: alphabets[cnt])
                lbSelected.text = alphabets[cnt].uppercased()
            }
            else{
                btnTest.isHidden = false
                btnNext.isHidden = true
            }
            break
        case "12":
            if(cnt > 0) {
                cnt = cnt - 1
                viewSigns.image = UIImage(named: alphabets[cnt])
                lbSelected.text = alphabets[cnt].uppercased()
            } else {
                btnTest.isHidden = false
                btnNext.isHidden = true
            }
            break
        case "13":
            if(cnt+1 < confusingAlphabets.count)
            {
                cnt = cnt + 1
                viewSigns.image = UIImage(named: confusingAlphabets[cnt])
                lbSelected.text = confusingAlphabets[cnt].uppercased()
            }
            else
            {
                btnTest.isHidden = false
                btnNext.isHidden = true
            }
            break
        case "21":
            if cnt < 9 {
                cnt = cnt + 1
                viewSigns.image = UIImage(named: numbers[cnt])
                lbSelected.text = numbers[cnt]
            } else {
                btnTest.isHidden = false
                btnNext.isHidden = true
            }
            break
        case "22":
            if( cnt > 0 ) {
                cnt = cnt - 1
                viewSigns.image = UIImage(named: numbers[cnt])
                lbSelected.text = numbers[cnt]
            } else {
                btnTest.isHidden = false
                btnNext.isHidden = true
            }
            break
        case "23":
            // Combinations
            if(combiCnt < 5) {
                combiCnt = combiCnt + 1
                numberCombination()
            } else {
                btnTest.isHidden = false
                btnNext.isHidden = true
            }
            break
        case "30":
            if(animationNotFinished == true) { return }
            if(wordCnt + 1 < speedSample.count) {
                wordCnt = wordCnt + 1
                repeatAnimation(targetString: speedSample[wordCnt])
                
            } else
            {
                btnNext.isHidden = true
                btnRepeat.isHidden = true
                btnTest.isHidden = false
            }
            break
            
        default:
            break
        }
    }
    
    func numberCombination()
    {
        num1 = Int.random(in: 1..<9)
        num2 = Int.random(in: 0..<9)
        lbSelected.text = String(num1)+String(num2)
        imgCombiNumberOne.image = UIImage(named: numbers[num1])
        imgCombiNumberTwo.image = UIImage(named: numbers[num2])
    }
    
    func setupLivePreview()
    {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        videoPreviewLayer.connection?.automaticallyAdjustsVideoMirroring = false
        videoPreviewLayer.connection?.isVideoMirrored = false
//        videoPreviewLayer.flip
        viewCamera.layer.addSublayer(videoPreviewLayer)
    
        
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.viewCamera.bounds
            }
        }
    }
    
    
    @IBAction func btnPressedReload(_ sender: Any) {
        print("Reload!!")
        isFinished = false
        
        switch selectedProgram {
        case "11":
            reloader_alphabets_order()
            break
        case "12":
            reloader_alphabets_reversed()
            break
        case "13":
            reloader_alphabets_confusing()
            break
        case "21":
            reloader_numbers_order()
            break
        case "22":
            reloader_numbers_reversed()
            break
        case "23":
            reloader_numbers_combinated()
            break
        case "30":
            reloader_words_combinated()
            break
            
        default:
            break
        }
    }
    
    @IBAction func btnPressedTesting(_ sender: Any) {
        self.performSegue(withIdentifier: "segueTesting", sender: selectedProgram)
    }
    @IBAction func btnPressedBack(_ sender: Any) {
        super.btnPressedBack()
    }
    
    @IBAction func btnPressedNext(_ sender: Any) {
        updateAllContents()
    }
    
    @IBAction func btnPressedRepeat(_ sender: Any) {
        repeatAnimation(targetString: speedSample[wordCnt])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var item: String! = ""
        
        if (selectedProgram == "11" || selectedProgram == "12" || selectedProgram ==  "13" || selectedProgram == "30")
        {
            item = "10"
        }
        else // (selectedProgram == "21" || selectedProgram == "22" || selectedProgram == "23")
            {
                item = "20"
        }
        
        if segue.identifier == "segueTesting" {
            if let vc = segue.destination as? TestingViewController {
                vc.selectedProgram = item
            }
        }
    }
    
    @IBAction func btnPressedSpeedUp(_ sender: Any) {
        if(speed > 2.0) {return}
        if(animationNotFinished == true) {return}
        speed = speed + 0.1
        lbSpeed.text = String(format: "x%0.1f", self.speed)
        btnPressedRepeat(self)
    }
    
    @IBAction func btnPressedSpeedDown(_ sender: Any) {
        if(speed < 0.5) { return }
        if(animationNotFinished == true) {return}
        speed = speed - 0.1
        lbSpeed.text = String(format: "x%0.1f", self.speed)

        btnPressedRepeat(self)
    }
    
}
