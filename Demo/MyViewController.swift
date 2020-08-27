//
//  MyViewController.swift
//  Demo
//
//  Created by ChengGuoTech || CG-005 on 2020/8/21.
//  Copyright © 2020 ChengGuoTech || CG-005. All rights reserved.
//

import UIKit

class MyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let tableView : UITableView = {
        let tab = UITableView.init(frame: .zero);
        tab.translatesAutoresizingMaskIntoConstraints = false;
        tab.allowsSelection = false
        tab.backgroundColor = .clear;
        tab.rowHeight = UITableView.automaticDimension;
        tab.estimatedRowHeight = 100
        return tab
    }()
    
    let cellId = "tableViewCellId"
    
    
    let customCellId = "customCellId"
    
    let iconsArrys: [[String]] = [["list","mess"],["out"]]
    
    let titles = ["List","Message","Log Out"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(red: 241 / 255, green: 241 / 255, blue: 241 / 255, alpha: 1)
        setUpViews()
    }
    
    func setUpViews(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.register(HeaderCell.self, forCellReuseIdentifier: cellId)
        tableView.register(CustomCell.self, forCellReuseIdentifier: customCellId)
        self.view.addSubview(tableView)
        tableView.tableFooterView = UIView()
        tableView.snp.makeConstraints { (make) in
            make.top.left.equalTo(self.view);
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1{
            return iconsArrys[0].count
        }
        return iconsArrys[1].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HeaderCell
            return cell
        }
        
        if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: customCellId, for: indexPath) as! CustomCell
            cell.IconImageView.image = UIImage.init(named: iconsArrys[0][indexPath.row])
            cell.titleLabel.text  = titles[indexPath.row]
            
            return cell
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: customCellId, for: indexPath) as! CustomCell
        cell.IconImageView.image = UIImage.init(named: iconsArrys[1][indexPath.row])
        cell.titleLabel.text  = titles[indexPath.row]
        cell.separatorInset = UIEdgeInsets.zero
        return cell

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return " "
        }
        else if section == 1{
            return " "
        }
        return " "
    }
    
}

class HeaderCell: UITableViewCell {
    
    
    let IconImage : UIImageView = {
        let img = UIImageView.init(image: UIImage.init(named: "profilo_outline"))
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let userNameLabel : UILabel = {
        let label = UILabel()
        label.text = "username"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUp()
    }
    
    func setUp(){
        self.addSubview(IconImage)
        self.addSubview(userNameLabel)

        IconImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }
        
        userNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(IconImage.snp.right).offset(5)
            make.centerY.equalTo(IconImage);
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class CustomCell: UITableViewCell{
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white;
        return view
    }()
    
    let IconImageView: UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    func setup(){
        backgroundColor = UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1)
        addSubview(cellView)
        cellView.addSubview(IconImageView);
        cellView.addSubview(titleLabel);
        
        cellView.snp.makeConstraints { (make) in
            make.top.left.equalTo(self)
            make.right.bottom.equalTo(self)
        }
        
        IconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(cellView.snp.left).offset(10)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.centerY.equalTo(cellView.snp.centerY)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(IconImageView.snp.right).offset(10)
            make.right.equalTo(cellView.snp.right)
            make.height.equalTo(40)
            make.centerY.equalTo(cellView.snp.centerY)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
