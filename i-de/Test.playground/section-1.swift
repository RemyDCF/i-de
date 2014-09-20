// Playground - noun: a place where people can play

import UIKit

var inputTextField: UITextField?
let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .Alert)
let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
    // Do whatever you want with inputTextField?.text
    println("\(inputTextField?.text)")
})
let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
}
alertController.addAction(ok)
alertController.addAction(cancel)
alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
    inputTextField = textField
}
