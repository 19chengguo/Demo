//
//  LiveViewController.swift
//  Demo
//
//  Created by ChengGuoTech || CG-005 on 2020/9/1.
//  Copyright © 2020 ChengGuoTech || CG-005. All rights reserved.
//

import UIKit

class LiveViewController: UIViewController , CustomLayoutDelegate {
    
    let colltionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        return cv
    }()
    
    
    let collId = "livecellId"
    
    var resImags : [UIImage]?
    
    let images = ["https://source.unsplash.com/200x200/?nature,water",
                  "https://source.unsplash.com/200x250/?nature,water",
                  "https://source.unsplash.com/200x160/?nature,water",
                  "https://source.unsplash.com/250x100/?nature,water",
                  "https://source.unsplash.com/200x150/?nature,water",
                  "https://source.unsplash.com/150x150/?nature,water",
                  "https://source.unsplash.com/130x180/?nature,water",
                  "https://source.unsplash.com/120x120/?nature,water",
                  "https://source.unsplash.com/180x200/?nature,water",
]


    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpViews()
        setLayouts()
        loadImages()

    }
    
    func loadImages(){
        let fetchGroup = DispatchGroup()
        var items = [UIImage]()
        images.forEach { (url) in
            fetchGroup.enter()
            URLSession.shared.dataTask(with: URL(string:url)!){
                (data, response, error) in
                if error != nil{
                    return
                }
                let img = UIImage.init(data: data!)
                items.append(img!)
                fetchGroup.leave()
           }.resume()
            
      }
        
        fetchGroup.notify(queue: .main){
            //错误写法
            //self.resImags? = items
            self.resImags  = items
            self.colltionView.reloadData()
        }
        
            
}
    

    
    func setUpViews(){
        colltionView.delegate = self
        colltionView.dataSource = self
        colltionView.register(customCell.self, forCellWithReuseIdentifier: collId)
        view.addSubview(colltionView)
        colltionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setLayouts(){
        let customLayout = CustomLayout()
        customLayout.delegate = self
        colltionView.collectionViewLayout = customLayout
    }
    

    func collectionView(_ collectionView: UICollectionView, sizeOfPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        return   resImags?[indexPath.item].size ?? CGSize.init(width: 50, height: 50)
    }
    

}

extension LiveViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resImags?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collId, for: indexPath) as! customCell
        cell.imageView.image = resImags?[indexPath.item]
        return cell
    }
    

}




class customCell: UICollectionViewCell {

    
    let imageView : UIImageView = {
        let img = UIImageView.init()
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .darkGray

        setUpView()
    }
    
    func setUpView(){
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
