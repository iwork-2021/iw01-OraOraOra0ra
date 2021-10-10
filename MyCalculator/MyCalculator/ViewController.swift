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
    
    @IBOutlet weak var Rad_Deg: UIButton!
    
    @IBAction func operatorTouched(_ sender: UIButton) {
        if let op = sender.currentTitle {
            if op == "Rad"{
                Rad_Deg.setTitle("Deg", for: .normal)
            }
            else if op == "Deg"{
                Rad_Deg.setTitle("Rad", for: .normal)
            }
            
            if let result = calculator.performOperation(operation: op, operand: Double(digitOnDisplay)!) {
                let tmp = String(round(1e13*result)/1e13)
                let res = Double(tmp)
                if res! < 1E18 && Double(Int(result)) == result{
                    digitOnDisplay = String(Int(res!))
                }
                else{
                    digitOnDisplay = String(res!)
                }
            }
            
            inTypingMode = false
            inTypingDot = false
        }
    }
    
    
    
    @IBOutlet weak var e2y: UIButton!
    @IBOutlet weak var ten2two: UIButton!
    @IBOutlet weak var ln2logy: UIButton!
    @IBOutlet weak var two2ten: UIButton!
    @IBOutlet weak var sin: UIButton!
    @IBOutlet weak var cos: UIButton!
    @IBOutlet weak var tan: UIButton!
    @IBOutlet weak var sinh: UIButton!
    @IBOutlet weak var cosh: UIButton!
    @IBOutlet weak var tanh: UIButton!
        
    var flag = false
    @IBAction func Swap(_ sender: UIButton) {
        if flag {
            e2y.setTitle("eˣ", for: .normal)
            ten2two.setTitle("10ˣ", for: .normal)
            ln2logy.setTitle("ln", for: .normal)
            two2ten.setTitle("log₁₀", for: .normal)
            sin.setTitle("sin", for: .normal)
            cos.setTitle("cos", for: .normal)
            tan.setTitle("tan", for: .normal)
            sinh.setTitle("sinh", for: .normal)
            cosh.setTitle("cosh", for: .normal)
            tanh.setTitle("tanh", for: .normal)
            flag = false
        }
        else{
            e2y.setTitle("yˣ", for: .normal)
            ten2two.setTitle("2ˣ", for: .normal)
            ln2logy.setTitle("logy", for: .normal)
            two2ten.setTitle("log2", for: .normal)
            sin.setTitle("asin", for: .normal)
            cos.setTitle("acos", for: .normal)
            tan.setTitle("atan", for: .normal)
            sinh.setTitle("asinh", for: .normal)
            cosh.setTitle("acosh", for: .normal)
            tanh.setTitle("atanh", for: .normal)
            flag = true
        }
    }
}

