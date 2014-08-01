//
//  ResultatDesTirages.swift
//  Aleatoire
//
//  Created by DCF on 01/08/2014.
//  Copyright (c) 2014 Da Costa Faro Rémy. All rights reserved.
//

import UIKit

class ResultatDesTirages: UIViewController, PNChartDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        var donnee = MesDonnes()
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var barChart = PNBarChart(frame: CGRectMake(0, 135.0, 320.0, 200.0))
        barChart.backgroundColor = UIColor.clearColor()
        barChart.yLabelFormatter = ({(yValue: CGFloat) -> NSString in
            var yValueParsed:CGFloat = yValue
            var labelText:NSString = NSString(format:"%1.f",yValueParsed)
            return labelText;
            })
        barChart.labelMarginTop = 5.0
        barChart.xLabels = ["1","2","3","4","5","6","7","8","9","10"]
        barChart.yValues = [1,24,12,18,30,10,21, 32,34,75]
        barChart.strokeChart()
        
        barChart.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func userClickedOnLineKeyPoint(point: CGPoint, lineIndex: Int, keyPointIndex: Int)
    {
        println("Click Key on line \(point.x), \(point.y) line index is \(lineIndex) and point index is \(keyPointIndex)")
    }
    
    func userClickedOnLinePoint(point: CGPoint, lineIndex: Int)
    {
        println("Click Key on line \(point.x), \(point.y) line index is \(lineIndex)")
    }
    
    func userClickedOnBarCharIndex(barIndex: Int)
    {
        println("Click  on bar \(barIndex)")
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
