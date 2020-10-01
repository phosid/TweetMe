//
//  TweetViewController.swift
//  Twitter
//
//  Created by Sidney Pho on 9/30/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {


    @IBOutlet weak var tweetView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetView.becomeFirstResponder()
        
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        if !tweetView.text.isEmpty {
            TwitterAPICaller.client?.postTweet(tweetString: tweetView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
