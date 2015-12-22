//
//  SongSaveTableViewController.swift
//  MusicNoteDesignTools
//
//  Created by tangsl on 15/8/21.
//  Copyright (c) 2015年 tangsl. All rights reserved.
//

import UIKit

class SongListShowViewController :UIViewController,UITableViewDataSource,UITableViewDelegate{
    let kCellIdentifier: String = "SearchResultCell"
    var songNameArray :[String]! = [String]()
    var songtableView :UITableView!
    var mainViewDelegate :SongListShowViewControllerDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let lightBlackView = UIView(frame:view.bounds)
        lightBlackView.alpha = 0.5
        lightBlackView.backgroundColor = UIColor.blackColor()
        view.addSubview(lightBlackView)
        
        let imageTableView :UIImageView = UIImageView(frame: CGRectMake(676, 100, 342, 626))
        imageTableView.image = UIImage(named: "bg_tableview")
        imageTableView.userInteractionEnabled = true
        view.addSubview(imageTableView)
        
        let singleTap = UITapGestureRecognizer(target: self, action: Selector("singleTapClick"))
        singleTap.numberOfTouchesRequired = 1
        singleTap.numberOfTapsRequired = 1
        lightBlackView.addGestureRecognizer(singleTap)
        
        self.songtableView = UITableView(frame: CGRectMake(16, 136, 310, 470),style: .Plain)
        self.songtableView.dataSource = self
        self.songtableView.delegate = self
        self.songtableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
        self.songtableView.backgroundColor = UIColor.clearColor()
        imageTableView.addSubview(self.songtableView)
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier)!
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: kCellIdentifier)
        }
        
        cell?.textLabel?.text = songNameArray[indexPath.row]
        return cell!
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return songNameArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        mainViewDelegate!.renewMusicSongWithSongName(songNameArray[indexPath.row])
    }
    
    func singleTapClick(){
        mainViewDelegate!.removeSongListView()
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle{
        return UITableViewCellEditingStyle.Delete
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        mainViewDelegate!.deleteSongWithSongName(songNameArray[indexPath.row])
        songNameArray.removeAtIndex(indexPath.row)
        songtableView.reloadData()
    }
}
