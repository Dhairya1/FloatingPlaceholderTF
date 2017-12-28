//
//  FPHtextfield.swift
//  FloatingPlaceHolderTF
//
//  Created by Dhairya Uniyal on 27/12/17.
//  Copyright © 2017 NEO. All rights reserved.
//

import UIKit

class FPHtextfield: UITextField {
    var placeholderAttributes = NSDictionary()
    var lblPlaceHolder = UILabel()
    var defaultFont = UIFont()
    var difference: CGFloat = 35.0
    
    lazy var textfieldLine : UIImageView = {
        var underLine = UIImageView()
        underLine.backgroundColor = UIColor.init(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 0.8)
        underLine.frame = CGRect(x: 0, y: self.frame.size.height+5, width: self.frame.size.width, height: 1)
        underLine.clipsToBounds = true
        return underLine
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization ()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialization ()
    }
    
    func initialization(){
        self.clipsToBounds = false
        self.addTarget(self, action: #selector(FPHtextfield.textFieldDidChange), for: .editingChanged)
        self.enablePlaceholder(enablePH: true)
        defaultFont = self.font!
    }
    @IBInspectable var placeHolderColor: UIColor? = UIColor.lightGray {
        didSet {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder! as String , attributes:[NSAttributedStringKey.foregroundColor: placeHolderColor!])
        }
    }
    override internal var placeholder:String?  {
        didSet {
            //  NSLog("placeholder = \(placeholder)")
        }
        willSet {
            let atts  = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.lightGray, NSAttributedStringKey.font: UIFont.labelFontSize] as! [NSAttributedStringKey : Any]
            self.attributedPlaceholder = NSAttributedString(string: newValue!, attributes:atts)
            self.enablePlaceholder(enablePH: true)
        }
        
    }
    override internal var attributedText:NSAttributedString?  {
        didSet {
            //  NSLog("text = \(text)")
        }
        willSet {
            if (self.placeholder != nil) && (self.text != "")
            {
                let string = NSString(string : self.placeholder!)
                self.placeholderText(string)
            }
            
        }
    }
    @objc func textFieldDidChange(){
        if (self.text == nil) || (self.text?.count)! > 0 {
            self.lblPlaceHolder.alpha = 1
            self.attributedPlaceholder = nil
            self.lblPlaceHolder.textColor = self.placeHolderColor
            let fontSize = self.font!.pointSize;
            self.lblPlaceHolder.font = UIFont.init(name: (self.font?.fontName)!, size: fontSize-3)
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {() -> Void in
            if (self.text == nil) || (self.text?.count)! <= 0 {
                self.lblPlaceHolder.font = self.defaultFont
                self.lblPlaceHolder.frame = CGRect(x: self.lblPlaceHolder.frame.origin.x, y : 0, width :self.frame.size.width, height : self.frame.size.height)
            }
            else {
                self.lblPlaceHolder.frame = CGRect(x : self.lblPlaceHolder.frame.origin.x, y : -self.difference, width : self.frame.size.width, height : self.frame.size.height)
            }
        }, completion: {(finished: Bool) -> Void in
        })
    }
    func enablePlaceholder(enablePH: Bool){
        self.lblPlaceHolder = UILabel()
        self.lblPlaceHolder.frame = CGRect(x: 0, y : 0, width : 0, height :self.frame.size.height)
        self.lblPlaceHolder.font = UIFont.systemFont(ofSize: 10)
        self.lblPlaceHolder.alpha = 0
        self.lblPlaceHolder.clipsToBounds = true
        self.addSubview(self.lblPlaceHolder)
        self.lblPlaceHolder.attributedText = self.attributedPlaceholder
    }
    func placeholderText(_ placeholder: NSString){
        let atts  = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.lightGray, NSAttributedStringKey.font: UIFont.labelFontSize] as! [NSAttributedStringKey : Any]
        self.attributedPlaceholder = NSAttributedString(string: placeholder as String , attributes:atts)
        self.enablePlaceholder(enablePH: true)
    }
    override func becomeFirstResponder()->(Bool){
        let returnValue = super.becomeFirstResponder()
        return returnValue
    }
    override func resignFirstResponder()->(Bool){
        let returnValue = super.resignFirstResponder()
        return returnValue
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        textfieldLine.layoutIfNeeded()
        self.addSubview(textfieldLine)
    }
}
