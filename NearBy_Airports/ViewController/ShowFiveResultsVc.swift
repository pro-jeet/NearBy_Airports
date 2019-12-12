//
//  ShowFiveResultsVc.swift
//  NearBy_Airports
//
//  Created by Jitesh Sharma on 11/12/19.
//  Copyright © 2019 Jitesh Sharma. All rights reserved.
//

import UIKit

class ShowFiveResultsVc: UIViewController {
    
    @IBOutlet weak var tableVw: UITableView!{
        didSet{
            setUpTableView()
        }
    }
    
    
    var customTableViewDelegates: TableViewCustomDataSources?{
        didSet{
            tableVw.dataSource = customTableViewDelegates
            tableVw.delegate = customTableViewDelegates
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NearBy Airports"
        // Do any additional setup after loading the view.
    }
    
    func update(arr: [CityModel]){
        DispatchQueue.main.async {
            self.customTableViewDelegates?.items = arr
            self.tableVw.reloadData()
        }
    }


}

//configure table
extension ShowFiveResultsVc {
    func setUpTableView(){
        let cellForRowAtIndexPath: itemForRowAtIndex = { (cell, item, indexPath) in
            (cell as? CityCellFive)?.item = item
        }
        
        let didSelect: didSelectItem = { (cell, item, indexPath) in }
        
        customTableViewDelegates = TableViewCustomDataSources(items: nil, tabelView: tableVw, cellIdentifier: "\(CityCellFive.self)", cellHeight: 0, configureCellBlock: cellForRowAtIndexPath, selectedRow: didSelect)
        customTableViewDelegates?.backgroundLabel.text = "Loading..."
    }
}
