//
//  ZXSChannelLinkageController.swift
//  ZXSChannelLinkage
//
//  Created by 张晓珊 on 16/4/22.
//  Copyright © 2016年 张晓珊. All rights reserved.
//

import UIKit
import SnapKit

let kChannelScrollerViewHeight: CGFloat = 50
let kContentCollectionViewID = "ContentCollectionViewID"

class ZXSChannelLinkageController: UIViewController {
    /// 标题栏数组
    lazy var channelsArray = [String]()
    /// 当前显示的索引
    var currentIndex: Int = 0
    /// 将要显示的索引
    var nextIndex: Int = 0
    
    // MARK: - 生命周期
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.whiteColor()
    }
    
    /// 当channelsArray中有正确的值再调用
    func setupUI() {
        
        view.addSubview(channelScrollerView)
        view.addSubview(contentCollectionView)
        
        channelScrollerView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(snp_topLayoutGuideBottom)
            make.left.right.equalTo(view)
            make.height.equalTo(kChannelScrollerViewHeight)
        }
        
        contentCollectionView.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(view)
            make.top.equalTo(channelScrollerView.snp_bottom)
            make.bottom.equalTo(view.snp_bottom)
        }
        
        loadTopics()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    /// 加载数据
    func loadData() {
        // 在子类中重写
    }
    
    /// 往channelScrollerView上添加子控件
    func loadTopics() {
        automaticallyAdjustsScrollViewInsets = false
        
        let h: CGFloat = kChannelScrollerViewHeight
        var index: NSInteger = 0
        var margin: CGFloat = 30.0
        var x: CGFloat = margin
        
        for string in channelsArray {
            let label = ZXSChannelLabel(channel: string)
            label.delegate = self
            label.frame = CGRectMake(x, 0, label.bounds.width, h)
            label.tag = index++
            
            x += (label.bounds.width + margin)
            channelScrollerView.addSubview(label)
        }
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        
        if x < screenWidth {
            margin += (screenWidth - x) / CGFloat(index + 1)
            x = margin
            
            for subview in channelScrollerView.subviews {
                if subview.isKindOfClass(ZXSChannelLabel.self) {
                    subview.frame = CGRectMake(x, 0, subview.bounds.width, h)
                    
                    x += (subview.bounds.width + margin)
                }
            }
        }
        channelScrollerView.contentSize = CGSizeMake(x, h)
        (self.channelScrollerView.subviews[0] as! ZXSChannelLabel).highlighted = true
        
    }
    
    
    // MARK: - 懒加载
    /// 标题栏
    lazy var channelScrollerView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.whiteColor()
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    /// 详细内容
    lazy var contentCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        let w = UIScreen.mainScreen().bounds.width
        let h = UIScreen.mainScreen().bounds.height - 64 - 50
        layout.itemSize = CGSizeMake(w, h)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .Horizontal
        
        var contentview = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        contentview.dataSource = self
        contentview.delegate = self
        contentview.showsHorizontalScrollIndicator = false
        contentview.pagingEnabled = true
        contentview.bounces = false
        contentview.backgroundColor = UIColor.whiteColor()
        contentview.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCollectionViewID)
        return contentview
    }()
}

// MARK: - 数据源、代理方法
extension ZXSChannelLinkageController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return channelsArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kContentCollectionViewID, forIndexPath: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let w = scrollView.bounds.width
        let offsetX = scrollView.contentOffset.x
        
        let currentlabel: ZXSChannelLabel = channelScrollerView.subviews[currentIndex] as! ZXSChannelLabel
        var nextlabel: ZXSChannelLabel? = nil
        let a = NSInteger(offsetX / w)
        let b = offsetX % w
        let halfW = 0.5 * w
        
        if a == currentIndex && b > halfW {
            nextlabel = channelScrollerView.subviews[a + 1] as? ZXSChannelLabel
            currentlabel.highlighted = false
            nextlabel!.highlighted = true
            currentIndex = a + 1
            
            let centerX = nextlabel!.frame.origin.x + nextlabel!.bounds.width * 0.5
            
            let screenWidth = UIScreen.mainScreen().bounds.width
            if centerX <= screenWidth * 0.5 {
                channelScrollerView.contentOffset = CGPoint(x: 0, y: 0)
            }else if centerX < channelScrollerView.contentSize.width - screenWidth * 0.5 {
                channelScrollerView.contentOffset = CGPoint(x: centerX - screenWidth * 0.5, y: 0)
            }else {
                channelScrollerView.contentOffset = CGPoint(x: channelScrollerView.contentSize.width - screenWidth, y: 0)
            }
            
            return
        }
        
        if a < currentIndex && b > halfW {
            return
        }
        
        nextlabel = channelScrollerView.subviews[a] as? ZXSChannelLabel
        currentlabel.highlighted = false
        nextlabel!.highlighted = true
        currentIndex = a
        
        let centerX = nextlabel!.frame.origin.x + nextlabel!.bounds.width * 0.5
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        if centerX <= screenWidth * 0.5 {
            channelScrollerView.contentOffset = CGPoint(x: 0, y: 0)
        }else if centerX < channelScrollerView.contentSize.width - screenWidth * 0.5 {
            channelScrollerView.contentOffset = CGPoint(x: centerX - screenWidth * 0.5, y: 0)
        }else {
            channelScrollerView.contentOffset = CGPoint(x: channelScrollerView.contentSize.width - screenWidth, y: 0)
        }
    }
}


// MARK: - ZXSChannelLabelDelegate
extension ZXSChannelLinkageController: ZXSChannelLabelDelegate {
    /// 点击标签时让内容视图滚动到相应的页面
    ///
    /// - parameter channelLabel: 被点击的标签
    func channelLabelDidSelected(channelLabel: ZXSChannelLabel) {
        let currentlabel: ZXSChannelLabel = channelScrollerView.subviews[currentIndex] as! ZXSChannelLabel
        currentlabel.highlighted = false
        channelLabel.highlighted = true
        currentIndex = channelLabel.tag;
        
        let indexPath = NSIndexPath(forItem: currentIndex, inSection: 0)
        contentCollectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
        
        let centerX = channelLabel.frame.origin.x + channelLabel.bounds.width * 0.5
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        if centerX <= screenWidth * 0.5 {
            channelScrollerView.contentOffset = CGPoint(x: 0, y: 0)
        }else if centerX < channelScrollerView.contentSize.width - screenWidth * 0.5 {
            channelScrollerView.contentOffset = CGPoint(x: centerX - screenWidth * 0.5, y: 0)
        }else {
            channelScrollerView.contentOffset = CGPoint(x: channelScrollerView.contentSize.width - screenWidth, y: 0)
        }
    }

}
