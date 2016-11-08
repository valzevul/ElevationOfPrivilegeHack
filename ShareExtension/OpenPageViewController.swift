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
    while (responder != nil) {
      
      // The trickiest part.
      //
      // The warning itself isn't related to Swift 3, this is mostly a note that
      // this method will be deprecated one day.
      
      // For now Apple approves applications with Selectors used to
      // open a host app via an extension. For example, feel free to check Opener:
      // https://itunes.apple.com/us/app/opener-open-links-in-apps/id989565871?mt=8
      // (they use the same approach)
      
      
      if responder?.responds(to: Selector("openURL:")) == true {
        responder?.perform(Selector("openURL:"), with: url)
      }
      responder = responder!.next
    }
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
