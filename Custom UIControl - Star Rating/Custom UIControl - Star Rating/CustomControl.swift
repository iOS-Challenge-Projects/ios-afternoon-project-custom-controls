//
//  CustomControl.swift
//  Custom UIControl - Star Rating
//
//  Created by FGT MAC on 2/17/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import UIKit


class CustomControl: UIControl {
    
    //MARK: - Properties
    
    var value: Int = 1
    
    private let componentDimension: CGFloat = 40.00
    private let componentCount = 5
    private let componentActiveColor = UIColor.black
    private let componentInactiveColor = UIColor.gray
    
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        setup()
    }
    
    //MARK: - Setup
    
    func setup()  {
        
        //Initialize array of labels/stars
        var labels: [UILabel] = []
        
        //Loop to append the 5 star labels
        for i in 1...5{
            
            let myLabel = UILabel()
            myLabel.translatesAutoresizingMaskIntoConstraints = false
            myLabel.tag = i
            myLabel.frame.size.width = componentDimension
            myLabel.frame.size.height = componentDimension
            myLabel.text = "☆"
            myLabel.font = UIFont.systemFont(ofSize: 32.0, weight: .bold)
            myLabel.textAlignment = .center
            myLabel.textColor = componentInactiveColor
            
            //Add to array
            labels.append(myLabel)

        }
        
        //Create row
        let hStack = UIStackView(arrangedSubviews: labels)
        hStack.axis = .horizontal
        hStack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(hStack)
        
        //constraints to center the hStack
        hStack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        hStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
       

    }
    
    
    override var intrinsicContentSize: CGSize {
      let componentsWidth = CGFloat(componentCount) * componentDimension
      let componentsSpacing = CGFloat(componentCount + 1) * 8.0
      let width = componentsWidth + componentsSpacing
      return CGSize(width: width, height: componentDimension)
    }
    
    func updateValue(at touch: UITouch){
        
    }
    
    //MARK: - Tracking
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        updateValue(at: touch)
        
        sendActions(for: [.touchUpInside])
        
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        if bounds.contains(touch.location(in: self)){
            //if touc inside update value
            updateValue(at: touch)
            sendActions(for: [.touchDragInside])
        }else{
             sendActions(for: [.touchUpOutside])
        }
        
        return true
    }
    
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        
        defer {  super.endTracking(touch, with: event) }
         
        guard let touch = touch else {  return  }
        
        if bounds.contains(touch.location(in: self)){
            //if touc inside update value
            updateValue(at: touch)
            sendActions(for: [.touchUpInside])
        }else{
             sendActions(for: [.touchUpOutside])
        }
        
    }
    
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: [.touchCancel])
    }
    
}
