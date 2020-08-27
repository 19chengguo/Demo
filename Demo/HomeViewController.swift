//
//  HomeViewController.swift
//  Demo
//
//  Created by ChengGuoTech || CG-005 on 2020/8/21.
//  Copyright © 2020 ChengGuoTech || CG-005. All rights reserved.
//

import UIKit
import SnapKit
class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{

    let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero,collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.init(red: 243 / 255, green: 241/255, blue: 242/255, alpha: 1)
        return cv
    }()
    
    let lablesCellId = "lablesCellId"
    let imagesCellId = "imagesCellId"
    
    let titlesArrys = ["Books","Cameras","Cars","Phone","Mac"]
    
    let images = ["https://source.unsplash.com/200x100/?nature,water","https://source.unsplash.com/250x100/?nature,water","https://source.unsplash.com/300x100/?nature,water","https://source.unsplash.com/350x100/?nature,water"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.isNavigationBarHidden = false
    }
    
    func setupViews(){
        collection.delegate = self;
        collection.dataSource = self
        collection.register(imagesCell.self, forCellWithReuseIdentifier: imagesCellId)
        collection.register(lablesCell.self, forCellWithReuseIdentifier: lablesCellId)
        view.addSubview(collection)
        
        collection.snp.makeConstraints { (make) in
            make.top.left.equalTo(view)
            make.right.bottom.equalTo(view)
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return images.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imagesCellId, for: indexPath) as! imagesCell
            cell.imagUrl = images[indexPath.row]
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: lablesCellId, for: indexPath) as! lablesCell
        //不会update
        //cell.titles? = titlesArrys
        cell.titles = titlesArrys
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
            return CGSize(width: view.frame.width - 40, height: 200)
        }
        
        return CGSize(width: view.frame.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1{
          return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        }
        
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vd = VideosController()
        self.navigationController?.pushViewController(vd, animated: true)
    }


}


//标签

class lablesCell: UICollectionViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    //计算属性
    var titles: [String]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    let collectionView: UICollectionView = {
        let layout =  UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.scrollDirection = .horizontal;
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear;
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        
        return cv
    }()
    
    let labelSubViewCellId = "labelSubViewCellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    func setUp(){
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.top.left.equalTo(self)
            make.right.bottom.equalTo(self)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LablesCell.self, forCellWithReuseIdentifier: labelSubViewCellId)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles?.count ?? 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: labelSubViewCellId, for: indexPath) as! LablesCell
        if let text = titles?[indexPath.item]{
            cell.text = text
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width * 0.26, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //label
    private class LablesCell: UICollectionViewCell{
        
        let label :UILabel = {
            let lab = UILabel()
            lab.translatesAutoresizingMaskIntoConstraints = false
            lab.backgroundColor = .orange
            lab.backgroundColor = .white
            lab.textAlignment = .center
            
            
            return lab
        }()
        
        var text :String? {
            didSet{
                label.text = text
            }
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
        
        func setup(){
            //绘制圆角
            let maskPath = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: 15)
            let l = CAShapeLayer.init()
            l.path = maskPath.cgPath;
            label.layer.mask = l;
            
            addSubview(label)
            label.snp.makeConstraints { (make) in
                make.top.left.equalTo(self)
                make.right.bottom.equalTo(self)
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
}

// image 卡片

class imagesCell: UICollectionViewCell {
    
    var imagUrl :String?{
        didSet{
            if let i_url = URL(string: imagUrl ?? ""){
                asynImage(i_url)
            }
            
        }
    }
    
    
    func asynImage(_ url: URL){
        DispatchQueue.global(qos: .userInitiated).async {
                if  let d = try? Data(contentsOf: url){
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage.init(data: d)
                }
            }
        }
    }

    
    let imageView : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .red
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: 15)
        let l = CAShapeLayer.init()
        l.path = maskPath.cgPath;
        layer.mask = l
       
        setUp()
    }
    func setUp(){
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (mask) in
            mask.top.left.equalTo(self)
            mask.right.bottom.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
