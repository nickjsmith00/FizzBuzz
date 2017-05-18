//
//  gameSettingsViewController.swift
//  FizzBuzz
//  Settings and Setup before each gameplay of FizzBuzz
//
//  Created by NICHOLAS JOHN SMITH on 27/04/2017.
//  Modified By NICHOLAS JOHN SMITH and STEPHEN BIRSA.
//  Last Modified: 18/05/2017
//  Copyright © 2017 Nicholas Smith. All rights reserved.
//
import UIKit
class gameSettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var CounterInfo:UILabel!
    @IBOutlet weak var ErrorStartGame:UILabel!
    @IBOutlet weak var DifficultyOutlet:UISegmentedControl!
    @IBOutlet weak var FizzSelector:UIPickerView!
    @IBOutlet weak var BuzzSelector:UIPickerView!
    private var fizzItems:[Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    private var buzzItems:[Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    @IBOutlet weak var StartGameBtn:UIButton!
    //timer
    private var updateTimer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Global.defaultSettings() //reset settings each time after quit gameplay or when loading this viewController
        startTimer()//enable event and error checking
        //basic setup
        ErrorStartGame.text = ""
        StartGameBtn.isEnabled = false
        FizzSelector.dataSource = self
        FizzSelector.delegate = self
        BuzzSelector.dataSource = self
        BuzzSelector.delegate = self
        //set fizz and buzz to default picker values
        FizzSelector.selectRow(Global.fizzNumber - 1, inComponent: 0, animated: true) //default fizz = 3
        BuzzSelector.selectRow(Global.buzzNumber - 1, inComponent: 0, animated: true) //default buzz = 5
        //make sure difficulty is set as medium by default
        DifficultyOutlet.selectedSegmentIndex = 1 //medium on difficultySelector
        DifficultyOutlet.sendActions(for: UIControlEvents.valueChanged) //update difficultySelector
        //set info on screen
        changeInfo()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Dispose of any resources before disappearing
        stopTimer() //ends timer so timer is not continuing in another viewController
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
    private func changeInfo() -> Void {
        CounterInfo.text = "Counter will increase every \(Int(Global.timerSpeed)) seconds"
        if (Global.difficulty == "insane") {
            Global.insaneCounter = true
        } else {
            Global.insaneCounter = false
        }
    }
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
    internal func settingsEvent() -> Void {
        if (Global.fizzNumber == Global.buzzNumber) {
            StartGameBtn.isEnabled = false
            ErrorStartGame.text = "Fizz and Buzz number cannot be the same!"
        } else {
            StartGameBtn.isEnabled = true
            ErrorStartGame.text = ""
        }
    }
    private func startTimer() -> Void {
        if updateTimer == nil {
            updateTimer = Timer.scheduledTimer(
                timeInterval: 1, target: self, selector: #selector(settingsEvent), userInfo: nil, repeats: true
            )
        }
    }
    private func stopTimer() -> Void {
        if updateTimer != nil {
            updateTimer?.invalidate()
            updateTimer = nil
        }
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
