//
//  hiScoresViewController.swift
//  FizzBuzz
//
//  Created by NICHOLAS JOHN SMITH on 27/04/2017.
//  Modified By NICHOLAS JOHN SMITH and STEPHEN BIRSA.
//  Last Modified: 18/05/2017
//  Copyright © 2017 Nicholas Smith. All rights reserved.
//
import UIKit
class hiScoresViewController: UIViewController {
    @IBOutlet var highScoreTextFields: [UITextField]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for i in 0...(5-1) {
            highScoreTextFields[i].text = "Hi Score: \(Global.highScores[i])"
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
