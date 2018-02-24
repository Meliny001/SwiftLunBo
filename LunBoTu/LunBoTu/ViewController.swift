//
//  ViewController.swift
//  LunBoTu
//
//  Created by Magic on 2018/2/24.
//  Copyright © 2018年 magic. All rights reserved.
//

import UIKit

fileprivate let CellID = "ZGImageCell"
fileprivate let Multiple = 500

class ViewController: UIViewController {
    // 变量
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    lazy var imagesArr: [String] = {
        let _images = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg"]
        return _images
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseConfigure()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let indexPath = IndexPath.init(row: Int(Multiple/2) * imagesArr.count, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }

}
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource
{
    fileprivate func baseConfigure()
    {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let itemWidth = UIScreen.main.bounds.size.width
        layout.itemSize = CGSize(width:itemWidth,height:collectionView.bounds.size.height)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(UINib.init(nibName: "ZGImageCell", bundle: nil), forCellWithReuseIdentifier: CellID)
        
        pageControl.numberOfPages = imagesArr.count

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArr.count * Multiple
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath) as! ZGImageCell
        
        cell.imageView.image = UIImage (named: imagesArr[indexPath.row % imagesArr.count])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / UIScreen.main.bounds.size.width
        let currentPage:Int = Int(index) % imagesArr.count
        pageControl.currentPage = currentPage
    }
    
}

