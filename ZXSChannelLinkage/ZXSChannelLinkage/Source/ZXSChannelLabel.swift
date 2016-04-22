//
//  ZXSChannelLabel.swift
//  ZXSChannelLinkage
//
//  Created by 张晓珊 on 16/4/22.
//  Copyright © 2016年 张晓珊. All rights reserved.
//

import UIKit

protocol ZXSChannelLabelDelegate: NSObjectProtocol {
    func channelLabelDidSelected(channelLabel: ZXSChannelLabel)
}

class ZXSChannelLabel: UILabel {

    weak var delegate: ZXSChannelLabelDelegate?
    
    convenience init(channel: String?) {
        self.init()
        self.text = channel
        self.textAlignment = .Center
        self.font = UIFont.systemFontOfSize(14)
        self.sizeToFit()
        self.userInteractionEnabled = true
        self.textColor = UIColor.darkGrayColor()
        self.highlightedTextColor = UIColor.orangeColor()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        delegate?.channelLabelDidSelected(self)
    }
}
