//
//  TableViewCell.swift
//  CoreDataDemo
//
//  Created by ANHTT-D1 on 7/24/18.
//  Copyright © 2018 RikkeiIOS. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var imageFriendView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(friend: Friend) {
        self.nameLabel.text = friend.name
        self.phoneLabel.text = friend.phone_number
        
        if let imageData = friend.value(forKey: "image") as? Data {
            if let image = UIImage(data: imageData) {
                self.imageFriendView.image = image
            }
        }
        else {
            self.imageFriendView.image = UIImage(named: "default")
        }
    }
}
