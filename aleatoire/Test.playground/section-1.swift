// Playground - noun: a place where people can play

import UIKit

var dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
var path = dir[0] . stringByAppendingPathComponent("Hello")