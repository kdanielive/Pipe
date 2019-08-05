//
//  CaptionsViewController.swift
//  Pipe
//
//  Created by Daniel Kim on 8/5/19.
//  Copyright © 2019 Daniel Kim. All rights reserved.
//

import UIKit

class CaptionsViewController: UIViewController {

    
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = """
        Shall I compare thee to a summer's day?
        Thou art more lovely and more temperate:
        Rough winds do shake the darling buds of May,
        And summer's lease hath all too short a date:
        Sometime too hot the eye of heaven shines,
        And often is his gold complexion dimm'd;
        And every fair from fair sometime declines,
        By chance or nature's changing course untrimm'd;
        But thy eternal summer shall not fade
        Nor lose possession of that fair thou owest;
        Nor shall Death brag thou wander'st in his shade,
        When in eternal lines to time thou growest:
        So long as men can breathe or eyes can see,
        So long lives this and this gives life to thee.
        """
        textView.isEditable = false
        textView.font = UIFont(name: "Times New Roman", size: 20)

        // Do any additional setup after loading the view.
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
