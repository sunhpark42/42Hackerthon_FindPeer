//
//  ViewController.swift
//  FindPeers42
//
//  Created by Sunhee Park on 2020/12/16.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchButton : UIButton!
    @IBOutlet weak var projectPickerView: UIPickerView!
    
    var projectsData: [String] = ["libft", "gnl", "printf", "netwhat"]
    
    var project: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        projectPickerView.delegate = self;
        projectPickerView.dataSource = self;
        
    }
    
    @IBAction func searchButtonClick () {
        print(project)
    }
    
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return projectsData.count
     }
     
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return projectsData[row]
     }
     
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        project = projectsData[row];
     }
 }

