//
//  CardContentViewModel.swift
//  AppStoreInteractiveTransition
//
//  Created by Wirawit Rueopas on 31/7/18.
//  Copyright © 2018 Wirawit Rueopas. All rights reserved.
//

import UIKit

struct CardContentViewModel {
    let primary: String
    let secondary: String
    let description: String
    let image: UIImage
    let material: [[String:String]]
    let after: String
    let storyBoard: String
    let descTable: [String]

    func highlightedImage() -> CardContentViewModel {
        let scaledImage = image.resize(toWidth: image.size.width * GlobalConstants.cardHighlightedFactor)
        return CardContentViewModel(primary: primary,
                                    secondary: secondary,
                                    description: description,
                                    image: scaledImage, material: material, after: after, storyBoard: storyBoard, descTable: descTable)
    }
}
