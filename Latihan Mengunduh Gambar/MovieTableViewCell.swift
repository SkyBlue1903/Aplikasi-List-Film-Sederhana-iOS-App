//
//  MovieTableViewCell.swift
//  Latihan Mengunduh Gambar
//
//  Created by Erlangga Anugrah Arifin on 14/09/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

// ----------| File Pertama |----------
    
    @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
