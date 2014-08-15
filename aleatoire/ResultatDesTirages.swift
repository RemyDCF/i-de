//
//  ResultatDesTirages.swift
//  Aleatoire
//
//  Created by DCF on 01/08/2014.
//  Copyright (c) 2014 Da Costa Faro Rémy. All rights reserved.
//

import UIKit

class ResultatDesTirages: UIViewController, CPTPieChartDataSource, CPTPieChartDelegate {
    // MARK: - Définition des variables de la classe
    var dataForChart = [NSNumber]();
    let graphView = CPTGraphHostingView(frame: CGRectMake(0, 64, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height - 64))
    // MARK: - Fonctions principales
    override func viewDidLoad() {
        super.viewDidLoad()
        /*var donnee = MesDonnes()
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var i = 1
        var resultat = [String?]()
        while i < 10 {
            var path = dir[0] . stringByAppendingPathComponent(String(i))
            donnee = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as MesDonnes
            resultat[i - 1] = donnee.laChaine
            i++
        }
*/
        let navBar = UINavigationBar(frame: CGRectMake(0, 00, UIScreen.mainScreen().bounds.size.width, 64))
        navBar.barStyle = UIBarStyle.Default
        let titre = UINavigationItem(title: "Résultat")
        navBar.pushNavigationItem(titre, animated: true)
        self.view.addSubview(navBar)
        var graph = CPTXYGraph(frame:graphView.bounds);
        self.graphView.hostedGraph = graph;
        
        graph.title = "Graph Title";
        graph.axisSet = nil;
        
        var pieChart = CPTPieChart();
        pieChart.pieRadius = 100.0;
        
        pieChart.dataSource = self;
        pieChart.delegate = self;
        
        graph.addPlot(pieChart);
        
        self.dataForChart = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10];
        self.view.addSubview(self.graphView);
    }
    
    func afficherParametre() -> Void {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func disablesAutomaticKeyboardDismissal() -> Bool {
        return false
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    // MARK: - Fonction de comformité au délégué CPTPlotDataSource
    func numberOfRecordsForPlot(plot:CPTPlot)-> UInt {
        return UInt(self.dataForChart.count)
    }
    func numberForPlot(plot: CPTPlot!, field fieldEnum: UInt, recordIndex idx: UInt) -> NSNumber! {
        return self.dataForChart[Int(idx)] as NSNumber
    }

}