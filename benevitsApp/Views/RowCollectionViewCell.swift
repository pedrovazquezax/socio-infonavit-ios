//
//  RowCollectionViewCell.swift
//  ednienksnkuesnf
//
//  Created by Pedro Antonio Vazquez Rodriguez on 08/09/20.
//  Copyright © 2020 Pedro Antonio Vazquez Rodriguez. All rights reserved.
//

import UIKit

class RowCollectionViewCell: UICollectionViewCell {
    let benevitIdentifier:String = "benevitCell"
    var benevits = [Benevit]()
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var benevitCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        benevitCollectionView.delegate = self
        benevitCollectionView.dataSource = self
        benevitCollectionView.register(UINib(nibName: "BenevitCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: benevitIdentifier)
    }

}
extension RowCollectionViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return benevits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: benevitIdentifier, for: indexPath) as! BenevitCollectionViewCell
        if benevits[indexPath.item].locked ?? false{
            cell.urlString = benevits[indexPath.item].vectorFullPath
        }else{
            cell.urlString  = benevits[indexPath.item].ally.miniLogoFullPath
            cell.discountBenevitLabel.text = benevits[indexPath.item].name
            cell.placeBenevitLabel.text = benevits[indexPath.item].territories[0].name
            cell.leftBenevitLabel.text = benevits[indexPath.item].expirationDate
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:frame.width/2 - 30, height: frame.height-10)
    }
    
 
    
    
    
}
