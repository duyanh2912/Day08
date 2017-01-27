//
//  SongCell.swift
//  Day08
//
//  Created by Duy Anh on 1/27/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var songArtist: UILabel!
    @IBOutlet weak var buyButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func touchedBuyButton(_ sender: UIButton) {
    }
}
