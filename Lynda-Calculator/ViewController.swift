//
//  ViewController.swift
//  Lynda-Calculator
//
//  Created by ali chaudhry on 6/20/18.
//  Copyright © 2018 ali chaudhry. All rights reserved.
//  Lynda Course - Programming for Non-Programmers: iOS 11 and Swift

import UIKit

enum modes {
    case not_set
    case addition
    case subtraction
    case multiplication
}

class ViewController: UIViewController {
    @IBOutlet weak var topLabel: UILabel!
    
    var labelString:String = "0"
    var currentMode:modes = .not_set
    var savedNum:Int = 0
    var lastButtonWasMode:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pushedAddition(_ sender: Any) {
        changeMode(newMode: .addition)
    }
    
    @IBAction func pushedSubtraction(_ sender: Any) {
        changeMode(newMode: .subtraction)
    }
    
    @IBAction func pushMultiplication(_ sender: Any) {
        changeMode(newMode: .multiplication)
    }
    
    @IBAction func pushedEquals(_ sender: Any) {
        guard let labelInt:Int = Int(labelString) else {
            return
        }
        if (currentMode == .not_set || lastButtonWasMode) {
            return
        }
        if currentMode == .addition {
            savedNum += labelInt
        } else if currentMode == .subtraction {
            savedNum -= labelInt
        } else if currentMode == .multiplication {
            savedNum *= labelInt
        }
        
        currentMode = .not_set
        labelString = "\(savedNum)"
        updateText()
        lastButtonWasMode = true
    }
    
    @IBAction func pushedClear(_ sender: Any) {
        clearText()
    }
    
    @IBAction func pushedNumber(_ sender: UIButton) {
        if lastButtonWasMode {
            lastButtonWasMode = false
            labelString = "0"
        }
        
        let stringValue:String? = sender.titleLabel?.text
        
        labelString = labelString.appending(stringValue!)
        updateText()
        
    }
    
    func updateText() {
        guard let labelInt:Int = Int(labelString) else {
            return
        }
        
        if(currentMode == .not_set) {
            savedNum = labelInt
        }
        
        let formatter:NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let num:NSNumber = NSNumber(value: labelInt)
        
        topLabel.text = formatter.string(from: num)
    }
    
    func clearText() {
        labelString = "0"
        topLabel.text = "0"
        savedNum = 0
        lastButtonWasMode = false
        currentMode = .not_set
    }
    
    func changeMode(newMode:modes) {
        if(savedNum == 0) {
            return
        }
        
        currentMode = newMode
        lastButtonWasMode = true
    }
}

