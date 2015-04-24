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
        bar.tintColor = UIColor.whiteColor()
        for x in (bar.items as! [UITabBarItem]) {
            if (x.tag == 0) {
                x.image = UIImage(named: "iconeTabBarDisabled")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
                x.selectedImage = UIImage(named: "iconeTabBar")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            }
            else if (x.tag == 1) {
                x.image = UIImage(named: "parametresTabBarDisabled")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
                x.selectedImage = UIImage(named: "parametresTabBar")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            }
            x.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.blackColor()], forState: UIControlState.Normal)
            x.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.whiteColor()], forState: UIControlState.Selected)
        }
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
