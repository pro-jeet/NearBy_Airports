//
//  ViewController.swift
//  NearBy_Airports
//
//  Created by Jitesh Sharma on 11/12/19.
//  Copyright © 2019 Jitesh Sharma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtField: UITextField!
    
    var arrCityModel: [CityModel] = []
    
    @IBOutlet weak var tableVw: UITableView!{
        didSet{
            setUpTableView()
        }
    }
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var customTableViewDelegates: TableViewCustomDataSources?{
        didSet{
            tableVw.dataSource = customTableViewDelegates
            tableVw.delegate = customTableViewDelegates
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Select City to find NearBy Airports!"
        api()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        view.endEditing(true)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            bottomConstraint?.constant = keyboardSize.height
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyBoardWillHide(notification: Notification) {
        bottomConstraint?.constant = 0
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    func api(){
        Endpoint.tdreyNo().request {[weak self] (response) in
            guard let self = self else {return}
            switch response{
            case .success(let res):
                guard var arr = res as? [CityModel] else{return}
                arr.sort(by: {/$0.city < /$1.city})
                self.arrCityModel = arr
                self.customTableViewDelegates?.items = arr
                self.customTableViewDelegates?.backgroundLabel.text = ""
                self.tableVw.reloadData()
            case .failure(let err):
                debugPrint("error -> \(String(describing: err))")
                self.customTableViewDelegates?.backgroundLabel.text = "error occured"
            }
        }
    }
    
    private func deg2rad(deg:Double) -> Double {
        return deg * .pi / 180
    }

    private func rad2deg(rad:Double) -> Double {
        return rad * 180.0 / .pi
    }
    
    private func distance(lat1:Double, lon1:Double, lat2:Double, lon2:Double, unit:String) -> Double {
        let theta = lon1 - lon2
        var dist = sin(deg2rad(deg: lat1)) * sin(deg2rad(deg: lat2)) + cos(deg2rad(deg: lat1)) * cos(deg2rad(deg: lat2)) * cos(deg2rad(deg: theta))
        dist = acos(dist)
        dist = rad2deg(rad: dist)
        dist = dist * 60 * 1.1515
        if (unit == "K") {
            dist = dist * 1.609344
        }else if (unit == "N") {
            dist = dist * 0.8684
        }
        return dist
    }
}

//configure table
extension ViewController {
    func setUpTableView(){
        let cellForRowAtIndexPath: itemForRowAtIndex = { (cell, item, indexPath) in
            (cell as? CityCell)?.item = item
        }
        let didSelect: didSelectItem = { [weak self](cell, item, indexPath) in
            guard let self = self, let model = item as? CityModel else {return}
            let vc = ShowFiveResultsVc.instantiateFrom(storyboard: .main)
            self.navigationController?.pushViewController(vc, animated: true)
            DispatchQueue.global().async {
                for element in self.arrCityModel {
                    element.distanceFromSelectedCity = self.distance(lat1: /Double(/model.lat), lon1: /Double(/model.lon), lat2: /Double(/element.lat), lon2: /Double(/element.lon), unit: "K")
                }
                let nearByCityArray = self.arrCityModel.sorted(by: {/$0.distanceFromSelectedCity < /$1.distanceFromSelectedCity})
                if nearByCityArray.count > 5 {
                    vc.update(arr: Array(nearByCityArray.prefix(5)))
                }else{
                    vc.update(arr: nearByCityArray)
                }
            }
        }
        
        customTableViewDelegates = TableViewCustomDataSources(items: nil, tabelView: tableVw, cellIdentifier: "\(CityCell.self)", cellHeight: 50, configureCellBlock: cellForRowAtIndexPath, selectedRow: didSelect)
        customTableViewDelegates?.backgroundLabel.text = "Loading..."
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let str = concatStringOfTextFieldDelegate(text: /textField.text, string: string)
        if arrCityModel.count > 0, str.count > 0{
            customTableViewDelegates?.items = arrCityModel.filter({/$0.city?.lowercased().hasPrefix(str.lowercased())})
        } else {
            customTableViewDelegates?.items = arrCityModel
        }
        tableVw.reloadData()
        return true
    }
    
    func concatStringOfTextFieldDelegate(text:String,string:String)->String{
        var str = text + string
        if string == ""{
            if str.count > 0{
                str = String(str.prefix(str.count-1))
            }
        }
        return str
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
