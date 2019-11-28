//
//  ShareViewController.swift
//  Final Project
//
//  Created by Hai on 28/11/19.
//  Copyright © 2019 Organic Waste. All rights reserved.
//

import UIKit

class ShareViewController: UIActivityViewController {

    @IBOutlet weak var imageView: UIImageView!
    var test: UIActivity?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override init(activityItems: [Any], applicationActivities: [UIActivity]?) {
        super.init(activityItems: activityItems, applicationActivities: applicationActivities)
        imageView = activityItems[0] as! UIImageView
    }
//    override init(activityItems: [Any], applicationActivities: [UIActivity]?) {
//        imageView = activityItems[0] as! UIImageView
//        test = applicationActivities?[0]
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
