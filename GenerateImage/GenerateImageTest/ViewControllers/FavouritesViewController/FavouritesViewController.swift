//
//  FavouritesViewController.swift
//  GenerateImageTest
//
//  Created by Anton  on 23.05.2023.
//

import UIKit

final class FavouritesViewController: UIViewController {
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavouriteCell.self, forCellReuseIdentifier: "FavouriteCell")
        return tableView
    }()
    
    private var favouritesImagesCellsModel: [FavouriteImageCellModel] = []
    private let networkService: NetworkServiceProtocol = NetworkService.shared
    private let generateImageStorage: GenerateImageStorageProtocol = GenerateImageStorage.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        setDelegates()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateData()
    }
    
    func setUp() {
        view.backgroundColor = .white
        view.addSubviewAndTamic(tableView)
    }
    
    func setDelegates() {
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

//MARK: - updateData
extension FavouritesViewController {
    
    func updateData() {
        favouritesImagesCellsModel = generateImageStorage.fetchFavouriteImages().compactMap({ component in
            guard let image = UIImage(data: component.newImageData) else { return nil }
            return FavouriteImageCellModel(image: image,
                                           userQuery: component.newUserQuery)
        })
        tableView.reloadData()
        tableView.isHidden = favouritesImagesCellsModel.isEmpty
    }
}

//MARK: - UITableViewDataSource
extension FavouritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouritesImagesCellsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favouriteCell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell",
                                                                for: indexPath) as? FavouriteCell
        else {
            return UITableViewCell()
        }
        return favouriteCell.setUpCell(model: favouritesImagesCellsModel[indexPath.row])
    }
}

//MARK: - UITableViewDelegate
extension FavouritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let image = generateImageStorage.fetchFavouriteImages()[indexPath.row]
            generateImageStorage.removeFavourite(image)
            favouritesImagesCellsModel.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

//MARK: - Layout
extension FavouritesViewController {
    func setConstraints() {
        NSLayoutConstraint.activate(
            [
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
    }
}

