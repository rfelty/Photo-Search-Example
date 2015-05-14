//
//  ViewController.swift
//  Photo Search Example
//
//  Created by Rick Felty on 5/13/15.
//  Copyright (c) 2015 Rick Felty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
                    println(urlArray)                           //5
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

