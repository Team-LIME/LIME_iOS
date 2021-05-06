//
//  RadioButton.swift
//  LIME_iOS
//
//  Created by 이영은 on 2021/05/03.
//

import UIKit

class RadioButton: UIButton {
    var alternateButton:Array<RadioButton>?
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1.5
        self.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.systemGreen.cgColor
    }
    
    func unselectAlternateButtons() {
        if alternateButton != nil {
            self.isSelected = true
            
            for aButton:RadioButton in alternateButton! {
                aButton.isSelected = false
            }
        } else {
            toggleButton()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }
    
    func toggleButton() {
        self.isSelected = !isSelected
    }
    
    override public var isHighlighted: Bool {
            didSet {
                self.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.0)
            }
        }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                DispatchQueue.main.async {
                    self.layer.borderColor = UIColor.systemGreen.cgColor
                    self.setTitleColor(UIColor.systemGreen, for: .selected)
                }
                
            } else {
                DispatchQueue.main.async {
                    self.layer.borderColor = UIColor.systemGray4.cgColor
                    self.setTitleColor(UIColor.systemGray4, for: .normal)
                }
            }
        }
    }
}
