//
//  FavouriteCell.swift
//  GenerateImageTest
//
//  Created by Anton  on 24.05.2023.
//

import UIKit

final class FavouriteCell: UITableViewCell {
    
    private let favouriteImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUp()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubviewAndTamic(favouriteImageView)
        contentView.addSubviewAndTamic(titleLabel)
    }
}

//MARK: - setUpCell
extension FavouriteCell {
    
    func setUpCell(model: FavouriteImageCellModel) -> Self {
        favouriteImageView.image = model.image
        titleLabel.text = model.userQuery
        
        return self
    }
}

//MARK: - Layout
extension FavouriteCell {
    
    func setConstraints() {
        
        let marginGuide = contentView.layoutMarginsGuide
        let imageHeight: CGFloat = Constants.imageHeight
        let horizontalPadding: CGFloat = Constants.horizontalPadding
        let verticalPadding: CGFloat = Constants.verticalPadding
        
        NSLayoutConstraint.activate([
            favouriteImageView.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: verticalPadding),
            favouriteImageView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: horizontalPadding),
            favouriteImageView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: -verticalPadding),
            favouriteImageView.widthAnchor.constraint(equalToConstant: imageHeight),
            favouriteImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            
            titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: verticalPadding),
            titleLabel.leadingAnchor.constraint(equalTo: favouriteImageView.trailingAnchor, constant: horizontalPadding),
            titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -horizontalPadding),
            titleLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: -verticalPadding)
        ])
    }
}

private extension FavouriteCell {
    enum Constants {
        static let imageHeight: CGFloat = 60
        static let horizontalPadding: CGFloat = 16
        static let verticalPadding: CGFloat = 8
    }
}

