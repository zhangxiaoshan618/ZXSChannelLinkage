//
//  ViewController.swift
//  ZXSChannelLinkage
//
//  Created by 张晓珊 on 16/4/27.
//  Copyright © 2016年 张晓珊. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ManyBtn: UIButton!
    @IBOutlet weak var FewerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func ManyBtnClick(sender: AnyObject) {
        self.navigationController?.pushViewController(ManyChannelsViewController(), animated:true)
    }
    
    @IBAction func FewerBtnClick(sender: AnyObject) {
        self.navigationController?.pushViewController(FewerChannelsViewController(), animated:true)
    }
}
