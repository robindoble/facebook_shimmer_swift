//
//  ViewController.swift
//  SparkleClock
//
//  Created by Aaron Douglas on 12/5/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
  var timer: NSTimer!
  var dateFormatter: NSDateFormatter!
  @IBOutlet var clockLabel: UILabel!
  @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    
    @IBOutlet var shimmeringView: FBShimmeringView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("updateClock"), userInfo: nil, repeats: true)
    dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
    dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
    
    shimmeringView.contentView = clockLabel
    shimmeringView.shimmering = true
  }
  
  override func viewWillAppear(animated: Bool) {
    updateClock()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    UIApplication.sharedApplication().idleTimerDisabled = true
  }
  
  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    
    UIApplication.sharedApplication().idleTimerDisabled = false
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  func updateClock() {
    var timeToDisplay = dateFormatter.stringFromDate(NSDate())
    clockLabel.text = timeToDisplay
  }
  
  @IBAction func didTapView() {
    shimmeringView.shimmering = !shimmeringView.shimmering
    tapGestureRecognizer.enabled = false
    
    UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .CurveEaseIn, animations: {
      self.clockLabel.transform = CGAffineTransformMakeScale(1.2, 1.2)
      }, completion: { (finished) -> Void in
        UIView.animateWithDuration(0.25, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .CurveEaseOut, animations: {
          self.clockLabel.transform = CGAffineTransformIdentity
          }, completion: {
            (finished) -> Void in
            self.tapGestureRecognizer.enabled = true
        })
    })
  }
}

