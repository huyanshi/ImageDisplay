//
//  ImageDisplayViewController.swift
//  ImageDisplay
//
//  Created by 胡琰士 on 16/3/15.
//  Copyright © 2016年 胡琰士. All rights reserved.
//

import UIKit

class ImageDisplayViewController: UIViewController,UIScrollViewDelegate {
    let SCREENW = UIScreen.mainScreen().bounds.size.width
    //MARK : - 属性列表
    private var imageView:UIImageView?
    private var clippingWidth:CGFloat = UIScreen.mainScreen().bounds.size.width
    private var clippingHeight:CGFloat = 160
    private var currentScaleIsHeight:Bool = true
    var image:UIImage? {
        didSet {
            dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
                let imagefixed = self.image?.fixOrientation()
                while self.imageView == nil {
                    NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate.distantFuture())
                }
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    self.imageView?.image = imagefixed
                })
            }
        }
    }
    //MARK : - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func loadView() {
        super.loadView()
        let topView = UIView()
        view.addSubview(topView)
        topView.backgroundColor = UIColor.purpleColor()
        topView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(0)
        }
        topView.addSubview(scrollView)
        scrollView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(0)
        }
        clippingWidth = SCREENW
        imageView = UIImageView(frame: CGRectZero)
        imageView?.userInteractionEnabled = true
        scrollView.addSubview(imageView!)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        imageView?.frame = CGRect(x: 0, y: 0, width: (image?.size.width)!, height: (image?.size.height)!)
        scrollView.contentSize = (imageView?.frame.size)!
        let scale = (image?.size.width)! / (image?.size.height)!
        if scale > 2 {
            clippingHeight = 160
            heightScale()
        }else {
            widthScale()
        }
        squareStyle()
        scrollView.contentOffset = CGPoint(x: ((imageView?.frame.size.width)! - clippingWidth)/2, y: ((imageView?.frame.size.height)! - scrollView.frame.height)/2)    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK : -
    private lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.blackColor()
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.maximumZoomScale = 2
        scrollView.bouncesZoom = false
        return scrollView
    }()
    //MARK : -
    private func heightScale() {
        let scale = clippingHeight / (image?.size.height)!
        if scale > 1 {
            scrollView.maximumZoomScale = scale + scale
        }
        scrollView.minimumZoomScale = scale
        scrollView.zoomScale = scale
        currentScaleIsHeight = true
        
    }
    private func widthScale() {
        let scale = scrollView.frame.size.width / (image?.size.width)!
        if scale > 1 {
            scrollView.maximumZoomScale = scale + scale
        }
        scrollView.minimumZoomScale = scale
        scrollView.zoomScale = scale
        currentScaleIsHeight = false
    }
    private func rectangleStyle() {
        clippingHeight = 160
        if currentScaleIsHeight {
            let scale = scrollView.frame.size.width / (image?.size.width)!
            if scale > 1 {
                scrollView.maximumZoomScale = scale + scale
            }
            scrollView.minimumZoomScale = scale
            currentScaleIsHeight = false
        }
        maskViewClippingRect()
    }
    private func squareStyle() {
        clippingHeight = 320
        if currentScaleIsHeight == false && image?.size.width > image?.size.height {
            let scale = clippingHeight / (image?.size.height)!
            if scale  > 1 {
                scrollView.maximumZoomScale = scale + scale
            }
            scrollView.minimumZoomScale = scale
            currentScaleIsHeight = true
        }
        if imageView?.frame.size.height < clippingHeight {
            heightScale()
        }
        maskViewClippingRect()
    }
    private func maskViewClippingRect() {
        if imageView?.frame.size.width < clippingWidth {
            widthScale()
        }
        let h = scrollView.frame.size.height
        let borderRect = CGRect(x: 0, y: (h - clippingHeight)/2, width: clippingWidth, height: clippingHeight)
        let y3 = borderRect.origin.y + clippingHeight
        let imageInset = UIEdgeInsets(top: borderRect.origin.y, left: 0, bottom: h - y3, right: 0)
        scrollView.contentInset = imageInset
        
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}
