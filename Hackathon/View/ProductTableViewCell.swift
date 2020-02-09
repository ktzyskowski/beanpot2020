//
//  ProductTableViewCell.swift
//  Hackathon
//
//  Created by Kevin Zyskowski on 2/8/20.
//  Copyright © 2020 Kevin Zyskowski. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print(nameLabel)
        print(authorLabel)
    }

}
