//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Illya Blinov on 7.05.23.
//

import UIKit

class PhotosViewController: UIViewController {

    lazy var  photoCollectionView: UICollectionView = {
        let loyut = UICollectionViewFlowLayout()
        loyut.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: loyut)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .cyan
        view.dataSource = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }


}
