//
//  ImageViewController.swift
//  GenerateImageTest
//
//  Created by Anton  on 23.05.2023.
//

import UIKit

final class ImageViewController: UIViewController {
    
    private var searchBar = SearchBar()
    private let imageView = UIImageView()
    private let generateButton = CustomButton(title: "Сгенерировать")
    private let favouritesButton = CustomButton(title: "В избранное")
    private let activityIndicator = UIActivityIndicatorView()
    private let containerViewImage = UIView()
    private let alertService = CustomAlert()
    
    private let generateImageStorage: GenerateImageStorageProtocol = GenerateImageStorage.shared
    private let networkService: NetworkServiceProtocol = NetworkService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        setConstraints()
    }
    
    private func setUpViews() {
        
        searchBar.accessibilityIdentifier = "searchBar"
        view.addSubviewAndTamic(searchBar)
        
        imageView.accessibilityIdentifier = "imageView"
        imageView.backgroundColor = .lightGray.withAlphaComponent(0.2)
        view.addSubviewAndTamic(imageView)
        
        imageView.addSubviewAndTamic(activityIndicator)
        activityIndicator.hidesWhenStopped = true
        
        generateButton.accessibilityIdentifier = "generateButton"
        view.addSubviewAndTamic(generateButton)
        generateButton.addTarget(self,
                                 action: #selector(generateButtonTapped),
                                 for: .touchUpInside)
        
        view.addSubviewAndTamic(favouritesButton)
        favouritesButton.isHidden = true
        favouritesButton.addTarget(self,
                                   action: #selector(favouritesButtonTapped),
                                   for: .touchUpInside)
    }
}

//MARK: - Network request
extension ImageViewController {
    
    func downloadImage() {
        
        imageView.image = nil
        
        networkService.downloadImage(by: searchBar.text ?? "",
                                     completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let imageDowloaded):
                let image = UIImage(data: imageDowloaded)
                
                if let image = image {
                    self.imageView.image = image
                    self.favouritesButton.isHidden = false
                    self.activityIndicator.stopAnimating()
                    return
                }
                let alertController = self.alertService.alertImageTransform()
                self.present(alertController, animated: true)
            case .failure(let error):
                self.activityIndicator.stopAnimating()
                let alertController = self.alertService.alertImageDowload(error: error)
                self.present(alertController, animated: true)
            }
        })
    }
}

//MARK: - Button Action
extension ImageViewController {
    
    @objc func generateButtonTapped() {
        
        let buttonTapTimeKey = "LastGenerateButtonTapTime"
        
        activityIndicator.startAnimating()
        
        guard let lastTappedTime = UserDefaults.standard.object(forKey: buttonTapTimeKey) as? Date else {
            downloadImage()
            UserDefaults.standard.set(Date(), forKey: buttonTapTimeKey)
            return
        }
        
        let currentTime = Date()
        let timeSinceLastTap = currentTime.timeIntervalSince(lastTappedTime)
        let delay: TimeInterval = 5
        
        if timeSinceLastTap < delay {
            activityIndicator.stopAnimating()
            let alertController = alertService.alertStopDowload()
            present(alertController, animated: true, completion: nil)
        } else {
            downloadImage()
            UserDefaults.standard.set(Date(), forKey: "LastGenerateButtonTapTime")
        }
    }
    
    @objc func favouritesButtonTapped() {
        guard let lastDownloadedImageData = imageView.image?.pngData(),
              let userQuery = networkService.userQuery?.removingPercentEncoding
        else { return }
        generateImageStorage.addFavourite(lastDownloadedImageData, userQuery: userQuery)
        
        print(generateImageStorage.fetchFavouriteImages())
        
        let alertController = alertService.alertImageAdded()
        present(alertController, animated: true)
    }
}

//MARK: - Layout
extension ImageViewController {
    private func setConstraints() {
        
        let marginGuide = view.layoutMarginsGuide
        let imageHeight: CGFloat = Constants.imageHeight
        
        NSLayoutConstraint.activate(
            [
                searchBar.topAnchor.constraint(equalTo: marginGuide.topAnchor),
                searchBar.heightAnchor.constraint(equalToConstant: Constants.searchBarHeight),
                searchBar.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
                searchBar.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
                
                imageView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: Constants.offSet),
                imageView.centerXAnchor.constraint(equalTo: marginGuide.centerXAnchor),
                imageView.heightAnchor.constraint(equalToConstant: imageHeight),
                imageView.widthAnchor.constraint(equalToConstant: imageHeight),
                
                activityIndicator.topAnchor.constraint(equalTo: imageView.topAnchor),
                activityIndicator.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
                activityIndicator.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
                activityIndicator.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
                
                generateButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.offSet),
                generateButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
                generateButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
                generateButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
                
                favouritesButton.topAnchor.constraint(equalTo: generateButton.bottomAnchor, constant: Constants.offSet),
                favouritesButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
                favouritesButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
                favouritesButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            ]
        )
    }
}

//MARK: - Constants
private extension ImageViewController {
    enum Constants {
        static let imageHeight: CGFloat = UIScreen.main.bounds.width - 200
        static let searchBarHeight: CGFloat = 70
        static let buttonHeight: CGFloat = 50
        static let offSet: CGFloat = 20
    }
}



