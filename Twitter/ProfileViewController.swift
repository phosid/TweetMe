//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Sidney Pho on 10/6/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var followers: UILabel!
    @IBOutlet var following: UIView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    var numberOfFollowers: Int!
    var numberOfFollowing: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.cornerRadius = 32
        profileImage.layer.masksToBounds = true
        
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
