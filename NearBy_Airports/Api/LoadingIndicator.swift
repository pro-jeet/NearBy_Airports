//
//  LoadingIndicator.swift
//  NearBy_Airports
//
//  Created by Jitesh Sharma on 11/12/19.
//  Copyright © 2019 Jitesh Sharma. All rights reserved.
//

import UIKit

class LoadingIndicator : UIView {
    
    convenience init(frames:CGRect) {
        self.init(frame:CGRect.zero)
        DispatchQueue.main.async {
            self.frame=frames
            self.backgroundColor=UIColor.clear
            self.addSubview(self.addImage())
            self.addSubview(self.initilizeIndicator())
        }
    }
    
    func addImage() -> UIImageView {
        let imgVw = UIImageView()
        imgVw.frame=self.frame
        imgVw.backgroundColor=UIColor.clear
//        imgVw.alpha=0.3
        return imgVw
    }
    
    func initilizeIndicator() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style : UIActivityIndicatorView.Style.whiteLarge)
        indicator.color = UIColor.clear
//        indicator.backgroundColor = UIColor.white
//        indicator.layer.cornerRadius=indicator.bounds.width/2
        indicator.center=self.center
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }
}
