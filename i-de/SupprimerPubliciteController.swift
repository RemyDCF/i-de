//
//  SupprimerPubliciteController.swift
//  i-de
//
//  Created by remy on 21/02/2015.
//  Copyright (c) 2015 DCF. All rights reserved.
//

import UIKit
import StoreKit

class SupprimerPubliciteController: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    var produit:SKProduct! = nil
    var restoreVar = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    @IBAction func confirmer(sender: AnyObject!) {
        if (SKPaymentQueue.canMakePayments()) {
            var request = SKProductsRequest(productIdentifiers: NSSet(object: "iDeInAppPurchase589GH5GKJERHGIEURYTGUI5EHTGIUERYT"))
            request.delegate = self
            request.start()
        }
        else {
            let alerte = UIAlertController(title: NSLocalizedString("erreur", tableName: "", bundle: NSBundle.mainBundle(), value: "", comment: ""), message: NSLocalizedString("erreurAchat", tableName: "", bundle: NSBundle.mainBundle(), value: "", comment: ""), preferredStyle: UIAlertControllerStyle.Alert)
            alerte.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(alerte, animated: true, completion: nil)
        }
    }
    @IBAction func restore(sender: AnyObject!) {
        if (SKPaymentQueue.canMakePayments()) {
            restoreVar = true
            var request = SKProductsRequest(productIdentifiers: NSSet(object: "iDeInAppPurchase589GH5GKJERHGIEURYTGUI5EHTGIUERYT"))
            request.delegate = self
            request.start()
        }
        else {
            let alerte = UIAlertController(title: NSLocalizedString("erreur", tableName: "", bundle: NSBundle.mainBundle(), value: "", comment: ""), message: NSLocalizedString("erreurAchat", tableName: "", bundle: NSBundle.mainBundle(), value: "", comment: ""), preferredStyle: UIAlertControllerStyle.Alert)
            alerte.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(alerte, animated: true, completion: nil)
        }
    }
    func productsRequest(request: SKProductsRequest!, didReceiveResponse response: SKProductsResponse!) {
        var products = response.products
        if (products.count != 0) {
            produit = products[0] as SKProduct
        }
        
        products = response.invalidProductIdentifiers
        
        for product in products {
            println("Product not found: \(product)")
        }
        
        var payment = SKPayment(product: produit)
        if restoreVar {
            SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
        }
        SKPaymentQueue.defaultQueue().addPayment(payment)
    }
    
    func paymentQueue(queue: SKPaymentQueue!, updatedTransactions transactions: [AnyObject]!) {
        let transactionsSK = transactions as [SKPaymentTransaction]
        for transaction in transactionsSK {
            switch transaction.transactionState {
                case .Purchased, .Restored:
                    deverouillerPubs()
                    let alerte = UIAlertController(title: NSLocalizedString("achatReussi", tableName: "", bundle: NSBundle.mainBundle(), value: "", comment: ""), message: NSLocalizedString("relancerApp", tableName: "", bundle: NSBundle.mainBundle(), value: "", comment: ""), preferredStyle: UIAlertControllerStyle.Alert)
                    alerte.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    presentViewController(alerte, animated: true, completion: nil)
                    SKPaymentQueue.defaultQueue().finishTransaction(transaction)
                    break
                case .Failed:
                    let alerte = UIAlertController(title: NSLocalizedString("erreur", tableName: "", bundle: NSBundle.mainBundle(), value: "", comment: ""), message: NSLocalizedString("erruer", tableName: "", bundle: NSBundle.mainBundle(), value: "", comment: ""), preferredStyle: UIAlertControllerStyle.Alert)
                    alerte.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    presentViewController(alerte, animated: true, completion: nil)
                    SKPaymentQueue.defaultQueue().finishTransaction(transaction)
                    break
                default:
                    break
            }
        }
    }
    
    func deverouillerPubs() {
        var donneePublicite = MesDonnesPublicite()
        var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = dir[0] . stringByAppendingPathComponent("publicite")
        donneePublicite.publicite = true
        var erreur = NSKeyedArchiver.archiveRootObject(donneePublicite, toFile: path)
    }
}
