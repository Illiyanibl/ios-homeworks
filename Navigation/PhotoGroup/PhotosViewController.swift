//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Illya Blinov on 7.05.23.
//

import UIKit

class PhotosViewController: UIViewController {
    
    lazy var  collectionView: UICollectionView = {
        let loyut = UICollectionViewFlowLayout()
        loyut.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: loyut)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.dataSource = self
        view.delegate = self
        view.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return view
    }()
    
    lazy var imageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var imageBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.alpha = 0.0
        return view
    }()
    
    lazy var btCloseBgView: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0.0
        button.addTarget(nil, action: #selector(tapBtClose), for: .touchUpInside)
        return button
    }()
    
    var callBackClose: (() -> Void)?
    
    let photoGallery = PhotoStruct.createLocalGallery()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        setupConstraints()
        collectionView.reloadData()
        
    }
    
    private func setupView(){
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        title = "Gallery"
        
    }
    
    
    private func setupConstraints(){
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor)
        ])
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout{
    
    private var inset: CGFloat  { return 8}
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - inset * 4) / 3
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

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoGallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.setupSell(photo: photoGallery[indexPath.item])
        cell.callBackShowImage = { [weak self] rect in
            guard let self = self else { return }
            let convertedRect = collectionView.convert(rect, to: self.view)
            self.showImage(rect: convertedRect, photo: self.photoGallery[indexPath.item])
        }
        return cell
    }
    
    func showImage(rect: CGRect, photo: PhotoStruct) {
        imageView.frame = rect
        imageView.layer.contents = UIImage(named: photo.photoName)?.cgImage
        setupImageGesture()
        view.addSubview(imageBackground)
        view.addSubview(btCloseBgView)
        view.addSubview(imageView)
        setupShowImageConstraint()
        imageAnimationOpen()
        callBackClose = { [weak self] in
            guard let self = self else { return }
            self.imageAnimationClose(rect: rect)
        }
    }
    func setupImageGesture(){
        let tapCollectionGesture = UITapGestureRecognizer(target: self, action: #selector(tapBtClose))
        imageView.addGestureRecognizer(tapCollectionGesture)
    }
    
    func closeImage(rect: CGRect) {
        imageBackground.removeFromSuperview()
        btCloseBgView.removeFromSuperview()
        imageView.removeFromSuperview()
    }
    
    func imageAnimationOpen(){
        //   let centerOrigin = avatar.center
        let finalCenter = self.view.center
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear) {
            self.imageView.frame = CGRect(x: 6, y: 6,
                                          width: self.view.frame.width - 12,
                                          height: self.view.frame.width - 12)
            self.imageView.center = CGPoint(x: finalCenter.x, y: finalCenter.y)
            self.imageBackground.alpha = 0.6}
        let btAnimator = UIViewPropertyAnimator(duration: 0.3, curve: .linear){
            self.btCloseBgView.alpha = 1.0
        }
        animator.addCompletion {_ in
            btAnimator.startAnimation(afterDelay: 0.0)
        }
        animator.startAnimation(afterDelay: 0.0)
    }
    func imageAnimationClose(rect: CGRect){
        let animatorBtClose = UIViewPropertyAnimator(duration: 0.3, curve: .linear){
            self.btCloseBgView.alpha = 0.0
        }
        let animatorImageClose = UIViewPropertyAnimator(duration: 0.5, curve: .linear){
            self.imageView.frame = rect
            self.imageBackground.alpha = 0.0
        }
        animatorBtClose.addCompletion {_ in
            animatorImageClose.startAnimation(afterDelay: 0.0)
        }
        animatorImageClose.addCompletion{_ in
            self.closeImage(rect: rect)
        }
        animatorBtClose.startAnimation(afterDelay: 0.0)
    }
    
    @objc func tapBtClose(){
        callBackClose?()
    }
    
    func setupShowImageConstraint(){
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            imageBackground.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            imageBackground.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            imageBackground.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            imageBackground.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            
            btCloseBgView.trailingAnchor.constraint(equalTo: imageBackground.trailingAnchor, constant: -6),
            btCloseBgView.topAnchor.constraint(equalTo: imageBackground.topAnchor, constant: 6),
        ])
    }
}
