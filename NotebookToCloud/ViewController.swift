//
//  ViewController.swift
//  NotebookToCloud
//
//  Created by abdulahi roble on 14/09/2021.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    var parentViewCon:TableViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let parentViewCon = parentViewCon {
            textView.text = parentViewCon.getCurrentNote()
        }
        
        
    }
    
}

