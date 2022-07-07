//
//  MovieCollectionViewCell.swift
//  Movierese
//
//  Created by mohamedSliem on 7/7/22.
//

import UIKit
import SDWebImage

class MoviewCollectionViewCell: UICollectionViewCell {
    
    
    static let identifier = "MovieCollectionViewCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    
     func configure(with url: URL) {
        
           self.posterImageView.sd_setImage(with: url, completed: nil)
        
    }
    
}
