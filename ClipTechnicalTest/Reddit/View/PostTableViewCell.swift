//
//  PostTableViewCell.swift
//  ClipTechnicalTest
//
//  Created by Carlos Tevez on 06/06/2024.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    // MARK:  Private Vars
    private var data: Reddit.FetchTopPosts.ViewModel.DisplayedPost?
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.spacing = 16
        
        stack.addArrangedSubview(foodImageView)
        stack.addArrangedSubview(labelsStack)
        
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        stack.layer.cornerRadius = 10
        
        return stack
    }()
    
    private lazy var labelsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 7
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(subRedditStack)
        
        return stack
    }()
    
    private lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
        // TODO: Default image
        imageView.image = UIImage(systemName: "circle.square")
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.numberOfLines = 0
        label.textColor = UIColor.init(hexString: Constants.Colors.mainFont)
        
        return label
    }()
    
    private lazy var subRedditStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 2
        
        stack.addArrangedSubview(iconImageView)
        stack.addArrangedSubview(subredditLabel)
        
        return stack
    }()
    
    private lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        image.image = UIImage(systemName: "arrowshape.bounce.right.fill")
        image.tintColor = UIColor.init(hexString: Constants.Colors.secondaryFont)
        return image
    }()
    
    private lazy var subredditLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = UIColor.init(hexString: Constants.Colors.secondaryFont)
        
        return label
    }()
    
    // MARK: Object lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // MARK: Public methods
    func configure(with data: Reddit.FetchTopPosts.ViewModel.DisplayedPost, indexPath: IndexPath) {
        titleLabel.text = data.title
        
        if let url = data.imageUrl {
            foodImageView.load(url: url, indexPath: indexPath)
        }
        
        subredditLabel.text = data.subreddit
    }
    
    // MARK:  Private methods
    private func setupUI() {
        configureUI()
        addSubviews()
        configureLayout()
    }
    
    private func configureUI() {
        contentView.layer.applySketchShadow(color: .black, alpha: 0.5, x: 0, y: 0, blur: 7)
        backgroundColor = .white
        contentStack.backgroundColor = UIColor.init(hexString: Constants.Colors.orange)
    }
    
    private func addSubviews() {
        contentView.addSubview(contentStack)
    }
    
    private func configureLayout() {
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        
        // Constrains for contentStack
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            contentStack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            contentStack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])
        
        // Constrains for foodImageView
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            foodImageView.heightAnchor.constraint(equalToConstant: 88),
            foodImageView.widthAnchor.constraint(equalToConstant: 88)
        ])
        
        // Constrains for iconImageView
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            iconImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
}
