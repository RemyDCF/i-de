//
//  AnimationsViewController.swift
//  i-de
//
//  Created by Alice on 18/09/2015.
//  Copyright © 2015 DCF. All rights reserved.
//

import UIKit

class OptionsAnimationsViewController: UIViewController {
    @IBOutlet weak var delaySlider: UISlider!
    @IBOutlet weak var durationSlider: UISlider!
    @IBOutlet weak var forceSlider: UISlider!
    @IBOutlet weak var dampingSlider: UISlider!
    @IBOutlet weak var velocitySlider: UISlider!
    @IBOutlet weak var rotateSlider: UISlider!
    
    let defaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        if defaults.floatForKey(NSUserDefaultsKeys.AnimationsDuration) == 0.0 {
            defaults.setFloat(1.0, forKey: NSUserDefaultsKeys.AnimationsDuration)
        }
        if defaults.floatForKey(NSUserDefaultsKeys.AnimationsForce) == 0.0 {
            defaults.setFloat(1.0, forKey: NSUserDefaultsKeys.AnimationsForce)
        }
        if defaults.floatForKey(NSUserDefaultsKeys.AnimationsDamping) == 0.0 {
            defaults.setFloat(0.699999988079071, forKey: NSUserDefaultsKeys.AnimationsDamping)
        }
        if defaults.floatForKey(NSUserDefaultsKeys.AnimationsVelocity) == 0.0 {
            defaults.setFloat(0.699999988079071, forKey: NSUserDefaultsKeys.AnimationsVelocity)
        }
        delaySlider.value = defaults.floatForKey(NSUserDefaultsKeys.AnimationsDelay)
        durationSlider.value = defaults.floatForKey(NSUserDefaultsKeys.AnimationsDuration)
        forceSlider.value = defaults.floatForKey(NSUserDefaultsKeys.AnimationsForce)
        dampingSlider.value = defaults.floatForKey(NSUserDefaultsKeys.AnimationsDamping)
        velocitySlider.value = defaults.floatForKey(NSUserDefaultsKeys.AnimationsVelocity)
        rotateSlider.value = defaults.floatForKey(NSUserDefaultsKeys.AnimationsRotate)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func delaySliderChanged(sender: AnyObject) {
        defaults.setFloat(delaySlider.value, forKey: NSUserDefaultsKeys.AnimationsDelay)
    }
    
    @IBAction func durationSliderChanged(sender: AnyObject) {
        defaults.setFloat(durationSlider.value, forKey: NSUserDefaultsKeys.AnimationsDuration)
    }
    
    @IBAction func forceSliderChanged(sender: AnyObject) {
        defaults.setFloat(forceSlider.value, forKey: NSUserDefaultsKeys.AnimationsForce)
    }
    
    @IBAction func dampingSliderChanged(sender: AnyObject) {
        defaults.setFloat(dampingSlider.value, forKey: NSUserDefaultsKeys.AnimationsDamping)
    }
    
    @IBAction func velocitySliderChanged(sender: AnyObject) {
        defaults.setFloat(velocitySlider.value, forKey: NSUserDefaultsKeys.AnimationsVelocity)
    }
    
    @IBAction func rotateSliderChanged(sender: AnyObject) {
        defaults.setFloat(rotateSlider.value, forKey: NSUserDefaultsKeys.AnimationsRotate)
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
