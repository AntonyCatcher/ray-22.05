//
//  SearchBar.swift
//  GenerateImageTest
//
//  Created by Anton  on 23.05.2023.
//

import UIKit

class SearchBar: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        placeholder = "Введите запрос"
        delegate = self
        backgroundImage = UIImage()
        returnKeyType = .done
    }
}

//MARK: - UISearchBarDelegate
extension SearchBar: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
