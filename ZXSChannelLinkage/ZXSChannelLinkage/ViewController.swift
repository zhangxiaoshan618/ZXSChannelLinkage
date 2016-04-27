//
//  ViewController.swift
//  ZXSChannelLinkage
//
//  Created by 张晓珊 on 16/4/27.
//  Copyright © 2016年 张晓珊. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.navigationController?.pushViewController(ExampleViewController(), animated:true)
    }

}
