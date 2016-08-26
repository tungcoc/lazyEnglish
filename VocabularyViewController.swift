//
//  VocabularyViewController.swift
//  english
//
//  Created by Tung  Vu on 8/25/16.
//  Copyright © 2016 Tung  Vu. All rights reserved.
//

import Foundation
import XLPagerTabStrip

class VocabularyViewController: UITableViewController, IndicatorInfoProvider {
    
    var titleVocabulary : [String] = ["hello","run", "navigation","github","game"]
    var meanVocabulary : [String ] = ["xin chao ", "chay", "dieu huong", "git hub", "choi"]
    
    
    let cellIdentifier = "postCell"
    var blackTheme = false
    var itemInfo = IndicatorInfo(title: "View")
        
    init(style: UITableViewStyle, itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(style: style)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "PostCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: cellIdentifier)
        tableView.estimatedRowHeight = 40.0;
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.allowsSelection = false
        
        if blackTheme {
            tableView.backgroundColor = UIColor(red: 15/255.0, green: 16/255.0, blue: 16/255.0, alpha: 1.0)
        }
    }
    
    
        
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
        
    // MARK: - UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
        
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleVocabulary.count
    }
        
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PostCell
        
        cell.postName.text = titleVocabulary[indexPath.row]
        cell.postText.text = meanVocabulary[indexPath.row]
        
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    
    }
        
    // MARK: - IndicatorInfoProvider
    func indicatorInfoForPagerTabStrip(pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}