//
//  TabController.swift
//  i-de
//
//  Created by remy on 29/12/2014.
//  Copyright (c) 2014 DCF. All rights reserved.
//

import UIKit

class TabController: UITabBarController {
    @IBOutlet weak var bar: UITabBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        bar.tintColor = UIColor(red:0.2, green:0.7, blue:0.36, alpha:1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
