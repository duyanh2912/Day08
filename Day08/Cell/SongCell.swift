//
//  SongCell.swift
//  Day08
//
//  Created by Duy Anh on 1/27/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//

import UIKit
import Utils

class SongCell: UITableViewCell {
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var songArtist: UILabel!
    @IBOutlet weak var buyButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none
        buyButton.tintColor = .clear
        buyButton.setTitle("BUY SONG", for: .selected)
        
        buyButton.setTitleColor(.white, for: .highlighted)
        
        buyButton.titleLabel?.addObserver(self, forKeyPath: #keyPath(UILabel.text), options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if buyButton.isSelected {
            buyButton.borderColor = .white
        } else {
            buyButton.borderColor = try! UIColor.init(rgba_throws: "#FCE075")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func touchedBuyButton(_ sender: UIButton) {
        UIView.transition(with: buyButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
            if self.buyButton.isSelected {
                self.buyButton.isSelected = false
            } else {
                self.buyButton.isSelected = true
            }
        }, completion: nil)
    }
}
