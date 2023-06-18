//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Illya Blinov on 9.05.23.
//

import UIKit

final class PhotosCollectionViewCell: UICollectionViewCell {

    var callBackShowImage: ((CGRect) -> Void)?

    let cellView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func layout(){
        contentView.addSubview(cellView)

        setupGesture()
        setupConstraints()
    }

    func setupGesture(){
        let tapCollectionGesture = UITapGestureRecognizer(target: self, action: #selector(tapCollection))
        self.addGestureRecognizer(tapCollectionGesture)
    }

    @objc func tapCollection(){
        print("Tap Collection")
        callBackShowImage?(self.frame)
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

extension PhotosCollectionViewCell: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("no")

    }

}

