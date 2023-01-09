//
//  TaskCVCell.swift
//  Shahnewaz_30020_29Dec
//
//  Created by BJIT on 12/29/22.
//

import UIKit
import Lottie

class TaskCVCell: UICollectionViewCell {

    @IBOutlet weak var cardAnimationView: LottieAnimationView!
    
    @IBOutlet weak var subject: UILabel!
    
    @IBOutlet weak var topic: UILabel!
    
    @IBOutlet weak var duration: UILabel!
    
    @IBOutlet weak var priority: UILabel!
    
    @IBOutlet weak var backgourndV: UIView!
    
    @IBOutlet weak var taskProgressBar: UIProgressView!
    
    var animateImageName = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgourndV.layer.cornerRadius = 40
        backgourndV.dropShadow()
        
        print(animateImageName)
        


    }

}


extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 10
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1

    }
}
