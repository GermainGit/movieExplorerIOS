//
//  MovieTableViewCell.swift
//  TP1_movie
//
//  Created by Germain Prevot on 04/03/2020.
//  Copyright © 2020 Germain Prevot. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        self.movieImg.image = nil
        super.prepareForReuse()
    }
    
    
}
