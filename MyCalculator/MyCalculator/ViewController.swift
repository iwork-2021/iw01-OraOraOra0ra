//
//  ViewController.swift
//  MyCalculator
//
//  Created by wenge on 2021/9/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.displayLabel.text! = "0"
        
    }
    
    var digitOnDisplay: String{
        get{
            return self.displayLabel.text!
        }
        
        set{
            self.displayLabel.text! = newValue
        }
    }
    
    var inTypingMode = false
    var inTypingDot = false
    
    @IBAction func numberTouched(_ sender: UIButton) {
        if(inTypingDot==false || (inTypingDot==true&&sender.currentTitle != ".")){
            if(sender.currentTitle=="."){
                inTypingDot = true
            }
            
            if inTypingMode {
                digitOnDisplay = digitOnDisplay + sender.currentTitle!
            }
            else {
                digitOnDisplay = sender.currentTitle!
                inTypingMode = true
            }
        }
    }
    
    let calculator = Calculator()
    
    @IBAction func operatorTouched(_ sender: UIButton) {
        if let op = sender.currentTitle {
            if let result = calculator.performOperation(operation: op, operand: Double(digitOnDisplay)!) {
                digitOnDisplay = String(result)
            }
            
            inTypingMode = false
            inTypingDot = false
        }
    }
    
    
}

