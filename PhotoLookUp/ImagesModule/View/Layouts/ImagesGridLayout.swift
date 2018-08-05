//
//  ImagesGridLayout.swift
//  PhotoLookUp
//
//  Created by Алем Утемисов on 02.08.2018.
//  Copyright © 2018 Alem Utemissov. All rights reserved.
//

import UIKit

protocol ImagesLayoutOutputDelegate: class {
    func loadMore()
    func didSelectItem(at indexPath: IndexPath)
}

protocol ImagesLayoutInputDelegate {
    func setup(collectionView: UICollectionView)
}

class ImagesGridLayout: NSObject, ImagesLayoutInputDelegate, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: ImagesLayoutOutputDelegate!
    
    func setup(collectionView: UICollectionView) {
        collectionView.isPagingEnabled = false
        collectionView.delegate = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        let width = size.width / 3.4
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.didSelectItem(at: indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            delegate.loadMore()
        }
    }
    
}
