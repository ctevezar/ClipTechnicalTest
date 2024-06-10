//
//  InfoView.swift
//  ClipTechnicalTest
//
//  Created by Carlos Tevez on 07/06/2024.
//

import UIKit

struct InfoData {
    let image: UIImage?
    let title: String
    let description: String?
}

class InfoView: UIView {
    // MARK:  Public Vars
    var data: InfoData? {
        didSet {
            configure()
        }
    }
    
    // MARK:  Private Vars
    private lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "SearchInstruction")
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Search something".localized
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "pepe"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        
        return label
    }()

    // MARK: Object lifecycle
    init(with data: InfoData) {
        super.init(frame: .zero)
        setupUI()
        
        defer {
            self.data = data
        }
    }
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    // MARK:  Private methods
    private func configure() {
        iconImageView.image = data?.image
        titleLabel.text = data?.title
        descriptionLabel.text = data?.description
    }
    
    private func setupUI() {
        configureUI()
        addSubviews()
        configureLayout()
    }
    
    private func configureUI() {
        backgroundColor = .white
    }
    
    private func addSubviews() {
        
        addSubview(contentView)
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    private func configureLayout() {
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            contentView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
        ])
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            iconImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 50),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
