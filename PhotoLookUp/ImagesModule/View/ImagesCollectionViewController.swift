//
//  ImagesCollectionViewController.swift
//  PhotoLookUp
//
//  Created by Алем Утемисов on 01.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

import UIKit

class ImagesCollectionViewController: BaseViewController, ImagesCollectionViewInput {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBarHeighConstraint: NSLayoutConstraint!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var collectionViewDelegate: ImagesLayoutInputDelegate!
    var output: ImagesCollectionViewOutput!
    var imageUrls: [URL] = []
    
    var isSearching: Bool {
         return searchBarHeighConstraint.constant > 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewLoaded()
        collectionViewDelegate.setup(collectionView: collectionView)
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        output.searchButtonTapped()
        searchBar.resignFirstResponder()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        let currentImageIndex = Int(collectionView.contentOffset.x / collectionView.frame.width)
        output.cancelButtonTapped(at: currentImageIndex)
        searchBar.resignFirstResponder()
    }
    
    func showSearchView() {
        self.searchBarHeighConstraint.constant = 56
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func hideSearchView() {
        self.searchBarHeighConstraint.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func setLayout(to delegate: ImagesLayoutInputDelegate) {
        collectionViewDelegate = delegate
        collectionViewDelegate.setup(collectionView: collectionView)
    }
    
    func hideCancelButton() {
        cancelButton.isEnabled = false
        cancelButton.tintColor = .clear
    }
    
    func showCancelButton() {
        cancelButton.isEnabled = true
        cancelButton.tintColor = view.tintColor
    }
    
    func scrollToItem(at index: Int, isHorizontalLayout: Bool, animated: Bool) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView
            .scrollToItem(at: indexPath,
                          at: isHorizontalLayout ? .centeredHorizontally : .centeredVertically,
                          animated: animated)
    }
}

extension ImagesCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let url = imageUrls[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.configure(iconUrl: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
}

extension ImagesCollectionViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let url = imageUrls[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
            cell.configure(iconUrl: url)
        }
    }
    
}

extension ImagesCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        output.search(text: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}

extension ImagesCollectionViewController: ImagesLayoutOutputDelegate {
    
    func loadMore() {
        output.loadMore()
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        searchBar.resignFirstResponder()
        output.didSelectItem(at: indexPath.item)
    }
}
