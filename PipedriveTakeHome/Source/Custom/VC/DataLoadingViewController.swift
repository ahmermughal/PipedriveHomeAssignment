//
//  DataLoadingViewController.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 01/07/2023.
//

import UIKit

class DataLoadingViewController: UIViewController {

    var containerView: UIView!

    func showLoadingView() {
        /// Create and show the loading view
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)

        /// Customize the appearance of the loading view
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0

        /// Animate the fade-in effect for the loading view
        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
        }

        /// Add an activity indicator to the loading view
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)

        /// Configure constraints for the activity indicator
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])

        /// Start animating the activity indicator
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if self.containerView != nil {
                /// Dismiss and remove the loading view from the superview
                self.containerView.removeFromSuperview()
                self.containerView = nil
            }
        }
    }

}

