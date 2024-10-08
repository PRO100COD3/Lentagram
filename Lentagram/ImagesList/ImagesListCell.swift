import Foundation
import UIKit
import Kingfisher


protocol ImagesListCellDelegate: AnyObject {
    func imageListCellDidTapLike(
        _ cell: ImagesListCell,
        completion: @escaping (Bool) -> Void
    )
}

final class ImagesListCell: UITableViewCell {
    static let reusedIdentifier = "ImagesListCell"
    
    weak var delegate: ImagesListCellDelegate?
    
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var cellImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImage.kf.cancelDownloadTask()
    }
    
    @IBAction func likeButtonClicked(sender: Any) {
        delegate?.imageListCellDidTapLike(self){ [weak self] isLiked in
            guard let self = self else {
                print("[ImagesListCell]: Error in ImagesListCell")
                return
            }
            self.setImageLike(isLiked: isLiked)
        }
    }
    func setImageCell(image: UIImage, date: String, isLiked: Bool ) {
        cellImage.image = image
        dateLabel.text = date
        setImageLike(isLiked: isLiked)
    }
    
    func setImageLike(isLiked: Bool) {
        guard let imageLike = UIImage(named: isLiked ? "Active" : "No Active") else { return }
        likeButton.setImage(imageLike, for: .normal)
    }
}
