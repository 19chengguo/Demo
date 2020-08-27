//
//  VideosController.swift
//  Demo
//
//  Created by ChengGuoTech || CG-005 on 2020/8/25.
//  Copyright © 2020 ChengGuoTech || CG-005. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
let k_height  = UIScreen.main.bounds.size.height
let k_wight = UIScreen.main.bounds.size.width
class VideosController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    
    
    let collection : UICollectionView = {
        let layout  = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        let colle = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        colle.translatesAutoresizingMaskIntoConstraints = false
        colle.isPagingEnabled = true
        colle.showsVerticalScrollIndicator = false
//        colle.contentInsetAdjustmentBehavior = .never
        return colle
    }()
    
    let collId = "collection_vieo_cell_Id"
    
    let images = ["test1","test2","test1"]
    
    let vidos = ["v1","v2","v3"]
        

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
//        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        tabBarController?.tabBar.isHidden = false
        
        collection.visibleCells.forEach { (cell) in
            (cell as? vieosCell)?.avplayerView.player? .pause()
            (cell as? vieosCell)?.avplayerView.playerLayer?.removeFromSuperlayer()
        }
    }
    
    
    func setUpView(){
        collection.delegate = self;
        collection.dataSource = self;
        collection.register(vieosCell.self, forCellWithReuseIdentifier: collId)
        view.addSubview(collection);
        
        if #available(iOS 11.0, *) {
            collection.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        collection.snp.makeConstraints { (make) in
            make.top.left.equalTo(view)
            make.bottom.right.equalTo(view)
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vidos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collId, for: indexPath) as! vieosCell
//        cell.imagSrc = images[indexPath.row]
//        print("111",indexPath.row)
        cell.vido_url = vidos[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height:view.frame.height )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? vieosCell)?.avplayerView.player?.play()
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? vieosCell)?.avplayerView.player?.pause()
    }

    
    deinit {
        print("销毁")
    }


}

class vieosCell: UICollectionViewCell, AVPlayerViewDelegate {
    
    
    lazy var customView: UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        return v
    }()
    
    let videoLengthLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    lazy var videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(hnadleSliderChange), for: .valueChanged)
        return slider
    }()
    
    var vido_url : String?{
        didSet{
            avplayerView.vido_url = vido_url
        }
    }

   lazy var avplayerView: AVPlayerView = {
        let a = AVPlayerView()
        a.delegate = self
        return a
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
   @objc func hnadleSliderChange(){
    if let duration = avplayerView.player?.currentItem?.duration {
        let totalSeconds = CMTimeGetSeconds(duration)
        let value = Float64(videoSlider.value) * totalSeconds
        let seekTime  = CMTime(value: Int64(value), timescale: 1)
        
        avplayerView.player?.seek(to: seekTime, completionHandler: { (completedSeek) in
            self.avplayerView.player?.play()
        })
        
    }
    

    }
    
    func setUp(){
        self.addSubview(avplayerView)
        self.addSubview(videoLengthLabel)
        self.addSubview(videoSlider)
        avplayerView.snp.makeConstraints { (make) in
            make.top.left.equalTo(self)
            make.bottom.right.equalTo(self)
        }
        
        videoLengthLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-44)
            make.right.equalTo(self).offset(-20)
            make.width.equalTo(60)
            make.height.equalTo(24)
        }
        
        videoSlider.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-44)
            make.left.equalTo(self)
            make.right.equalTo(videoLengthLabel.snp.left)
            make.height.equalTo(30)
        }
        
        
    }
    //代理方法
    func onProgressUpdate(secondsText:Int,minutesText:String) {
        videoLengthLabel.text = "\(minutesText):\(secondsText)"
    }
    
//    override func prepareForReuse(){
//        super.prepareForReuse()
//
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


protocol AVPlayerViewDelegate {
    func onProgressUpdate(secondsText:Int,minutesText:String)
}

class AVPlayerView: UIView{
       
       //视频播放器图形化载体
       var playerLayer:AVPlayerLayer?
       //视频播放器
       var player:AVPlayer?
       //url or path
       var vido_url : String?{
           didSet{
               guard let src = vido_url else{
                   return
               }
               loadVideo(src)
           }
       }
    
      var delegate:AVPlayerViewDelegate?
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           setUp()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       override func layoutSubviews() {
           super.layoutSubviews()
           playerLayer?.frame = self.layer.bounds
       }
       
       func loadVideo(_ url:String){
           guard let path = Bundle.main.path(forResource: url, ofType: "mp4") else {
               return
           }
           player = AVPlayer(url: URL(fileURLWithPath:path))
           playerLayer?.player = player
           player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
       }
   
       func setUp(){
           playerLayer = AVPlayerLayer.init(player: player)
           playerLayer?.videoGravity = .resizeAspectFill
           self.layer.addSublayer(self.playerLayer!)
       }
   
   override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
       if keyPath == "currentItem.loadedTimeRanges" {
        if let duration = player?.currentItem?.duration{
            let seconds = CMTimeGetSeconds(duration)
            //seconds 可能为NaN
            guard !( seconds.isNaN || seconds.isInfinite) else {
                return
            }
            let secondsText = Int(seconds) % 60
            let minutesText = String.init(format: "%02d", Int(seconds) / 60)
            delegate?.onProgressUpdate(secondsText:secondsText, minutesText: minutesText)
        }
       
       }
   }
   
}
