//
//  Global.swift
//  FizzBuzz
//  Values and functions to be accessed in multiple places
//
//  Created by STEPHEN BIRSA on 4/05/2017.
//  Modified By NICHOLAS JOHN SMITH and STEPHEN BIRSA.
//  Last Modified: 18/05/2017
//  Copyright © 2017 Nicholas Smith. All rights reserved.
//
import UIKit
class Global: NSObject {
    //gameplay
    public static var fizzNumber:Int = 0
    public static var buzzNumber:Int = 0
    public static var currentScore:Int = 0
    public static var timerSpeed:Double = 0.0
    public static var insaneCounter:Bool = false
    public static var difficulty:String = ""
    //other
    public static func defaultSettings() -> Void {
        fizzNumber = 3 //default fizz from wikipedia
        buzzNumber = 5 //default buzz from wikipedia
        currentScore = 0 //always reset before a new game starts
        timerSpeed = 2.0 //default timerSpeed for medium
        insaneCounter = false //only on insane difficulty to add more challenge (currently on medium difficulty)
        difficulty = "medium" //default difficulty
    }
}
