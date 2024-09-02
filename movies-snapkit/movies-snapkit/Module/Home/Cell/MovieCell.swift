//
//  MovieCell.swift
//  movies-snapkit
//
//  Created by Ezgi Sümer Günaydın on 2.09.2024.
//

import UIKit
import SnapKit

class MovieCell: UITableViewCell {
    
    private let containerView: UIView = UIView()
    private let movieImage: UIImageView = UIImageView()
    private let movieTitle: UILabel = UILabel()
    private let movieDescription: UILabel = UILabel()
    private let horizontalStack: UIStackView = UIStackView()
    private let verticalStack: UIStackView = UIStackView()
    private let detailTextContainerView: UIView = UIView()
    private let detailLabel: UILabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupUI()
    }
    
    final func configure(result: MovResult?) {
        guard let result else { return }
        movieTitle.text = result.originalTitle
        movieDescription.text = result.overview
        detailLabel.text = result.releaseDate
        movieImage.loadImage(with: result.backdropPath ?? "", cornerRadius: 12)
    }

}

private extension MovieCell {
    final func setupUI() {
        self.addSubview(containerView)
        containerView.addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(movieImage)
        horizontalStack.addArrangedSubview(verticalStack)
        verticalStack.addArrangedSubview(movieTitle)
        verticalStack.addArrangedSubview(movieDescription)
        verticalStack.addArrangedSubview(detailTextContainerView)
        detailTextContainerView.addSubview(detailLabel)
        
        makeContainer()
        makeHorizontalStack()
        makeMovieImage()
        makeVerticalStack()
        makeMovieTitle()
        makeMovieDescription()
        makeDetailLabel()
        makeDetailContainer()
    }
    
    final func makeContainer() {
        containerView.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview()
            make.right.left.equalToSuperview()
        }
    }
    
    final func makeHorizontalStack() {
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .fill
        horizontalStack.distribution = .fill
        horizontalStack.spacing = 8
        horizontalStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
    }
    
    final func makeMovieImage() {
        movieImage.clipsToBounds = true
        movieImage.snp.makeConstraints { make in
            make.height.width.equalTo(150).priority(999)
        }
    }
    
    final func makeVerticalStack() {
        verticalStack.axis = .vertical
        verticalStack.alignment = .fill
        verticalStack.distribution = .fill
        verticalStack.spacing = 1
    }
    
    final func makeMovieTitle() {
        movieTitle.font = .boldSystemFont(ofSize: 24)
        movieTitle.setContentHuggingPriority(UILayoutPriority(254), for: .vertical)
        movieTitle.setContentCompressionResistancePriority(UILayoutPriority(753), for: .vertical)
        movieTitle.numberOfLines = 0
        movieTitle.textColor = .black
    }
    final func makeMovieDescription() {
        movieDescription.numberOfLines = 0
        movieDescription.textColor = .black
    }
    
    final func makeDetailContainer() {
        detailTextContainerView.setContentHuggingPriority(UILayoutPriority(256), for: .vertical)
        detailTextContainerView.setContentCompressionResistancePriority(UILayoutPriority(754), for: .vertical)
        detailTextContainerView.snp.makeConstraints { make in
            make.height.equalTo(detailLabel.snp.height)
        }
    }
    
    final func makeDetailLabel() {
        detailLabel.font = .systemFont(ofSize: 12, weight: .light)
        detailLabel.setContentHuggingPriority(UILayoutPriority(257), for: .vertical)
        detailLabel.setContentCompressionResistancePriority(UILayoutPriority(757), for: .vertical)
        detailLabel.textAlignment = .right
        detailLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
