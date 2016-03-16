//
//  ViewController.swift
//  ImageDisplay
//
//  Created by 胡琰士 on 16/3/15.
//  Copyright © 2016年 胡琰士. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickImage(sender: AnyObject) {
        let image = UIImage(named: "image")
        let imageVC = ImageDisplayViewController()
        imageVC.image = image
         navigationController?.navigationBar.hidden = true
        navigationController?.pushViewController(imageVC, animated: true)
    }

}

