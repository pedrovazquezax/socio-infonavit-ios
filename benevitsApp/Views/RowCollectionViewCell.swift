//
//  RowCollectionViewCell.swift
//  ednienksnkuesnf
//
//  Created by Pedro Antonio Vazquez Rodriguez on 08/09/20.
//  Copyright © 2020 Pedro Antonio Vazquez Rodriguez. All rights reserved.
//

import UIKit
import SkeletonView

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
        cell.benevit = benevits[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:frame.width/2 - 30, height: frame.height-10)
    }
    
 
    
    
    
}



extension RowCollectionViewCell: SkeletonCollectionViewDataSource{
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return benevitIdentifier
    }
    
    
}
