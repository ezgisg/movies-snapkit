//
//  SimilarMovieCell.swift
//  movies-snapkit
//
//  Created by Ezgi Sümer Günaydın on 3.09.2024.
//

import UIKit
import SnapKit
import TinyConstraints

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
//        snapkitFunctions()
        tinyConstraintsFunctions()
    }
    
    final func snapkitFunctions() {
        makeImageWithSnapkit()
        makeNameLabelWithSnapkit()
    }
    
    final func tinyConstraintsFunctions() {
        makeImageWithTiny()
        makeNameLabelWithTiny()
    }
    
    
    
    final func makeImageWithSnapkit() {
        image.snp.makeConstraints { make in
            make.height.width.equalTo(120)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    final func makeNameLabelWithSnapkit() {
        nameLabel.numberOfLines = 2
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(10)
            make.centerX.equalTo(image.snp.centerX)
            make.width.equalTo(image.snp.width)
        }
    }
    
    final func makeImageWithTiny() {
        image.height(120)
        image.aspectRatio(1)
        image.topToSuperview()
        image.centerXToSuperview()
    }
    
    final func makeNameLabelWithTiny() {
        nameLabel.numberOfLines = 2
        nameLabel.topToBottom(of: image, offset: 10)
        nameLabel.centerX(to: image)
        nameLabel.width(to: image)
    }
    
}
