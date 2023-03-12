//
//  NodeBlockView.swift
//  toy-blocks-client-ios-uikit
//
//  Created by Vinicius Nadin on 12/03/23.
//

import UIKit

class NodeBlockView: UIView {
    
    // MARK: - Views
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor(red: 0.188, green: 0.31, blue: 0.996, alpha: 1)
        titleLabel.font = UIFont(name: "Roboto-Bold", size: 10)
        return titleLabel
    }()
    
    lazy var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byWordWrapping
        contentLabel.textColor = UIColor(red: 0.149, green: 0.196, blue: 0.22, alpha: 1)
        return contentLabel
    }()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12)
        layer.cornerRadius = 2
        
        let padding: CGFloat = 8.0
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
        
        addSubview(contentLabel)
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.0),
            contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
