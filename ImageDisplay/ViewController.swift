//
//  ViewController.swift
//  ImageDisplay
//
//  Created by 胡琰士 on 16/3/15.
//  Copyright © 2016年 胡琰士. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let imageArr:[UIImage] = [UIImage(named: "test1")!,UIImage(named: "test2")!,UIImage(named: "test3")!,UIImage(named: "test4")!,UIImage(named: "test5")!]
    let names:[String] = ["test1","test2","test3","test4","test5",]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickPhotoArr(sender: AnyObject) {
        var imageControllers = [UIViewController]()
       for i in 0 ..< imageArr.count {
            let imageVC = ImageDisplayViewController()
        imageVC.image = imageArr[i]
        imageControllers.append(imageVC)
        }
        let VC = ScrollDisplayViewController(controllers: imageControllers)
        VC.autoCyle = false
//        VC.imageArr = imageArr
        navigationController?.pushViewController(VC, animated: true)
    }

    @IBAction func clickImage(sender: AnyObject) {
        let image = UIImage(named: "test1")
        let imageVC = ImageDisplayViewController()
        imageVC.image = image
//         navigationController?.navigationBar.hidden = true
        navigationController?.pushViewController(imageVC, animated: true)
    }

}

