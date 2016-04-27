//
//  ManyChannelsViewController.swift
//  ZXSChannelLinkage
//
//  Created by 张晓珊 on 16/4/27.
//  Copyright © 2016年 张晓珊. All rights reserved.
//

import UIKit

class ManyChannelsViewController: ZXSChannelLinkageController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func loadData() {
        channelsArray = ["频道1", "频道频道2", "频道3", "频道4", "频道5", "频道频道6", "频道7", "频道8", "频道9", "频道频道10", "频道11", "频道12"]
        setupUI()
    }


}
