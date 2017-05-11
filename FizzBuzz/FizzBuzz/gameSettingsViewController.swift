//
//  gameSettingsViewController.swift
//  FizzBuzz
//
//  Created by NICHOLAS JOHN SMITH on 27/04/2017.
//  Copyright © 2017 Nicholas Smith. All rights reserved.
//

import UIKit

class gameSettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var CounterInfo: UILabel!
    @IBOutlet weak var FizzSelector: UIPickerView!
    @IBOutlet weak var BuzzSelector: UIPickerView!
    private var fizzItems = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    private var buzzItems = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    @IBOutlet weak var StartGameBtn: UIButton!
    @IBOutlet weak var ErrorStartGame: UILabel!
    //timer
    private var updateTimer:Timer!

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if (pickerView == FizzSelector) {
            return 1 //how many picker views in 1, set for rows
        } else if (pickerView == BuzzSelector) {
            return 1 //how many picker views in 1, set for rows
        }
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == FizzSelector) {
            return fizzItems.count //how many items there are
        } else if (pickerView == BuzzSelector) {
            return buzzItems.count //how many items there are
        }
        return fizzItems.count
    }
    public func pickerView(_ pickerView:UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == FizzSelector) {
            return "\(fizzItems[row])" //display fizz number
        } else if (pickerView == BuzzSelector) {
            return "\(buzzItems[row])" //display buzz number
        }
        return "\(fizzItems[row])"
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == FizzSelector) {
            Global.fizzNumber = fizzItems[row] //apply function
        } else if (pickerView == BuzzSelector) {
            Global.buzzNumber = buzzItems[row] //apply function
        }
    }
    
    internal func settingsEvent() {
        if (Global.fizzNumber == Global.buzzNumber) {
            StartGameBtn.isEnabled = false
            ErrorStartGame.text = "Cannot have same fizz and buzz number!"
        } else {
            StartGameBtn.isEnabled = true
            ErrorStartGame.text = ""
        }
    }
    private func startTimer() {
        if updateTimer == nil {
            updateTimer = Timer.scheduledTimer(
                timeInterval: 1, target: self, selector: #selector(settingsEvent), userInfo: nil, repeats: true
            )
        }
    }
    private func stopTimer() {
        if updateTimer != nil {
            updateTimer?.invalidate()
            updateTimer = nil
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ErrorStartGame.text = ""
        StartGameBtn.isEnabled = false
        startTimer()
        FizzSelector.dataSource = self
        FizzSelector.delegate = self
        BuzzSelector.dataSource = self
        BuzzSelector.delegate = self
        FizzSelector.selectRow(3-1, inComponent: 0, animated: true)
        BuzzSelector.selectRow(5-1, inComponent: 0, animated: true)
        // Do any additional setup after loading the view.
        Global.timerSpeed = 3 //easy by default
        Global.fizzNumber = 3 //easy by default
        Global.buzzNumber = 5 //easy by default
        Global.insaneCounter = false //insane not enabled
        changeInfo() //set info on screen
    }
    
    private func changeInfo() -> Void {
        CounterInfo.text = "Counter will increase every \(Int(Global.timerSpeed)) seconds"
        if (Global.difficulty == "insane") {
            Global.insaneCounter = true
        } else {
            Global.insaneCounter = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func DifficultyControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            Global.difficulty = "easy"
            Global.timerSpeed = 3
            changeInfo()
        case 1:
            Global.difficulty = "medium"
            Global.timerSpeed = 2
            changeInfo()
        case 2:
            Global.difficulty = "hard"
            Global.timerSpeed = 1
            changeInfo()
        case 3:
            Global.difficulty = "insane"
            Global.timerSpeed = 1
            changeInfo()
        default:
            Global.difficulty = "insane"
            Global.timerSpeed = 1
            changeInfo()
            break;
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Dispose of any resources before disappearing
        stopTimer() //ends timer so timer is not continuing in another viewController
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
