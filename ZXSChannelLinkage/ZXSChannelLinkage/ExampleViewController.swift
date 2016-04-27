//
//  ExampleViewController.swift
//  ZXSChannelLinkage
//
//  Created by 张晓珊 on 16/4/22.
//  Copyright © 2016年 张晓珊. All rights reserved.
//

import UIKit

class ExampleViewController: ZXSChannelLinkageController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
    }

    override func loadData() {
        channelsArray = ["频道1", "频道频道1", "频道2", "频道"]
        setupUI()
    }


}
