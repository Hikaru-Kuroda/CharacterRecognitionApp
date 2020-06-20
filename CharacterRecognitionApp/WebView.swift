//
//  WebView.swift
//  CharacterRecognitionApp
//
//  Created by 黑田光 on 2020/06/20.
//  Copyright © 2020 Hikaru Kuroda. All rights reserved.
//

import Foundation
import UIKit

extension WebViewController {
    
    func setPositionSize() {
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        let navHeight = self.navigationController?.navigationBar.frame.size.height
        
        webView.frame = CGRect(x: 0, y: navHeight!, width: width, height: height)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setPositionSize()
    }
}
