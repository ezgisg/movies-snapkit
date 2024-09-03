//
//  DetailViewController.swift
//  movies-snapkit
//
//  Created by Ezgi Sümer Günaydın on 3.09.2024.
//

import UIKit

//MARK: - DetailViewController
class DetailViewController: UIViewController {
    
    //MARK: - UI Components
    let verticalStack: UIStackView = UIStackView()
    
    let topImage: UIImageView = UIImageView()
    let titleLabelContainer: UIView = UIView()
    let titleLabel: UILabel = UILabel()
    let textViewContainer: UIView = UIView()
    let textView: UITextView = UITextView()
    
    let horizontalStack: UIStackView = UIStackView()
    let buttonContainer: UIView = UIView()
    let button: UIButton = UIButton()
    let rateLabel: UILabel = UILabel()
    let imdbImage: UIImageView = UIImageView()
    
    let collectionViewTitleContainer: UIView = UIView()
    let collectionViewTitle: UILabel = UILabel()
    
//    let collectionView: UICollectionView = UICollectionView()
    
    //MARK: - Module Components
    private var viewModel: DetailViewModelProtocol
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        viewModel.delegate = self
        viewModel.fetchDetail()
        setupUI()
    }
    
    //MARK: - Init
    init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension DetailViewController {
    final func setupUI() {
        
        view.addSubview(verticalStack)
//        view.addSubview(collectionView)
        verticalStack.addArrangedSubview(topImage)
        verticalStack.addArrangedSubview(titleLabelContainer)
        titleLabelContainer.addSubview(titleLabel)
        verticalStack.addArrangedSubview(textViewContainer)
        textViewContainer.addSubview(textView)
        verticalStack.addArrangedSubview(horizontalStack)
        horizontalStack.addArrangedSubview(buttonContainer)
        buttonContainer.addSubview(button)
        horizontalStack.addArrangedSubview(rateLabel)
        horizontalStack.addArrangedSubview(imdbImage)
        verticalStack.addArrangedSubview(collectionViewTitleContainer)
        collectionViewTitleContainer.addSubview(collectionViewTitle)
        
        makeVerticalStack()
        makeTopImage()
        makeTitleLabelContainer()
        makeTitleLabel()
        makeTextViewContainer()
        makeTextView()
        makeHorizontalStack()
        makeButtonContainer()
        makeButton()
        makeRateLabel()
        makeImdbImage()
        makeCollectionViewTitleContainer()
        makeCollectionViewTitle()
        makeCollectionView()
    }
    
    final func makeVerticalStack() {
        
    }
    
    final func makeTopImage() {
        
    }
    
    final func makeTitleLabelContainer() {
        
    }
    
    final func makeTitleLabel() {
        
    }
    
    final func makeTextViewContainer() {
        
    }
    
    final func makeTextView() {
        
    }
    
    final func makeHorizontalStack() {
        
    }
    
    final func makeButtonContainer() {
        
    }
    
    final func makeButton() {
        
    }
    
    final func makeRateLabel() {
        
    }
    
    final func makeImdbImage() {
        
    }
    
    final func makeCollectionViewTitleContainer() {
        
    }
    
    final func makeCollectionViewTitle() {
        
    }
    
    final func makeCollectionView() {
        
    }
    
}

extension DetailViewController: DetailViewModelDelegate {
    func reloadData() {
//        collectionView.reloadData()
        print(viewModel.movieDetail)
    }
}
