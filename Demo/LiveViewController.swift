//
//  LiveViewController.swift
//  Demo
//
//  Created by ChengGuoTech || CG-005 on 2020/9/1.
//  Copyright © 2020 ChengGuoTech || CG-005. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
class LiveViewController: UIViewController,CustomLayoutDelegate {
    
    let colltionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.size.width-20, height: 95)
        
        let cv = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        return cv
    }()
    
    
    let collId = "livecellId"
    
    var resImags : [UIImage]?
    
    private var photos : [Photo] = []
    private let baseUrl: String = "https://jsonplaceholder.typicode.com/"

    
    var images = ["https://source.unsplash.com/200x200/?nature,water",
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
        
        setUpViews()
        setLayouts()
        loadImages()
        
//        fetchData()
    }
    
    
    
    func fetchData(){
        AF.request(self.baseUrl + "photos",method: .get).responseDecodable(of: [Photo].self){
            [weak self] response in
            let temp = response.value ?? []
            self?.photos = Array(temp[0...9])
            self?.colltionView.reloadData()
            print("成功")
        }
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
//        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collId, for: indexPath) as? customCell{
//            cell.photo = self.photos[indexPath.row]
            cell.imageView.image = self.resImags?[indexPath.row]
            return cell
        }
       
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = RequesViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

}




class customCell: UICollectionViewCell {

    
    let imageView : UIImageView = {
        let img = UIImageView.init()
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let label : UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.numberOfLines = 0
        lab.text = "test"
        return lab
    }()
    
    
    var photo: Photo!{
        didSet{
            self.label.text = self.photo.title
            self.imageView.setImage(imageUrl: self.photo.url)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    
    func setUpView(){
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setUpView2(){
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(200)
        }
        label.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            make.left.equalTo(contentView).offset(5)
            make.right.equalTo(contentView).offset(-5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
