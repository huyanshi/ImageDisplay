//
//  PhotoViewController.swift
//  ImageDisplay
//
//  Created by 胡琰士 on 16/3/21.
//  Copyright © 2016年 胡琰士. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    var imageArr:[UIImage]?
        {
        didSet {
            collectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let imageArray = imageArr {
            return imageArray.count
        }else {
            return 0
        }
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell(frame: UIScreen.mainScreen().bounds)
        let detalView = ImageDisplayViewController()
        detalView.image = imageArr![indexPath.row]
        cell.addSubview(detalView.view)
        return cell
    }

    lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height), collectionViewLayout: UICollectionViewLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
}
