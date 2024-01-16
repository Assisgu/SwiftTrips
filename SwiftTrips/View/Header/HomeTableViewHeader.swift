//
//  HomeTableViewHeader.swift
//  SwiftTravels
//
//  Created by Gustavo Assis on 12/01/24.
//

import UIKit

class HomeTableViewHeader: UIView {

    // MARK: - IBOutlets
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var bannerView: UIView!
    
    func configuraView() {
        headerView.backgroundColor = UIColor.systemBrown
        headerView.layer.cornerRadius = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? 500 : 280
        headerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        bannerView.layer.cornerRadius = 10
        bannerView.layer.masksToBounds = true
        
        
    }
}
