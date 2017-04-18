//
//  CircleView.swift
//  devslopes
//
//  Created by 11ien on 4/16/17.
//  Copyright © 2017 11ien. All rights reserved.
//

import UIKit

class CircleView: UIImageView {


    
    override func layoutSubviews() {

        layer.cornerRadius = self.frame.width/2
        
    }
    
}
