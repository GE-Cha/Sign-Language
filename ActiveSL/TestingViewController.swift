//
//  TestingViewController.swift
//  ActiveSL
//
//  Created by GoEum Cha on 11/19/18.
//  Copyright © 2018 GoEum Cha. All rights reserved.
//

import UIKit
import AVKit
import Vision
import CoreML


class TestingViewController: ViewController, AVCaptureVideoDataOutputSampleBufferDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var selectedProgram : String = ""
    var cnt: NSInteger!
//    var testingAlphabets: [String] = ["a", "b", "e", "h", "i", "o", "u"]
    var testingAlphabets: [String] = ["a", "b", "c", "h"]
    var testingSamples: [String] = ["a", "h", "c", "b"]
    var testingNumbers: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    var recognizerNumberCnt: NSInteger!
    var totalCnt :NSInteger = 10
    var proceeded :NSInteger! = 1
    
    // View: Type the answer of sign image
    @IBOutlet weak var viewQuestion: UIView!
    @IBOutlet weak var questionSign: UIImageView!
    @IBOutlet weak var txTypein: UITextField!
    @IBOutlet weak var lbQuestionCnt: UILabel!
    @IBOutlet weak var lbQuestionResult: UILabel!
    
    // View: Recognize the sign that user made
    @IBOutlet weak var viewRecognizer: UIView!
    @IBOutlet weak var viewRecognizedResult: UIImageView!
    @IBOutlet weak var lbPredictionResult: UILabel!
    @IBOutlet weak var lbPredictionQuest: UILabel!
    @IBOutlet weak var lbPredictionCount: UILabel!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    var targetString :String = ""
    
    @IBOutlet weak var csTop: NSLayoutConstraint!
    let imagePicker = UIImagePickerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        proceeded = 1
        totalCnt = 10
        
        lbPredictionResult.text = ""
        
        self.txTypein.delegate = self
        
//        let center = NotificationCenter.default
//        center.addObserver(self, selector: #selector(keyboardWillBeShown(note:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        cnt = -1
        
        if(selectedProgram.hasSuffix("0")) { //10, 20
            print("Recognizer__DO")
            view.bringSubviewToFront(viewRecognizer)
            
            if(selectedProgram.hasPrefix("1"))
            {
                // Alphabet
//                cnt = Int.random(in: 0..<testingAlphabets.count)
//                lbPredictionQuest.text = getTrialString(target: testingAlphabets[cnt])
//                lbPredictionCount.text = getCountString(current :1, cnt :testingAlphabets.count)
                cnt = cnt + 1
                lbPredictionQuest.text = getTrialString(target: testingSamples[cnt])
                lbPredictionCount.text = getCountString(current :1, cnt :testingSamples.count)
            }
            else    // 20, 21   // 숫자
            {
                cnt = Int.random(in: 0..<testingNumbers.count)
                 lbPredictionQuest.text = getTrialString(target: testingNumbers[cnt])
                lbPredictionCount.text = getCountString(current :1,  cnt:testingNumbers.count)
            }
        }
        
        if selectedProgram.hasSuffix("1") { // 11 21
            print("Understand__ READ")
            view.bringSubviewToFront(viewQuestion)
            
            if(selectedProgram.hasPrefix("1"))
            {
                // Understand alphabets
                cnt = Int.random(in:0..<alphabets.count)
                questionSign.image = UIImage(named: alphabets[cnt])
                lbQuestionCnt.text = getCountString(current: proceeded, cnt: alphabets.count)
            }
            else
            {
                // Understand numbers
                cnt = Int.random(in: 0..<numbers.count)
                questionSign.image = UIImage(named: numbers[cnt])
                lbQuestionCnt.text = getCountString(current: proceeded, cnt: numbers.count)
            }
            
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func getCountString(current :NSInteger, cnt :NSInteger) -> String
    {
        let result :String = String(format: "(\(current) / \(cnt))")
        return result
        
    }
    
    func getTrialString(target: String) -> String
    {
        targetString = target
        let result: String = String(format: "Try \(target.uppercased())")
        print("getTrialString: \(result)")
        return result
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        guard let model = try? VNCoreMLModel(for: signlang().model) else { return }
        let request = VNCoreMLRequest(model: model) { (finishedReq, err) in
            
            guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
            guard let firstObservation = results.first else { return }
            
            print(firstObservation.identifier, firstObservation.confidence)
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
//            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .default))
//            present(ac, animated: true)
            print("Save Error!")
        } else {
            print("Saved!")
//            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .default))
//            present(ac, animated: true)
        }
    }
    
    @IBAction func btnEnterPressed(_ sender: Any) {
        txTypein.resignFirstResponder()
        proceeded = proceeded + 1
        
        checkAnswerOfQuestion()
        
        if selectedProgram.hasSuffix("1") { // 11 21

            if(selectedProgram.hasPrefix("1"))
            {
                if(proceeded > alphabets.count)
                {
                    btnNext.isHidden = true
                    btnCamera.isHidden = true
                    return
                }
                else {
                    // Understand alphabets
                    /// HERE!!!!
//                    cnt = Int.random(in:0..<alphabets.count)
                    cnt = cnt + 1
                    questionSign.image = UIImage(named: alphabets[cnt])
                    lbQuestionCnt.text = getCountString(current: proceeded, cnt: alphabets.count)

                }
               
            }
            else
            {
                if(proceeded > numbers.count)
                {
                    btnNext.isHidden = true
                    btnCamera.isHidden = true
                    return
                }
                else{
                    // Understand numbers
                    cnt = Int.random(in: 0..<numbers.count)
                    questionSign.image = UIImage(named: numbers[cnt])
                    lbQuestionCnt.text = getCountString(current: proceeded, cnt: numbers.count)
                }
            }
        }
    }
    
    @IBAction func btnPressedBack(_ sender: Any) {
//        super.btnPressedBack()
        navigationController?.popToRootViewController(animated: true)
    }
    
   // Recognition
    @IBAction func btnNextQuestionPressed(_ sender: Any) {
        
        proceeded = proceeded + 1
        lbPredictionResult.text = ""
        
        if(selectedProgram.hasSuffix("0")) { //10, 20
//            print("Recognizer__DO")
//            view.bringSubviewToFront(viewRecognizer)
            
            if(selectedProgram.hasPrefix("1"))
            {
                if(proceeded > testingAlphabets.count)
                {
                    btnCamera.isHidden = true
                    btnNext.isHidden = true
                    lbPredictionResult.text = "This test is done"
                }
                else
                {
                    // Alphabet
//                    cnt = Int.random(in: 0..<testingAlphabets.count)
//                    lbPredictionQuest.text = getTrialString(target: testingAlphabets[cnt])
//                    lbPredictionCount.text = getCountString(current :proceeded, cnt :testingAlphabets.count)
                    cnt = cnt + 1
                    lbPredictionQuest.text = getTrialString(target: testingSamples[cnt])
                    lbPredictionCount.text = getCountString(current :proceeded, cnt :testingSamples.count)
                }
            }
            else    // 20, 21   // 숫자
            {
                if(proceeded > testingNumbers.count)
                {
                    btnCamera.isHidden = true
                    btnNext.isHidden = true
                    lbPredictionResult.text = "This test is done"
                } else
                {
                    cnt = Int.random(in: 0..<testingNumbers.count)
                    lbPredictionQuest.text = getTrialString(target: testingNumbers[cnt])
                    lbPredictionCount.text = getCountString(current :proceeded,  cnt:testingNumbers.count)
                }
            }
        }
        else // Do signing
        {
            if(selectedProgram.hasPrefix("1"))
            {
                if(proceeded > alphabets.count)
                {
//                    btnCamera.isHidden = true
//                    btnNext.isHidden = true
                    lbQuestionResult.text = "This test is done"
                }
                else
                {
                    // Alphabet
//                    cnt = Int.random(in: 0..<alphabets.count)  ///// HERE!!
                    cnt = cnt + 1
                    questionSign.image = UIImage(named:String(format: "%@", alphabets[cnt]))
                    lbQuestionCnt.text = getCountString(current :proceeded, cnt :alphabets.count)
                }
            }
            else    // 20, 21   // 숫자
            {
                if(proceeded > numbers.count)
                {
//                    btnCamera.isHidden = true
//                    btnNext.isHidden = true
                    lbQuestionResult.text = "This test is done"
                } else
                {
                    cnt = Int.random(in: 0..<numbers.count)
                    questionSign.image = UIImage(named:String(format: "%@", numbers[cnt]))
                    lbQuestionCnt.text = getCountString(current :proceeded, cnt :numbers.count)
                }
            }
        }
        
    }
    
    
    @IBAction func btnCapturePressed(_ sender: Any) {
    if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.cameraDevice = .front
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
            
            
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textfield: txTypein, moveDistance: -250, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textfield: txTypein, moveDistance: -250, up: false)
    }
    
    func moveTextField(textfield: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance: -moveDistance)
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            // Set the image view
            viewRecognizedResult.contentMode = .scaleAspectFill
            viewRecognizedResult.image = pickedImage
            UIImageWriteToSavedPhotosAlbum(viewRecognizedResult.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
            
            // Get the model
            guard let model = try? VNCoreMLModel(for: handmodel().model) else {
                fatalError("Unable to load model")
            }
            
            // Create vision request
            let request = VNCoreMLRequest(model: model) {[weak self] request, error in
                guard let results = request.results as? [VNClassificationObservation],
                    let topResult = results.first
                    else {
                        fatalError("Unexpected results")
                }
                
                // Update the main UI thread with our result
                DispatchQueue.main.async {[weak self] in
                    if(topResult.confidence * 100 < 75) {
                        self?.lbPredictionResult.text = "Cannot recognize the result"
                    }
                    else {
//                        self?.lbPredictionResult.text = "\(topResult.identifier) with \(Int(topResult.confidence * 100))% confidence"
                        self?.lbPredictionResult.text = "\(topResult.identifier)"
                        
                        if(topResult.identifier.lowercased() == self?.targetString.lowercased())
                        {
                            self?.lbPredictionResult.text = "Correct!"
                        }
                        else
                        {
                            self?.lbPredictionResult.text = "Wrong!"
                        }
                    }
                    print(results)
                }
            }
            
            guard let ciImage = CIImage(image: pickedImage)
                else { fatalError("Cannot read picked image")}
            
            // Run the classifier
            let handler = VNImageRequestHandler(ciImage: ciImage)
            DispatchQueue.global().async {
                do {
                    try handler.perform([request])
                } catch {
                    print(error)
                }
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
//    @objc func keyboardWillBeShown(note: Notification) {
//        UIView.animate(withDuration: 0.5, animations: {
////            self.csTop.constant = -50
//        })
//    }
//
//    @objc func keyboardWillBeHidden(note: Notification) {
////        csTop.constant = 53
//    }
    
    func checkAnswerOfQuestion()
    {
        if(selectedProgram.hasSuffix("1"))
        {
            if(selectedProgram.hasPrefix("1"))
            {
                // Understand alphabets
//                cnt = Int.random(in:0..<alphabets.count)
//                questionSign.image = UIImage(named: alphabets[cnt])
//                lbQuestionCnt.text = getCountString(current: proceeded, cnt: alphabets.count)
                if(txTypein.text == alphabets[cnt])
                {
                    print("Correct")
                    self.lbQuestionResult.text = "Correct!"
                    givingDelay()
                }
                else {
                    // Wrong
                    self.lbQuestionResult.text = "Wrong!"
                    givingDelay()
                }
            }
            else
            {
                // Understand numbers
//                cnt = Int.random(in: 0..<numbers.count)
//                questionSign.image = UIImage(named: numbers[cnt])
//                lbQuestionCnt.text = getCountString(current: proceeded, cnt: numbers.count)
                if(txTypein.text == numbers[cnt])
                {
                    print("correct!")
                    self.lbQuestionResult.text = "Correct!"
                    givingDelay()
                    
                }
                else {
                    // Wrong
                    print("wrong!")
                    self.lbQuestionResult.text = "Wrong!"
                    givingDelay()
                }
            }
            
            UIView.commitAnimations()

        }
        txTypein.text = ""
        
    }
    
    func givingDelay()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            // Put your code which should be executed with a delay here
            self.lbQuestionResult.text = ""
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        checkAnswerOfQuestion()
        btnNextQuestionPressed(self)
        return false
    }
    
}
