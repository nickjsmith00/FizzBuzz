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
    private var lifes:[UIImageView] = []
    private var amountOfLifes = 3
    private var currentlyGotScore:Bool = false
    //timer
    private var updateTimer:Timer!
    //textfields
    @IBOutlet weak var counterTextField: UILabel!
    @IBOutlet weak var FizzTextField: UILabel!
    @IBOutlet weak var BuzzTextField: UILabel!
    @IBOutlet weak var ScoreTextField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        counterTextField.adjustsFontSizeToFitWidth = true
        addLifesToScreen()
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
                timeInterval: Global.timerSpeed, target: self, selector: #selector(updateGame), userInfo: nil, repeats: true
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
            if (!currentlyGotScore && (type == "fizz" || type == "buzz")) {
                Global.currentScore += 10
                currentlyGotScore = true
            }
            if (!currentlyGotScore && type == "fizzbuzz") {
                Global.currentScore += 25
                currentlyGotScore = true
            }
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
        if (!Global.insaneCounter) {counter += 1 }
        else { counter += 1 + Int(arc4random_uniform(10)) }
        currentlyGotScore = false
        counterTextField.text = "\(counter)"
    }
    private func failGame() {
        lifes[amountOfLifes-1].removeFromSuperview()
        addEmptyLife(amountOfLifes-1)
        amountOfLifes -= 1
        if (amountOfLifes <= 0) { self.dismiss(animated: true, completion: nil) } //takes you to previous page
        //extension: send you to highscores page
    }
    private func uiTracking() -> Void {
        ScoreTextField.text = "Score: \(Global.currentScore)"
    }
    private func addEmptyLife(_ position:Int) -> Void {
        let currentPosition = CGRect(x: 20 + 30 * position, y: 21, width: 34, height: 34)
        lifes[position] = UIImageView(frame: currentPosition)
        lifes[position].image = UIImage(named: "emptyLife")
        self.view.addSubview(lifes[position])
    }
    private func addLifesToScreen() -> Void {
        for i in 0...(amountOfLifes-1) {
            let currentPosition = CGRect(x: 24 + 30 * i, y:26, width:25, height:25)
            let life = UIImageView(frame: currentPosition)
            life.image = UIImage(named: "fullLife")
            self.view.addSubview(life)
            lifes.append(life)
        }
    }
}
