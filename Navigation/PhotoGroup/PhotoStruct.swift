//
//  PhotoStruct.swift
//  Navigation
//
//  Created by Illya Blinov on 8.05.23.
//

import Foundation

struct PhotoStruct {
    var photoName: String
    var isLocalPhoto: Bool = true
    var urlPhoto: String? = nil

    static func createLocalGallery() -> [PhotoStruct] {
        var photoList: [PhotoStruct] = []
        let photoName: [String] = ["IMG_0859", "IMG_0881", "IMG_0912", "IMG_0922", "IMG_0927",
                                   "IMG_0927_1", "IMG_0979", "IMG_0992", "IMG_0992_1", "IMG_1018",
                                   "IMG_1060", "IMG_1072", "IMG_1088", "IMG_1104", "IMG_1165_1",
                                   "IMG_1206", "IMG_1662", "IMG_1690", "IMG_1770", "IMG_1819"]
        photoName.forEach() {photoList.append(PhotoStruct(photoName: $0)) }
        return photoList
    }
}
