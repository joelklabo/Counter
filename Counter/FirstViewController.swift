//
//  FirstViewController.swift
//  Counter
//
//  Created by Joel Klabo on 10/23/14.
//  Copyright (c) 2014 Joel Klabo. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var counterLabel: UILabel!
    
    let eventDataService = EventDataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "addEvent")
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        let clearCountGestureRecognizerLeft = UISwipeGestureRecognizer(target: self, action: "clearCount")
        clearCountGestureRecognizerLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(clearCountGestureRecognizerLeft)

        let clearCountGestureRecognizerRight = UISwipeGestureRecognizer(target: self, action: "clearCount")
        clearCountGestureRecognizerRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(clearCountGestureRecognizerRight)
        
        let increaseCountGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "increaseCount")
        increaseCountGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(increaseCountGestureRecognizer)
        
        let decreaseCountGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "decreaseCount")
        decreaseCountGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(decreaseCountGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateCountLabel () {
        self.counterLabel.text = String(eventDataService.eventCount())
    }

    func addEvent () {
        eventDataService.addEvent()
        self.updateCountLabel()
    }

    func clearCount () {
        eventDataService.clearEvents()
        self.updateCountLabel()
    }
    
    func decreaseCount () {
        eventDataService.removeEvent()
        self.updateCountLabel()
    }
}

