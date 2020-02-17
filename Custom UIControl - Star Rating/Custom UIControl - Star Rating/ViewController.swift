//
//  ViewController.swift
//  Custom UIControl - Star Rating
//
//  Created by FGT MAC on 2/17/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    var value = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "User Rating: \(value) \(value > 1 ? "Stars" : "Star")"
        
    }


    
    
    @IBAction func updateRating(_ ratingControl: CustomControl) {
        
        value = ratingControl.value
    }
    
    
    
}

