//
//  gameViewController.swift
//  FizzBuzz
//  Gameplay of FizzBuzz
//
//  Created by NICHOLAS JOHN SMITH on 27/04/2017.
//  Modified By NICHOLAS JOHN SMITH and STEPHEN BIRSA.
//  Last Modified: 18/05/2017
//  Copyright © 2017 Nicholas Smith. All rights reserved.
//
import UIKit
class gameViewController: UIViewController {
    //logic
    private var lifes:[UIImageView] = []
    private var counter:Int = 1 //can start at 1 or the first divisible number of fizz/buzz
    private var amountOfLifes:Int = 3
    private var currentlyGotScore:Bool = false
    private var buttonPressed:Bool = false
    //textfields
    @IBOutlet weak var counterTextField:UILabel!
    @IBOutlet weak var FizzTextField:UILabel!
    @IBOutlet weak var BuzzTextField:UILabel!
    @IBOutlet weak var ScoreTextField:UILabel!
    //timer
    private var updateTimer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        counterTextField.adjustsFontSizeToFitWidth = true
        addLifesToScreen()
        counterTextField.text = "\(counter)"
        FizzTextField.text = "\(Global.fizzNumber)"
        BuzzTextField.text = "\(Global.buzzNumber)"
        ScoreTextField.text = "Score: \(Global.currentScore)"
        startTimer()
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
    private func startTimer() -> Void {
        if updateTimer == nil {
            updateTimer = Timer.scheduledTimer(
                timeInterval: Global.timerSpeed, target: self, selector: #selector(updateGame), userInfo: nil, repeats: true
            )
        }
    }
    private func stopTimer() -> Void {
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
    private func handleButtons(type: String) -> Void {
        buttonPressed = true
        if (fizzBuzzLogic() == type) {
            if (!currentlyGotScore && (type == "fizz" || type == "buzz")) {
                Global.currentScore = Global.currentScore + 10
                currentlyGotScore = true
            }
            if (!currentlyGotScore && type == "fizzbuzz") {
                Global.currentScore = Global.currentScore + 25
                currentlyGotScore = true
            }
            ScoreTextField.text = "Score: \(Global.currentScore)"
        } else {
            ScoreTextField.text = "Score: \(Global.currentScore)"
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
    internal func updateGame() -> Void {
        updateCounter()
        buttonPressed = false
    }
    private func updateCounter() -> Void {
        if (!buttonPressed && fizzBuzzLogic() != "nil") {
            failGame() //fail if you press nothing when a button was required
        }
        //otherwise succeed if you didn't need to press anything or already pressed a successful button
        if (!Global.insaneCounter) {
            counter += 1
        } else {
            counter += 1 + Int(arc4random_uniform(10))
        }
        currentlyGotScore = false
        counterTextField.text = "\(counter)"
    }
    private func failGame() -> Void {
        lifes[amountOfLifes-1].removeFromSuperview()
        addEmptyLife(amountOfLifes-1)
        amountOfLifes -= 1
        if (amountOfLifes <= 0) {
            stopTimer() //ends timer so timer is not continuing in another viewController
            /*
             On Main.storyboard:
             Clicked on hiScoresViewController and went just below Custom Class, to Identity.
             In Identity, added Storyboard ID as HighScores and ticked “Use Storyboard ID”
             This enables to be able to go to that viewController through the code.
            */
            let changeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HighScores") as! hiScoresViewController
            self.present(changeViewController, animated: true, completion: nil) //change to hiScoresViewController
        }
    }
    //adding Empty or FullLife UI element/s to screen
    private func addEmptyLife(_ position:Int) -> Void {
        let currentPosition = CGRect(x: 22 + 30 * position, y: 23, width: 30, height: 30)
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
