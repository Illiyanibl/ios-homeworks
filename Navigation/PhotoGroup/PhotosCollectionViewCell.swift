//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Illya Blinov on 9.05.23.
//

import UIKit

final class PhotosCollectionViewCell: UICollectionViewCell {

    let cellView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cellView)
        customizeContenView()
        customizeCellView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func customizeContenView(){
        contentView.addSubview(cellView)
    }

    func customizeCellView(){
        cellView.contentMode = .scaleAspectFill
        cellView.layer.masksToBounds = true
    }
    func setCornerRadius() {
        cellView.layer.cornerRadius = 6
    }

    func setupConstraints(){
        NSLayoutConstraint.activate([
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    func setupSell(photo: PhotoStruct) {
        cellView.image = UIImage(named: photo.photoName)
    }
}
