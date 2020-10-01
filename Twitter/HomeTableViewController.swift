//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Sidney Pho on 9/28/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    
    var tweetArray = [NSDictionary]()
    var numberOfTweets: Int!
    let myRefreshControl = UIRefreshControl()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTweets()
        
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 150
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loadTweets()
    }
    
    @objc func loadTweets() {
        
        numberOfTweets = 20
        
        let myURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count": numberOfTweets]
        TwitterAPICaller.client?.getDictionariesRequest(url: myURL, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            
            self.myRefreshControl.endRefreshing()
            
        }, failure: { (Error) in
            print("Could not retrieve tweets")
        })
    }
    

    func loadMoreTweets() {
        
        let myURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweets = numberOfTweets + 20
        let myParams = ["count": numberOfTweets]
        TwitterAPICaller.client?.getDictionariesRequest(url: myURL, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            
        }, failure: { (Error) in
            print("Could not retrieve tweets")
        })
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count {
            loadMoreTweets()
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetTableViewCell
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        let userName = user["name"]
        
        cell.userNameLabel.text = userName as? String
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as? String
        let imageURL = URL(string: ((user["profile_image_url_https"] as? String)!))
        let data = try? Data(contentsOf: imageURL!)
        

        cell.profileImageView.image = UIImage(data: data!)
        
        
        cell.setFavorite(tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.tweetId = tweetArray[indexPath.row]["id"] as! Int
        
        return cell
    }
    
//    func getRelativeTime(timeString: String) -> String {
//        let time: Date
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
//        time = dateFormatter.date(from: timeString)!
//        return time.timeAgoDisplay()
//    }
//
//    extension Date {
//        func timeAgoDisplay() -> String {
//            let secondsAgo = Int(Date().timeIntervalSince(self)
//            let minute = 60
//            let hour = 60 * minute
//            let day = 24 * hour
//            let week = 7 * day
//            if secondsAgo < minute {
//
//            }
//        }
//    }
    


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }
    
    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
}
