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
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: 140, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var collectionViewBottomConstraint: ConstraintMakerEditable? = nil
    var collectionViewBottomConstraint2: NSLayoutConstraint? = nil
    
    //MARK: - Module Components
    private var viewModel: DetailViewModelProtocol
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.delegate = self
        viewModel.fetchDetail()
        viewModel.fetchSimilars()
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

//MARK: - UI Setups
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
//        snapkitFunctions()
        tinyConstraintsFunctions()

    }
    
    final func snapkitFunctions() {
        makeVerticalStackWithSnapkit()
        makeTopImageWithSnapkit()
        makeTitleLabelContainerWithSnapkit()
        makeTitleLabelWithSnapkit()
        makeTextViewContainerWithSnapkit()
        makeTextViewWithSnapkit()
        makeHorizontalStackWithSnapkit()
        makeButtonContainerWithSnapkit()
        makeButtonWithSnapkit()
        makeRateLabelWithSnapkit()
        makeImdbImageWithSnapkit()
        makeCollectionViewTitleContainerWithSnapkit()
        makeCollectionViewTitleWithSnapkit()
        makeCollectionViewWithSnapkit()
    }
    
    final func tinyConstraintsFunctions() {
        makeVerticalStackWithTiny()
        makeTopImageWithTiny()
        makeTitleLabelContainerWithTiny()
        makeTitleLabelWithTiny()
        makeTextViewContainerWithTiny()
        makeTextViewWithTiny()
        makeHorizontalStackWithTiny()
        makeButtonContainerWithTiny()
        makeButtonWithTiny()
        makeRateLabelWithTiny()
        makeImdbImageWithTiny()
        makeCollectionViewTitleContainerWithTiny()
        makeCollectionViewTitleWithTiny()
        makeCollectionViewWithTiny()
    }
    
    final func makeVerticalStackWithSnapkit() {
        verticalStack.axis = .vertical
        verticalStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.left.equalToSuperview()
        }
    }
    
    final func makeVerticalStackWithTiny() {
        verticalStack.axis = .vertical
        verticalStack.topToSuperview()
        verticalStack.rightToSuperview()
        verticalStack.leftToSuperview()
    }
    
    final func makeTopImageWithSnapkit() {
        topImage.snp.makeConstraints { make in
            make.height.equalTo(topImage.snp.width).multipliedBy(0.7)
        }
    }
    
    final func makeTopImageWithTiny() {
        topImage.heightToWidth(of: topImage, multiplier: 0.7)
    }
    
    final func makeTitleLabelContainerWithSnapkit() {
        titleLabelContainer.backgroundColor = .white
        titleLabelContainer.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top).offset(-12)
            make.bottom.equalTo(titleLabel.snp.bottom).offset(12)
        }
    }
    
    final func makeTitleLabelContainerWithTiny() {
        titleLabelContainer.backgroundColor = .white
        titleLabelContainer.top(to: titleLabel, offset: -12)
        titleLabelContainer.bottom(to: titleLabel, offset: 12)
    }
    
    final func makeTitleLabelWithSnapkit() {
        titleLabel.textAlignment = .left
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabelContainer.snp.left).offset(4)
            make.right.equalTo(titleLabelContainer.snp.right).offset(-4)
        }
    }
    
    final func makeTitleLabelWithTiny() {
        titleLabel.textAlignment = .left
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.left(to: titleLabelContainer, offset: 4)
        titleLabel.right(to: titleLabelContainer, offset: -4)
    }
        
    final func makeTextViewContainerWithSnapkit() {
        textViewContainer.backgroundColor = .blue
    }
    
    final func makeTextViewContainerWithTiny() {
        textViewContainer.backgroundColor = .blue
    }

    final func makeTextViewWithSnapkit() {
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    final func makeTextViewWithTiny() {
        textView.edgesToSuperview()
    }
        
    final func makeHorizontalStackWithSnapkit() {
        horizontalStack.axis = .horizontal
    }
    
    final func makeHorizontalStackWithTiny() {
        horizontalStack.axis = .horizontal
    }
        
    final func makeButtonContainerWithSnapkit() {
        buttonContainer.backgroundColor = .clear
        buttonContainer.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
    }
    
    final func makeButtonContainerWithTiny() {
        buttonContainer.backgroundColor = .clear
        buttonContainer.height(48)
    }
    
    final func makeButtonWithSnapkit() {
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
    
    final func makeButtonWithTiny() {
        button.backgroundColor = .systemYellow
        button.setTitle("Add to Favorites", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 4
        button.width(160)
        button.centerYToSuperview()
        button.edgesToSuperview(insets: .init(top: 3, left: 8, bottom: 3, right: 8))
    }
    
    final func makeRateLabelWithSnapkit() {
        rateLabel.textAlignment = .center
    }
    
    final func makeRateLabelWithTiny() {
        rateLabel.textAlignment = .center
    }
    
    final func makeImdbImageWithSnapkit() {
        imdbImage.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
    }
    
    final func makeImdbImageWithTiny() {
        imdbImage.width(80)
    }
    
    final func makeCollectionViewTitleContainerWithSnapkit() {
        collectionViewTitleContainer.snp.makeConstraints { make in
            make.top.equalTo(collectionViewTitle.snp.top).offset(-6)
            make.bottom.equalTo(collectionViewTitle.snp.bottom).offset(6)
        }
    }
    
    final func makeCollectionViewTitleContainerWithTiny() {
        collectionViewTitleContainer.top(to: collectionViewTitle, offset: -6)
        collectionViewTitleContainer.bottom(to: collectionViewTitle, offset: 6)
    }
    
    final func makeCollectionViewTitleWithSnapkit() {
        collectionViewTitle.text = "Similar Movies"
        collectionViewTitle.font = .boldSystemFont(ofSize: 20)
        collectionViewTitle.snp.makeConstraints { make in
            make.left.equalTo(collectionViewTitleContainer.snp.left).offset(12)
            make.right.equalTo(collectionViewTitleContainer.snp.right).offset(-12)
        }
    }
    
    final func makeCollectionViewTitleWithTiny() {
        collectionViewTitle.text = "Similar Movies"
        collectionViewTitle.font = .boldSystemFont(ofSize: 20)
        collectionViewTitle.left(to: collectionViewTitleContainer, offset: 12)
        collectionViewTitle.right(to: collectionViewTitleContainer, offset: -12)
    }
        
    final func makeCollectionViewWithSnapkit() {
        collectionView.dataSource = self
        collectionView.register(cellWithClass: SimilarMovieCell.self)
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.top.equalTo(verticalStack.snp.bottom)
            collectionViewBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.right.left.equalToSuperview()
        }
    }
    
    final func makeCollectionViewWithTiny() {
        collectionView.dataSource = self
        collectionView.register(cellWithClass: SimilarMovieCell.self)
        collectionView.height(200)
        collectionView.topToBottom(of: verticalStack)
        collectionViewBottomConstraint2 = collectionView.bottomToSuperview(usingSafeArea: true)
        collectionView.rightToSuperview()
        collectionView.leftToSuperview()
    }
    
}

//MARK: - DetailViewModelDelegate
extension DetailViewController: DetailViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
    
    func configureData() {
        guard let detail = viewModel.movieDetail else { return }
        topImage.loadImage(with: detail.backdrop_path ?? "", cornerRadius: 0)
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
//        textViewContainer.snp.makeConstraints { make in
//            make.height.equalTo(textViewContentHeight)
//        }
//        collectionViewBottomConstraint?.constraint.deactivate()
//        collectionView.snp.makeConstraints() { make in
//            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom)
//        }
//        
        collectionViewBottomConstraint2?.isActive = false
        textViewContainer.height(textViewContentHeight)
        collectionView.bottomToSuperview(relation: .equalOrLess, usingSafeArea: true)
    }
}

//MARK: - UICollectionViewDataSource
extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.similars?.results?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: SimilarMovieCell.self, for: indexPath)
        guard let data = viewModel.similars?.results?[indexPath.row] else { return cell}
        cell.configure(data: data)
        return cell
    }
    
}
