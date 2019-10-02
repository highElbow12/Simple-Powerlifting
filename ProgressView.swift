//
//  ProgressView.swift
//  Simple Powerlifting
//
//  Created by Sungjea Cho on 3/23/17.
//  Copyright © 2017 chillmo. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class ProgressView: UIViewController {
    
    var currentBench: Bench?
    var currentSquat: Squat?
    var currentDeadlift: Deadlift?
    
    
    @IBOutlet weak var squatEntry: UITextField!
  
   
    @IBOutlet weak var benchEntry: UITextField!
    
    @IBOutlet weak var deadliftEntry: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProgressView.dismissKeyboard))
        view.addGestureRecognizer(tap)
       
        
        squatLabel.adjustsFontSizeToFitWidth = true
        benchLabel.adjustsFontSizeToFitWidth = true
        deadliftLabel.adjustsFontSizeToFitWidth = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabels()
        self.subscribeToKeyboardNotifications()
        
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
   
   
    
    
    @IBAction func squatField(_ sender: Any) {
        
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let stack = delegate.stack
        
        guard let a = Double(squatEntry.text!) else{
            displayError(errorString: "Oops. Enter a weight.")
            return
        }
        
        if(a>=45 && a<=2000 && a.truncatingRemainder(dividingBy: 2.5)==0){
            currentSquat = Squat(weight: a, context: stack.context)
            stack.save()
            updateLabels()
        }
            
        else{
            displayError(errorString: "Oops. Enter a weight that is a multiple of 2.5 lbs and between 45(just the bar) and 2000 lbs(anything above is humanly impossible).")
        }
        
        squatEntry.text = nil
       
    
    }
    
    
    @IBAction func benchField(_ sender: Any) {
        
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let stack = delegate.stack
        
        guard let a = Double(benchEntry.text!) else{
            displayError(errorString: "Oops. Enter a weight.")
            return
        }
        
        if(a>=45 && a<=2000 && a.truncatingRemainder(dividingBy: 2.5)==0){
            currentBench = Bench(weight: a, context: stack.context)
            stack.save()
            updateLabels()
        }
            
        else{
            displayError(errorString: "Oops. Enter a weight that is a multiple of 2.5 lbs and between 45(just the bar) and 2000 lbs(anything above is humanly impossible).")
        }
        
        benchEntry.text = nil
        
        
    }
    
    @IBAction func deadliftField(_ sender: Any) {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let stack = delegate.stack
        
        guard let a = Double(deadliftEntry.text!) else{
            displayError(errorString: "Oops. Enter a weight.")
            return
        }
        
        if(a>=45 && a<=2000 && a.truncatingRemainder(dividingBy: 2.5)==0){
            currentDeadlift = Deadlift(weight: a, context: stack.context)
            stack.save()
            updateLabels()
        }
            
        else{
            displayError(errorString: "Oops. Enter a weight that is a multiple of 2.5 lbs and between 45(just the bar) and 2000 lbs(anything above is humanly impossible).")
        }
        
        deadliftEntry.text = nil
        
        
    }
    private func updateLabels(){
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let stack = delegate.stack
        
        let squatRequest: NSFetchRequest<Squat> = Squat.fetchRequest()
        let benchRequest: NSFetchRequest<Bench> = Bench.fetchRequest()
        let deadliftRequest: NSFetchRequest<Deadlift> = Deadlift.fetchRequest()
        
        var squats:[Squat] = []
        var benchs:[Bench] = []
        var deads:[Deadlift] = []
        
        
        
        do {
            let squatResults = try stack.context.fetch(squatRequest)
            let benchResults = try stack.context.fetch(benchRequest)
            let deadResults = try stack.context.fetch(deadliftRequest)
            
            squats = squatResults
            benchs = benchResults
            deads = deadResults
            
        } catch let error as NSError {
            print("An error occured accessing managed object context \(error.localizedDescription)")
        }
        if squats.count > 0 {
            currentSquat = squats[(squats.count) - 1]
            squatLabel.text = "SQUAT = " + String(Int(currentSquat!.weight)) + " lbs"
        }
        if benchs.count > 0 {
            currentBench = benchs[(benchs.count) - 1]
            benchLabel.text = "BENCH = " + String(Int(currentBench!.weight)) + " lbs"
        }
        if deads.count > 0 {
            currentDeadlift = deads[(deads.count) - 1]
            deadliftLabel.text = "DEADLIFT = " + String(Int(currentDeadlift!.weight)) + " lbs"
        }
        
        
        
        

        
    }
    
    
    private func displayError(errorString: String?) {
        performUIUpdatesOnMain {
            let alert = UIAlertController(title: "Error", message: errorString, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    @IBOutlet weak var squatLabel: UILabel!
    
    
    @IBOutlet weak var benchLabel: UILabel!
    
    @IBOutlet weak var deadliftLabel: UILabel!
    
    
    
    
    
}
extension ProgressView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(ProgressView.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ProgressView.keyboardWillHide(_:)) , name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    func keyboardWillShow(_ notification: Notification) {
        if squatEntry.isFirstResponder{
            self.view.frame.origin.y = 0
        }
        if benchEntry.isFirstResponder{
            self.view.frame.origin.y = 0
        }
        
        if deadliftEntry.isFirstResponder{
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


