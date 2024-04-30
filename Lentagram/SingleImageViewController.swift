//
//  SingleImageViewController.swift
//  Lentagram
//
//  Created by Вадим Дзюба on 04.04.2024.
//

import UIKit
class SingleImageViewController: UIViewController{
    var image: UIImage? {
        didSet {
            guard isViewLoaded else { return }
            allScreenImageView.image = image
            guard let image else {
                return
            }
            allScreenImageView.image = image
            allScreenImageView.frame.size = image.size
            rescaleAndCenterImageInScrollView(image: image)
        }
    }
    override func viewDidLoad() {
        guard let image else {
            return
        }
        super.viewDidLoad()
        allScreenImageView.image = image
        allScreenImageView.frame.size = image.size
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 1.25
        rescaleAndCenterImageInScrollView(image: image)
    }
    
    @IBOutlet var allScreenImageView: UIImageView!
    @IBOutlet var scrollView: UIScrollView!
    
    @IBAction func didTapBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func didTapShareButton(_ sender: Any) {
        guard let image else { return }
        let share = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(share, animated: true, completion: nil)
    }
    private func rescaleAndCenterImageInScrollView(image: UIImage) {
        let minZoomScale = scrollView.minimumZoomScale
        let maxZoomScale = scrollView.maximumZoomScale
        view.layoutIfNeeded()
        let visibleRectSize = scrollView.bounds.size
        let imageSize = image.size
        let hScale = visibleRectSize.width / imageSize.width
        let vScale = visibleRectSize.height / imageSize.height
        let scale = min(maxZoomScale, max(minZoomScale, min(hScale, vScale)))
        scrollView.setZoomScale(scale, animated: false)
        scrollView.layoutIfNeeded()
        let newContentSize = scrollView.contentSize
        let x = (newContentSize.width - visibleRectSize.width) / 2
        let y = (newContentSize.height - visibleRectSize.height) / 2
        scrollView.setContentOffset(CGPoint(x: x, y: y), animated: false)
    }
}
extension SingleImageViewController: UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return allScreenImageView
    }
}
