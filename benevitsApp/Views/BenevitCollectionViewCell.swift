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
    
    @IBOutlet var benevitImageView: UIImageView!
    @IBOutlet var discountBenevitLabel: UILabel!
    @IBOutlet var placeBenevitLabel: UILabel!
    @IBOutlet var leftBenevitLabel: UILabel!
    var image: UIImage?
    var urlString:String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.containerView.layer.cornerRadius = 10
        self.containerView.layer.masksToBounds = true
        
    }
        
}
    
