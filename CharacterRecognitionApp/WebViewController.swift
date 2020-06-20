//
//  WebViewController.swift
//  CharacterRecognitionApp
//
//  Created by 黑田光 on 2020/06/20.
//  Copyright © 2020 Hikaru Kuroda. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://translate.google.co.jp/?hl=ja")!
        let request = URLRequest(url: url)
        self.webView.load(request)
    }
}
