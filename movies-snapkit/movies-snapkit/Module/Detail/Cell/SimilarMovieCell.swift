//
//  SimilarMovieCell.swift
//  movies-snapkit
//
//  Created by Ezgi Sümer Günaydın on 3.09.2024.
//

import UIKit
import SnapKit

//MARK: - SimilarMovieCell
class SimilarMovieCell: UICollectionViewCell {
    
    //MARK: - UI Components
    private let image = UIImageView()
    private let nameLabel = UILabel()

    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Configuration
    final func configure(data: MovResult) {
        image.loadImage(with: data.backdropPath ?? "", cornerRadius: 8)
        nameLabel.text = data.title
    }
    
}

//MARK: - UI Setups
private extension SimilarMovieCell {
    final func setupUI() {
        addSubview(image)
        addSubview(nameLabel)
        makeImage()
        makeNameLabel()
    }
    
    final func makeImage() {
        image.clipsToBounds = true
        image.snp.makeConstraints { make in
            make.height.width.equalTo(120)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    final func makeNameLabel() {
        nameLabel.numberOfLines = 2
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(10)
            make.centerX.equalTo(image.snp.centerX)
            make.width.equalTo(image.snp.width)
        }
    }
}
