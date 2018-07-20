//
//  SQLTableViewCell.swift
//  DemoProject
//
//  Created by ANHTT-D1 on 7/20/18.
//  Copyright © 2018 anhtt. All rights reserved.
//

import UIKit

class SQLTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageRikkeiView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
