//
//  TableViewCustomDataSources.swift
//  NearBy_Airports
//
//  Created by Jitesh Sharma on 11/12/19.
//  Copyright © 2019 Jitesh Sharma. All rights reserved.
//

import UIKit

typealias itemForRowAtIndex = (_ cel:Any,_ item : Any?, _ indexPath: IndexPath) -> ()
typealias didSelectItem = (_ cel:Any,_ item : Any?, _ indexPath: IndexPath) -> ()

class TableViewCustomDataSources:NSObject {
    //Mark:- variables
    var items: Array<Any>?
    var cellHeight: CGFloat = 0.0
    var cellIdentifier  : String?
    var tableVw  : UITableView?
    var cellAtIndex : itemForRowAtIndex?
    var didSelectAtIndex : didSelectItem?
    var backgroundLabel = UILabel()
    var refreshControl = UIRefreshControl()
    var isSwipeDel = false
    
    //constructer with parameters
    init (items: Array<Any>?, tabelView: UITableView? , cellIdentifier: String?, cellHeight: CGFloat, configureCellBlock: itemForRowAtIndex?, selectedRow: didSelectItem?)  {
        super.init()
        self.tableVw = tabelView
        self.items = items
        self.cellIdentifier = cellIdentifier
        self.cellHeight = cellHeight
        self.cellAtIndex = configureCellBlock
        self.didSelectAtIndex = selectedRow
        tableVw?.separatorStyle = .none
        if cellHeight == 0{
            self.tableVw?.estimatedRowHeight = 50
            self.tableVw?.rowHeight = UITableView.automaticDimension
        }else{
            self.tableVw?.rowHeight = cellHeight
        }
        self.initLabel()
    }
    
    private func initLabel(){
        guard let tblVw = tableVw else{return}
        backgroundLabel.frame = tblVw.bounds
        backgroundLabel.text = "No Result"
        backgroundLabel.textAlignment = .center
        backgroundLabel.textColor = .black
    }
}

//MARK::- tableview delegates
extension TableViewCustomDataSources : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = self.items?.count == 0 || self.items == nil ? backgroundLabel : nil
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let identifier = cellIdentifier else{
            fatalError("Cell identifier not provided")
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as UITableViewCell
        cell.selectionStyle = .none
        if let block = self.cellAtIndex , let item: Any = self.items?[indexPath.row]{
            block(cell , item , indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let block = self.didSelectAtIndex,let cell = tableView.cellForRow(at: indexPath), let item: Any = self.items?[(indexPath).row]{
            block(cell , item, indexPath)
        }
    }
}

