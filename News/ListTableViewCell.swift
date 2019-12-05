//
//  ListTableViewCell.swift
//  News
//
//  Created by Sunny Reddy on 02/11/19.
//  Copyright © 2019 Harsha Reddy. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var JobLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
