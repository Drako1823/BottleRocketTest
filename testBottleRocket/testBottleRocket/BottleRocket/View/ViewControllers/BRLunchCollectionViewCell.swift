//
//  BRLunchCollectionViewCell.swift
//  testBottleRocket
//
//  Created by roreyesl on 08/09/21.
//

import UIKit

class BRLunchCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlet
    
    @IBOutlet weak var imgRestaurant: UIImageView!
    @IBOutlet weak var lblRestaurantName: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() { super.awakeFromNib() }
    
    override func prepareForReuse() {
        imgRestaurant.image = nil
    }
    
    // MARK: - Functions
    
    func instantiateCell(withData arrData:detailRestaurant?){
        if let arrData = arrData {
            self.imgRestaurant.image = UIImage(named: "imgPlacerHolderImage")?.resized(to: CGSize(width: self.contentView.frame.size.width, height: 180))
            self.lblRestaurantName.text = arrData.strName ?? ""
            self.lblCategory.text = arrData.strCategory ?? ""
            if let url = URL(string: arrData.strImage ?? ""){
                UIImage.cacheImage(from: url, name: url.description){ image in
                    DispatchQueue.main.async {
                        self.imgRestaurant.image = image?.resized(to: CGSize(width: self.contentView.frame.size.width, height: 180))
                    }
                }
            }
        }
    }
}
