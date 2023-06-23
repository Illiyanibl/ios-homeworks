//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Illya Blinov on 8.05.23.
//

import UIKit

final class PhotosTableViewCell: UIView {
    
    var callBackTapView: (() -> Void)?
    
    let photoGallery = PhotoStruct.createLocalGallery()
    let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let arrowImg: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "arrow")
        return image
    }()
    
    lazy var  collectionView: UICollectionView = {
        let loyut = UICollectionViewFlowLayout()
        loyut.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: loyut)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.dataSource = self
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
        [cellView].forEach {self.addSubview($0) }
        self.backgroundColor = .white
        [photosLabel, collectionView, arrowImg].forEach {cellView.addSubview($0) }
        setConstraints()
        setupGesture()
    }
    func getCellH() -> CGFloat {
        return self.bounds.height
    }
    
    private func setupGesture(){
        let tapViewGesture = UITapGestureRecognizer(target: self, action: #selector(tapView))
        self.addGestureRecognizer(tapViewGesture)
    }
    
    @objc func tapView(){
        callBackTapView?()
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cellView.topAnchor.constraint(equalTo: self.topAnchor),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            photosLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 12),
            photosLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: 12),
            photosLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 12),
            
            arrowImg.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -12),
            arrowImg.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 4),
            collectionView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -4),
            collectionView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 0.28),
        ])
    }
}
extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    private var inset: CGFloat  { return 8}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("ok")
        
    }
    
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
        cell.setCornerRadius()
        
        return cell
    }
}
