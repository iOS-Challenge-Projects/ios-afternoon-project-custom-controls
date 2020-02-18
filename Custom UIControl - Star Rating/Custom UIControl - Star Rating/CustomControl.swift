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
    
    private let componentDimension: CGFloat = 40
    private var componentCount = 5
    private let componentActiveEmoji = "★"
    private let componentInactiveEmoji = "☆"
    //Initialize array of labels/stars
    private var labels = [UILabel]()
    let componentSpaceInterval: CGFloat = 8

    
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        setup()
    }
    
    //MARK: - Setup
    
    func setup()  {

        
        //Loop to append the 5 star labels
        for i in 0...4{
            
            let offset: CGFloat =   CGFloat(i) * (componentSpaceInterval + componentDimension) + componentSpaceInterval
            
            let myLabel =  UILabel(frame: CGRect(x: offset,y: 0, width: componentDimension, height: componentDimension))
            
            myLabel.tag = i
            myLabel.text = myLabel.tag == 0 ? componentActiveEmoji : componentInactiveEmoji
            myLabel.textColor = myLabel.tag == 0 ? .gray : .purple 
            myLabel.font = .boldSystemFont(ofSize: 32)
            myLabel.textAlignment = .center
            myLabel.textColor = .gray
            
            
            self.addSubview(myLabel)
            
            //Add to array
            labels.append(myLabel)
        }
    }
    
    
    override var intrinsicContentSize: CGSize {
        let componentsWidth = CGFloat(componentCount) * componentDimension
        let componentsSpacing = CGFloat(componentCount + 1) * componentSpaceInterval
        let width = componentsWidth + componentsSpacing
        return CGSize(width: width, height: componentDimension)
    }
    
    //MARK: - Tracking
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        updateValue(at: touch)
        
        sendActions(for: [.touchDown, .touchUpInside])
        
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
 
        
        let touchPoint = touch.location(in: self)
        
        if bounds.contains(touchPoint){
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
    
    



   //MARK: - Update Value method
   
    func updateValue(at touch: UITouch){
        
        let touchPoint = touch.location(in: self)
        
        for label in labels {
            
            if label.frame.contains(touchPoint) {
                
                value = label.tag
                //Send action to update title value
                sendActions(for: .valueChanged)
                
                for label in labels {
                    if label.tag <= value {
                        performFlare()
                        label.text = componentActiveEmoji
                        label.textColor = .purple
                    } else{
                        label.text = componentInactiveEmoji
                         label.textColor = .gray
                    }
                }
            }
        }
        
        
    }
    
}

extension UIView {
  // "Flare view" animation sequence
  func performFlare() {
    func flare()   { transform = CGAffineTransform(scaleX: 1.6, y: 1.6) }
    func unflare() { transform = .identity }
    
    UIView.animate(withDuration: 0.3,
                   animations: { flare() },
                   completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
  }
}
