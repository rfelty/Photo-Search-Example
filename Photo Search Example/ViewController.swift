//
//  ViewController.swift
//  Photo Search Example
//
//  Created by Rick Felty on 5/13/15.
//  Copyright (c) 2015 Rick Felty. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let manager = AFHTTPRequestOperationManager()
        
        manager.GET( "https://api.instagram.com/v1/tags/clararockmore/media/recent?client_id=3a20d60d663942e795b3e746b3d04c21",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                println("JSON: " + responseObject.description)
                if let dataArray = responseObject["data"] as? [AnyObject] {
                    var urlArray:[String] = []                  //1
                    for dataObject in dataArray {               //2
                        if let imageURLString = dataObject.valueForKeyPath("images.standard_resolution.url") as? String { //3
                            urlArray.append(imageURLString)     //4
                        }
                    }
self.scrollView.contentSize = CGSizeMake(320, 320 * CGFloat(dataArray.count))
                    for var i = 0; i < urlArray.count; i++ {
                        let imageData = NSData(contentsOfURL: NSURL(string: urlArray[i])!)         //1
                        if let imageDataUnwrapped = imageData {                                     //2
                            let imageView = UIImageView(frame: CGRectMake(0, 320*CGFloat(i), 320, 320))     //1
                            imageView.setImageWithURL( NSURL(string: urlArray[i]))                          //2
                            self.scrollView.addSubview(imageView)                                       //5
                        }
                    }//5
                }
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

