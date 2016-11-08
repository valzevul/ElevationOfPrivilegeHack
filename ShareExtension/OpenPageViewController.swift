//
//  OpenPageViewController.swift
//  WellcutDemoExtension
//
//  Created by Vadim Drobinin on 8/11/16.
//  Copyright © 2016 Vadim Drobinin. All rights reserved.
//

import UIKit

class OpenPageViewController: UIViewController {

  @IBAction func openPagePressed(_ sender: UIButton) {
    let url = NSURL(string: "wellcutdemo://")
    let context = NSExtensionContext()
    context.open(url! as URL, completionHandler: nil)
    
    var responder = self as UIResponder?
    
    while (responder != nil){
      if responder?.responds(to: Selector("openURL:")) == true{
        responder?.perform(Selector("openURL:"), with: url)
      }
      responder = responder!.next
    }
    
    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    preferredContentSize.height = 200
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
}
