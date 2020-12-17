//
//  SearchViewController.swift
//  FindPeers42
//
//  Created by Sunhee Park on 2020/12/18.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var isDoingButton: UIButton!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var isBonusButton: UIButton!
    @IBOutlet weak var listView: UITableView!
    
    var datas: [ActiveProjectUser] = []
    var searchViewActiveProjectUsers: [ActiveProjectUser] = []
    
    var filteredDatas: [ActiveProjectUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datas = searchViewActiveProjectUsers
        filteredDatas = datas

        print(searchViewActiveProjectUsers)
        
        listView.reloadData()
        
    }
    
    @IBAction func tapDoingButton() {
        isDoingButton.isSelected = !isDoingButton.isSelected
        if isCompleteButton.isSelected {
            isCompleteButton.isSelected = !isCompleteButton.isSelected
        }
        if isBonusButton.isSelected {
            isBonusButton.isSelected = !isBonusButton.isSelected
        }
        
        if isDoingButton.isSelected {
            filteredDatas = datas.filter{ $0.status == "in_progress" }
        } else {
            filteredDatas = datas
        }

        self.listView.reloadData()
    }
    
    @IBAction func tapCompleteButton() {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
        if isDoingButton.isSelected {
            isDoingButton.isSelected = !isDoingButton.isSelected
        }
        
        if isCompleteButton.isSelected {
            filteredDatas = datas.filter{ $0.status == "finished" || $0.status == "all_bonus" }
            if isBonusButton.isSelected {
                filteredDatas = datas.filter{ $0.status == "all_bonus" }
            }
        } else if isBonusButton.isSelected {
            filteredDatas = datas.filter{ $0.status == "all_bonus" }
        } else {
            filteredDatas = datas
        }

        self.listView.reloadData()
    }
    
    @IBAction func tapBonusButton() {
        isBonusButton.isSelected = !isBonusButton.isSelected
        if isDoingButton.isSelected {
            isDoingButton.isSelected = !isDoingButton.isSelected
        }
        
        if isBonusButton.isSelected {
            filteredDatas = datas.filter{ $0.status == "all_bonus" }
        } else if isCompleteButton.isSelected {
            filteredDatas = datas.filter{ $0.status == "finished" || $0.status == "all_bonus" }
        } else {
            filteredDatas = datas
        }

        self.listView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? Listcell else {
            return UITableViewCell()
        }
        
        let dataInfo = filteredDatas[indexPath.row]
        
        cell.intraID.text = dataInfo.name
        cell.location.text = dataInfo.location
        if dataInfo.status == "in_progress" {
            cell.status.text = "진행중"
        } else {
            cell.status.text = "완료"
        }
        if dataInfo.status == "all_bonus" {
            cell.bonus.text = "보너스"
        } else {
            cell.bonus.text = ""
        }
        
        return cell
    }
}

class Listcell: UITableViewCell {
    @IBOutlet weak var intraID: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var bonus: UILabel!
    @IBOutlet weak var location: UILabel!
}

struct Data {
    var id: String
    var loc: String
    var stat: String
    var bonus: String
    
    init(id: String, loc: String, stat: String, bonus: String) {
        self.id = id
        self.loc = loc
        self.stat = stat
        self.bonus = bonus
    }
}
