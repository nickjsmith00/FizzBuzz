//
//  gameViewController.swift
//  FizzBuzz
//
//  Created by NICHOLAS JOHN SMITH on 27/04/2017.
//  Copyright © 2017 Nicholas Smith. All rights reserved.
//

import UIKit

class gameViewController: UIViewController {
    @IBOutlet weak var counterLabel: UILabel!
    private var count:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //timeInterval: lower number is faster
        //higher number is slower
        //eg. 1 is every second, 0.01 is every milisecond (very fast)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateGame), userInfo: nil, repeats: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func updateGame() {
        counter()
        Global.fizzNumber = 3
        Global.buzzNumber = 5
    }
    
    private func counter() -> Void
    {
        count += 1
        counterLabel.text = "" + String(count)
    }
    
}

