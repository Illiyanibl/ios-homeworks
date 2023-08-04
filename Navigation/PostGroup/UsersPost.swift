//
//  UsersPost.swift
//  Navigation
//
//  Created by Illya Blinov on 1.05.23.
//

import Foundation

struct UsersPost {

    let author: String
    var description: String
    var image: String
    var likes: Int
    var views: Int

    static func createPost() -> [UsersPost] {
        var postList = [UsersPost]()
        postList.append(UsersPost(author: "Exploration",
                                  description: "Habitable new planet found! Scientists assume the existence of life on two planets of the far star 192114HEMX, namely on planets number 3 and 4 (192114HeMX - 3 and 192114HeMX - 4). Probably there is a lot of water on the planets and there is an atmosphere. The neural network has already generated what alien landscapes might look like.",
                                  image: "IMG_1165",
                                  likes: 42000,
                                  views: 3471118))
        postList.append(UsersPost(author: "Isaac Asimov", description: "Не пропустите скоро стартует первый сезон шоу Все любят Гипножабу", image: "everybody", likes: 999999, views: 999999))
        postList.append(UsersPost(author: "Геннадий Детинич",
                                  description: "Японским астрономам под руководством Шуна Иноуэ (Shun Inoue) из Киотского университета удалось поймать сильнейшую за всю историю наблюдений вспышку на звезде. К счастью, наше Солнце не такое активное, как одна из звёзд в двойной системе V1355 Orionis, которая и произвела эту вспышку. Событие произошло на удалении 400 световых лет от нас и никак не могло повлиять на космическую погоду в нашей системе, но в своей родной системе оно могло наделать беды.", image: "star_f", likes: 5404, views: 61220))
        postList.append(UsersPost(author: "Артём Баусов", description: "На прошедшей 5 июня WWDC Apple представила 15-дюймовый MacBook Air. Устройство работает под управлением процессоров M2", image: "IMG_8168", likes: 4915, views: 56820))
        return postList
    }

}
