//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Illya Blinov on 8.05.23.
//

import UIKit

final class PhotosTableViewCell: UITableViewCell {

    let photoGallery = PhotoStruct.createLocalGallery()
    let photosLabel: UILabel = {
        let label = UILabel()
        let labelFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.backgroundColor = .white
        label.font = labelFont
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.text = "Photos"
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    layout()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   

    func layout(){
        [photosLabel].forEach {contentView.addSubview($0) }
        contentView.backgroundColor = .white
        setConstraints()
    }

    func setConstraints() {
        NSLayoutConstraint.activate([

            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photosLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 12),
            photosLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ])
    }
}
