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
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var tempMaxLabel: UILabel!
    @IBOutlet var tempMinLabel: UILabel!
    @IBOutlet var thumnailImageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    
}

class SummaryCell: UITableViewCell {
    
    @IBOutlet var thumnailImageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var tempMaxLabel: UILabel!
    @IBOutlet var tempMinLabel: UILabel!
    
}
