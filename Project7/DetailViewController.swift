//
//  DetailViewController.swift
//  Project7
//
//  Created by Stefan Milenkovic on 3/7/19.
//  Copyright © 2019 Stefan Milenkovic. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webVIew: WKWebView!
    var recivedPetition: Petititon?
    
    
    override func loadView() {
        webVIew = WKWebView()
        view = webVIew
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let recPet = recivedPetition else {return}
        
        // Do any additional setup after loading the view.
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initialscale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>\(recPet.body)</body>
        </html>
        """
        
        webVIew.loadHTMLString(html, baseURL: nil)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
