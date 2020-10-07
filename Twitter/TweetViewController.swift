//
//  TweetViewController.swift
//  Twitter
//
//  Created by Sidney Pho on 9/30/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {


    @IBOutlet weak var tweetView: UITextView!
    
    @IBOutlet weak var characterCount: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetView.delegate = self
        tweetView.becomeFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let characterLimit = 280
        let currentText = tweetView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= characterLimit
    }
    
    func textViewDidChange(_ textView: UITextView) {
        characterCount.text = "\(280 - tweetView.text.count)" + "/280"
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
