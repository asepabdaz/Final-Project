//
//  UILabel+Highlighting.swift
//  Final Project
//
//  Created by Hai on 28/11/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit


extension UILabel {
    
    var highlightedText: String {
        get {
            return attributedText!.string
        }
        set {
            attributedTextFromHtml(htmlText: newValue)
        }
    }
    
    private func attributedTextFromHtml(htmlText: String) {
        let text = NSMutableString(string: htmlText)
        let rangesOfAttributes = getRangeToHighlight(text: text)
        
        let attributedString = NSMutableAttributedString(string: String(text))
        for range in rangesOfAttributes {
            let color = highlightedTextColor ?? #colorLiteral(red: 0.3508917391, green: 0.6345050931, blue: 0.4426603317, alpha: 1)
            let font = UIFont.boldSystemFont(ofSize: 17.0)
            attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: range)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        
        attributedText = attributedString
    }
    
    private func getRangeToHighlight(text: NSMutableString) -> [NSRange] {
        var rangesOfAttributes = [NSRange]()
        
        while true {
            let matchBegin = text.range(of: "<em>", options: .caseInsensitive)
            
            if matchBegin.location != NSNotFound {
                text.deleteCharacters(in: matchBegin)
                let firstCharacter = matchBegin.location
                
                let range = NSRange(location: firstCharacter, length: text.length - firstCharacter)
                let matchEnd = text.range(of: "</em>", options: .caseInsensitive, range: range)
                if matchEnd.location != NSNotFound {
                    text.deleteCharacters(in: matchEnd)
                    let lastCharacter = matchEnd.location
                    
                    rangesOfAttributes.append(NSRange(location: firstCharacter, length: lastCharacter - firstCharacter))
                }
            } else {
                break
            }
        }
        
        return rangesOfAttributes
    }
}
