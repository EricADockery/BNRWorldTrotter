//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Eric Dockery on 1/3/17.
//  Copyright © 2017 Eric Dockery. All rights reserved.
//

import UIKit

class ConversionViewController: ViewController {
    var emptyValue = "????"
    var fahrenheitValue: Double? {
        didSet {
            updateCelciusLabel()
        }
    }
    
    var celsiusValue: Double? {
        if let value = fahrenheitValue {
            return (value-32) * (5/9)
        }
        else {
            return nil
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    } ()

    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var fahrenheitTextField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBackgroundBasedOnTimeOfDay()
    }
    
    func updateCelciusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.string(for: value)
        }
        else {
            celsiusLabel.text = emptyValue
        }
    }
 
    func setBackgroundBasedOnTimeOfDay() {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        if (hour >= 12 && hour <= 15) {
            view.backgroundColor = UIColor.brown
        }
        else if ( hour > 15) {
            view.backgroundColor = UIColor.black
        }
        else {
            view.backgroundColor = UIColor.blue
        }
    }
    
    
    @IBAction func fahrenheitFieldEditingChanged(_ sender: UITextField) {
        if let text = sender.text, let number = numberFormatter.number(from: text) {
            fahrenheitValue = number.doubleValue
        }
        else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        fahrenheitTextField.resignFirstResponder()
    }
 
}

extension ConversionViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentLocal = NSLocale.current
        let decimalSeperator = currentLocal.decimalSeparator
        let exisitingTextHasDecimalSeparator = textField.text?.range(of: decimalSeperator!)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeperator!)
        
        //Bronze Challenge
        let alphabeticalLetters = CharacterSet.letters
        if (exisitingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil) || ((string.rangeOfCharacter(from: alphabeticalLetters, options: .caseInsensitive)) != nil) {
            return false
        }
        else {
            return true
        }
    }
}


