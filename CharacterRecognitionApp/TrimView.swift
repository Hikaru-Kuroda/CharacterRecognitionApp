//
//  TrimView.swift
//  CharacterRecognitionApp
//
//  Created by 黑田光 on 2020/06/20.
//  Copyright © 2020 Hikaru Kuroda. All rights reserved.
//

import Foundation
import UIKit

extension TrimViewController {
    
    func setPositionSize() {
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        let navHeight = self.navigationController?.navigationBar.frame.size.height
        
        imageView.frame = CGRect(x: 0, y: navHeight!, width: width, height: height * 0.37)
        imageView.backgroundColor = UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        
        textView.frame = CGRect(x: 0, y: height * 0.43, width: width, height: height * 0.25)
        textView.backgroundColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        
        let buttonWidth = width * 1/2
        let buttonHeight = CGFloat(30)
        let buttonBgColor = UIColor.orange
        let center = width * 1/2
        
        trimButton.frame = CGRect(x: 0, y: height * 0.72, width: buttonWidth, height: buttonHeight)
        trimButton.backgroundColor = buttonBgColor
        trimButton.center.x = center
    
        transButton.frame = CGRect(x: 0, y: height * 0.8, width: buttonWidth, height: buttonHeight)
        transButton.backgroundColor = buttonBgColor
        transButton.center.x = center
        
        goGoogleButton.frame = CGRect(x: 0, y: height * 0.88, width: buttonWidth, height: buttonHeight)
        goGoogleButton.backgroundColor = buttonBgColor
        goGoogleButton.center.x = center
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setPositionSize()
    }
}

extension TrimViewController: UITextViewDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.textView.isFirstResponder) {
            self.textView.resignFirstResponder()
        }
    }
}
