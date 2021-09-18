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
        if let parent = parentViewCon {
            textView.text = parent.notes[parent.currentNote].txt
        } else {
            textView.text = "empty..."
        }
        
    }
    
}

