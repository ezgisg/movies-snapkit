//
//  DetailViewController.swift
//  movies-snapkit
//
//  Created by Ezgi Sümer Günaydın on 3.09.2024.
//

import UIKit
import SnapKit

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
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var collectionViewBottomConstraint: ConstraintMakerEditable? = nil
    
    //MARK: - Module Components
    private var viewModel: DetailViewModelProtocol
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
        view.addSubview(collectionView)
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
        
        DispatchQueue.main.async {  [weak self] in
            guard let self else { return }
            navigationController?.navigationBar.tintColor = .systemYellow
            navigationController?.navigationBar.backgroundColor = .clear

        }
        
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
        verticalStack.axis = .vertical
        verticalStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.left.equalToSuperview()
        }
    }
    
    final func makeTopImage() {
        topImage.snp.makeConstraints { make in
            make.height.equalTo(topImage.snp.width).multipliedBy(0.7)
        }
    }
    
    final func makeTitleLabelContainer() {
        titleLabelContainer.backgroundColor = .white
        titleLabelContainer.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top).offset(-12)
            make.bottom.equalTo(titleLabel.snp.bottom).offset(12)
        }
    }
    
    final func makeTitleLabel() {
        titleLabel.textAlignment = .left
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabelContainer.snp.left).offset(12)
            make.right.equalTo(titleLabelContainer.snp.right).offset(-12)
        }
    }
    
    final func makeTextViewContainer() {
        textViewContainer.backgroundColor = .blue
    }
    
    final func makeTextView() {
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    final func makeHorizontalStack() {
        horizontalStack.axis = .horizontal
    }
    
    final func makeButtonContainer() {
        buttonContainer.backgroundColor = .clear
        buttonContainer.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
    }
    
    final func makeButton() {
        button.backgroundColor = .systemYellow
        button.setTitle("Add to Favorites", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 4
        button.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.centerY.equalToSuperview()
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 3, left: 8, bottom: 3, right: 8))
        }
    }
    
    final func makeRateLabel() {
        rateLabel.textAlignment = .center
    }
    
    final func makeImdbImage() {
        imdbImage.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
    }
    
    final func makeCollectionViewTitleContainer() {
        
    }
    
    final func makeCollectionViewTitle() {
        
    }
    
    final func makeCollectionView() {
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemPink
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.top.equalTo(verticalStack.snp.bottom)
            collectionViewBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.right.left.equalToSuperview()
        }
    }
    
}

extension DetailViewController: DetailViewModelDelegate {
    func reloadData() {
        //        collectionView.reloadData()
        guard let detail = viewModel.movieDetail else { return }
        topImage.loadImage(with: detail.backdrop_path ?? "")
        titleLabel.text = detail.title
        imdbImage.image = UIImage(named: "imdb")
        rateLabel.text = String(format: "%.1f", detail.vote_average ?? 0)
        textView.text = detail.overview
        textView.font = .systemFont(ofSize: 18)
        textView.layoutIfNeeded()
        
        let textViewHeight = textView.frame.height
        let textViewContentHeight = textView.contentSize.height
        print("textViewHeight:\(textViewHeight) textViewContentHeight:\(textViewContentHeight)")
        
        guard textViewContentHeight < textViewHeight else { return }
        textViewContainer.snp.makeConstraints { make in
            make.height.equalTo(textViewContentHeight)
        }
        collectionViewBottomConstraint?.constraint.deactivate()
        collectionView.snp.makeConstraints() { make in
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
    
}
