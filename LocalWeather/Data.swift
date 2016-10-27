//
//  Data.swift
//  LocalWeather
//
//  Created by Safina Lifa on 10/27/16.
//  Copyright © 2016 Safina Lifa. All rights reserved.
//

import Foundation
import UIKit

class Data: UITableViewCell {
    
    @IBOutlet var dateLbl: UILabel!
    @IBOutlet var tempMaxLbl: UILabel!
    @IBOutlet var tempMinLbl: UILabel!
    @IBOutlet var imageViewWeather: UIImageView!
    @IBOutlet var descriptLbl: UILabel!
    
}

class DetailCell: UITableViewCell {
    
    @IBOutlet var imageViewWeather: UIImageView!
    @IBOutlet var dateLbl: UILabel!
    @IBOutlet var descriptionLbl: UILabel!
    @IBOutlet var tempMaxLbl: UILabel!
    @IBOutlet var tempMinLbl: UILabel!
    
}
