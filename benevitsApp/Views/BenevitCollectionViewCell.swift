//
//  BenevitCollectionViewCell.swift
//  ednienksnkuesnf
//
//  Created by Pedro Antonio Vazquez Rodriguez on 08/09/20.
//  Copyright © 2020 Pedro Antonio Vazquez Rodriguez. All rights reserved.
//

import UIKit

class BenevitCollectionViewCell: UICollectionViewCell {
    @IBOutlet var containerView: UIView!
    @IBOutlet var lockedView: UIView!

    @IBOutlet var LockedImageView: UIImageView!
    @IBOutlet var LockedButton: UIButton!
    @IBOutlet var benevitImageView: UIImageView!
    @IBOutlet var discountBenevitLabel: UILabel!
    @IBOutlet var placeBenevitLabel: UILabel!
    @IBOutlet var leftBenevitLabel: UILabel!
    
    var benevit:Benevit?{
           didSet{
               if let benevit  = benevit{
                if benevit.locked ?? true {
                    self.containerView.isHidden = true
                    self.lockedView.isHidden = false
                    self.discountBenevitLabel.text = benevit.title
                    self.placeBenevitLabel.text = benevit.territories[0].name
                    self.leftBenevitLabel.text = benevit.expirationDate
                    if let url:URL = URL(string: benevit.vectorFullPath ){
                        self.LockedImageView.load(url:url)
                    }
                    
                    if let url:URL = URL(string: benevit.ally.miniLogoFullPath ){
                        self.benevitImageView.load(url: url)
                    }
                    
                }else{
//                    cell.urlString  = benevits[indexPath.item].ally.miniLogoFullPath
                    self.discountBenevitLabel.text = benevit.name
                    self.placeBenevitLabel.text = benevit.territories[0].name
                    self.leftBenevitLabel.text = benevit.expirationDate
                    if let url:URL = URL(string: benevit.ally.miniLogoFullPath ){
                        self.benevitImageView.load(url: url)
                    }
                    
                }
               }
               
               
               
           }
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.containerView.layer.cornerRadius = 10
        self.containerView.layer.masksToBounds = true
        self.lockedView.layer.cornerRadius = 10
        self.lockedView.layer.masksToBounds = true
        self.LockedButton.layer.cornerRadius = LockedButton.frame.height/6
        self.LockedButton.layer.masksToBounds = true
    }
    @IBAction func unlockActionButton(_ sender: Any) {
        self.containerView.isHidden = false
        self.lockedView.isHidden = true
    }
    
}
    
