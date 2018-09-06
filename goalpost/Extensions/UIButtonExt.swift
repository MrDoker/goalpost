//
//  UIButtonExt.swift
//  goalpost
//
//  Created by DokeR on 06.09.2018.
//  Copyright © 2018 DokeR. All rights reserved.
//

import UIKit

extension UIButton {
    func setSelectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.337254902, green: 0.7803921569, blue: 0.3176470588, alpha: 1)
    }
    
    func setDeselectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.6392156863, green: 0.8823529412, blue: 0.6352941176, alpha: 1)
    }
}
