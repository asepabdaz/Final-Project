

import UIKit

struct CardContentViewModel {
    let primary: String
    let secondary: String
    let description: String
    let image: UIImage
    let material: [[String:String]]
    let after: String
    let storyBoard: String

    func highlightedImage() -> CardContentViewModel {
        let scaledImage = image.resize(toWidth: image.size.width * GlobalConstants.cardHighlightedFactor)
        return CardContentViewModel(primary: primary,
                                    secondary: secondary,
                                    description: description,
                                    image: scaledImage, material: material, after: after, storyBoard: storyBoard)
    }
}
