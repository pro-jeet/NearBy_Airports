//
//  TableCell.swift
//  NearBy_Airports
//
//  Created by Jitesh Sharma on 11/12/19.
//  Copyright © 2019 Jitesh Sharma. All rights reserved.
//

import UIKit


class CityCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    
    var item: Any?{
        didSet{
            guard let model = item as? CityModel else{return}
            lblName.text = /model.city == "" ? "City Name Not Available!" : model.city
        }
    }
}

class CityCellFive: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLength: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    
    var item: Any?{
        didSet{
            guard let model = item as? CityModel else{return}
            lblName.text = /model.name == "" ? "Airport Name Not Available!" : model.name
            lblLength.text = /model.runway_length == "" ? "Runway Length Not Available!" : model.runway_length
            lblCountry.text = /model.country == "" ? "Country Name Not Available!" : model.country
        }
    }
}
