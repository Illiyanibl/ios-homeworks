//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Illya Blinov on 8.05.23.
//

import UIKit

final class PhotosTableViewCell: UIView {

    let photoGallery = PhotoStruct.createLocalGallery()

    lazy  var   collectionView: UICollectionView = {
        let loyut = UICollectionViewFlowLayout()
        loyut.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: loyut)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.dataSource =  self
        view.delegate = self
        view.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return view
    }()

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

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func layout(){
        [collectionView, photosLabel].forEach {self.addSubview($0) }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        
         setConstraints()
    }

    func setConstraints() {
        NSLayoutConstraint.activate([

            photosLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            photosLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),

            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            collectionView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 4),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 4),
            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.25, constant: 12),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ])
    }

}
extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {

    private var inset: CGFloat  { return 8}

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - inset * 5) / 4
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return inset
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return inset
    }
    

}
extension PhotosTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoGallery.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.setupSell(photo: photoGallery[indexPath.item])
        return cell
    }

}
