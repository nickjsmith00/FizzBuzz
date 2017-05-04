//
//  gameViewController.swift
//  FizzBuzz
//
//  Created by NICHOLAS JOHN SMITH on 27/04/2017.
//  Modified by STEPHEN BIRSA and NICHOLAS JOHN SMITH.
//  Copyright © 2017 Nicholas Smith. All rights reserved.
//
import UIKit
class gameViewController: UIViewController {
    //logic
    private var counter:Int = 1 //can start at 1 or the first divisible number of fizz/buzz
    private var buttonPressed:Bool = false
    //timer
    private var updateTimer:Timer?
    private var timerSpeed:Double = 1
    //textfields
    @IBOutlet weak var counterTextField: UILabel!
    @IBOutlet weak var FizzTextField: UILabel!
    @IBOutlet weak var BuzzTextField: UILabel!
    @IBOutlet weak var ScoreTextField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Global.currentScore = 0
        counterTextField.text = "\(counter)"
        FizzTextField.text = "\(Global.fizzNumber)"
        BuzzTextField.text = "\(Global.buzzNumber)"
        ScoreTextField.text = "Score: \(Global.currentScore)"
        startTimer()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Dispose of any resources before disappearing
        stopTimer() //ends timer so timer is not continuing in another viewController
    }
    private func startTimer() {
        if updateTimer == nil {
            updateTimer = Timer.scheduledTimer(
                timeInterval: timerSpeed, target: self, selector: #selector(updateGame), userInfo: nil, repeats: true
            )
        }
    }
    private func stopTimer() {
        if updateTimer != nil {
            updateTimer?.invalidate()
            updateTimer = nil
        }
    }
    @IBAction func FizzBuzzButton(_ sender: UIButton) {
        handleButtons(type: "fizzbuzz")
    }
    @IBAction func FizzButton(_ sender: UIButton) {
        handleButtons(type: "fizz")
    }
    @IBAction func BuzzButton(_ sender: UIButton) {
        handleButtons(type: "buzz")
    }
    private func handleButtons(type: String) {
        buttonPressed = true
        if (fizzBuzzLogic() == type) {
            if (type == "fizz" || type == "buzz") { Global.currentScore += 1 }
            if (type == "fizzbuzz") { Global.currentScore += 2 }
            uiTracking()
        } else {
            uiTracking()
            failGame()
        }
    }
    private func fizzBuzzLogic() -> String {
        //we check if there are multiples of counter
        if (counter % Global.fizzNumber == 0 && counter % Global.buzzNumber == 0) {
            return "fizzbuzz"
        } else if (counter % Global.fizzNumber == 0) {
            return "fizz"
        } else if (counter % Global.buzzNumber == 0) {
            return "buzz"
        } else if (counter % Global.fizzNumber != 0 && counter % Global.buzzNumber != 0) {
            return "nil"
        }
        return "nil"
        //nil can be used for extra conditions
        //case right now is that when its nil, you do nothing and wait for next counter value
    }
    //main gameplay loop
    internal func updateGame() {
        counterUpdate()
        buttonPressed = false
    }
    private func counterUpdate() {
        if !buttonPressed && fizzBuzzLogic() != "nil" {
            failGame() //fail if you press nothing when a button was required
        }
        //otherwise succeed if you didn't need to press anything or already pressed a successful button
        counter += 1
        counterTextField.text = "\(counter)"
    }
    private func failGame() {
        self.dismiss(animated: true, completion: nil) //takes you to previous page
        //extension: send you to highscores page
    }
    private func uiTracking() {
        ScoreTextField.text = "Score: \(Global.currentScore)"
        //add lives checking here too
    }
}
