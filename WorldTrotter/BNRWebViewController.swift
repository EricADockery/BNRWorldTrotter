//
//  BNRWebViewController.swift
//  WorldTrotter
//
//  Created by Eric Dockery on 1/3/17.
//  Copyright © 2017 Eric Dockery. All rights reserved.
//

import UIKit
import WebKit

class BNRWebViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nerdRanchURL = URL (string: "https://www.bignerdranch.com")
        let request = URLRequest(url: nerdRanchURL!)
        webView.loadRequest(request)
    }
}
