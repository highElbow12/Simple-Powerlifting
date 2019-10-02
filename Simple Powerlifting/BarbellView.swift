//
//  BarbellView.swift
//  Simple Powerlifting
//
//  Created by Sungjea Cho on 3/19/17.
//  Copyright © 2017 chillmo. All rights reserved.
//

import Foundation
import UIKit

class BarbellView: UIViewController {
    
    var array: [Int]?
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.subscribeToKeyboardNotifications()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProgressView.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        for views in self.stackView.arrangedSubviews as [UIView] {
            if let label = views as? UILabel{
                label.text = ""
            }
        }
        
        for case let label as UILabel in self.stackView.arrangedSubviews {
            label.adjustsFontSizeToFitWidth = true
        }
        
        prompt.title = "BARBELL CALCULATOR. ENTER WEIGHT"

    }

    override func viewWillDisappear(_ animated: Bool) {
        
        self.unsubscribeFromKeyboardNotifications()
    }
    
    
    @IBOutlet weak var prompt: UINavigationItem!
   
    //label outlets
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    
    @IBOutlet weak var weight: UITextField!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBAction func weightEntered(_ sender: Any) {
        
        prompt.title = "ON EACH SIDE OF BARBELL ADD"
        
        let barbell = BarbellCalculator()
        let arrey = ["45 lbs", "35 lbs", "25 lbs", "10 lbs", "5 lbs", "2.5 lbs"]
        var x = 0
        
        
        guard let a = Double(weight.text!) else{
            displayError(errorString: "Oops. Enter a weight.")
            return
        }
        
        if(a>=45 && a<=2000 && a.truncatingRemainder(dividingBy: 2.5)==0){
            
            barbell.fillArray(weight: a)
            print(barbell.array)
            
            for views in self.stackView.arrangedSubviews as [UIView] where barbell.array.count > x  {
                if let label = views as? UILabel {
                    if barbell.array[x] != 0 {
                        label.text = ("\(barbell.array[x])" + " x " + "\(arrey[x])")
                        print(label.text!)
                    }
                    else{
                        label.text = ""
                    }
                }
                x += 1
            }
            
            
        }
            
        else{
            displayError(errorString: "Oops. Enter a weight that is a multiple of 2.5 lbs and between 45(just the bar) and 2000 lbs(anything above is humanly impossible).")
        }
        
    }
    
    private func displayError(errorString: String?) {
        performUIUpdatesOnMain {
            let alert = UIAlertController(title: "Error", message: errorString, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
}



extension BarbellView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(BarbellView.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BarbellView.keyboardWillHide(_:)) , name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    func keyboardWillShow(_ notification: Notification) {
        if weight.isFirstResponder{
            self.view.frame.origin.y = getKeyboardHeight(notification) * (-1)
        }
       
        
    }
    
    func keyboardWillHide(_ notification: Notification) {
        self.view.frame.origin.y=0
    }
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = (notification as NSNotification).userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func unsubscribeFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}


