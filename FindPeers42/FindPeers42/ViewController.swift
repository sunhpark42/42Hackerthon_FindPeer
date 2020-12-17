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
    
    var projectsData: [String] = ["libft", "get_next_line", "netwhat", "ft_printf", "ft_server", "cub3d", "miniRT", "libasm", "ft_services", "minishell", "Philosophers", "CPP Module 00", "CPP Module 01", "CPP Module 02", "CPP Module 03", "CPP Module 04", "CPP Module 05", "CPP Module 06", "CPP Module 07", "CPP Module 08", "ft_containers", "ft_irc", "webserv", "ft_transcendence"]
    var projectsId: [Int] = [1314, 1327, 1318, 1316, 1328, 1326, 1315, 1330, 1329, 1331, 1334, 1338, 1339, 1340, 1341, 1342, 1343, 1344, 1345, 1346, 1335, 1336, 1332, 1337]
    var projectCircle: [Int] = [0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 6]
    
    var project: String = ""
    
    let appId = "f570e30e89f7d85ac58738258d5c0e622adacba28b0c22e80bf05ad94769a895"
    let appSecret = "3835ae693daef1fd596a9ba41614ca19b2ed9961dff77edb0c9579931c5964ad"
    let appRedirectUri = "FindPeer://FindPeer"
    let apiUrl = URL(string: "https://api.intra.42.fr")
    let apiTokenUrl = URL(string: "https://api.intra.42.fr/oauth/token")
    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        projectPickerView.delegate = self;
        projectPickerView.dataSource = self;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getToken()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func searchButtonClick () {
        guard let index = projectsData.firstIndex(of: project) else { return }
        getUserName(project_id: self.projectsId[index])
    }
    
    func getToken() {
        let parameters = [
            "grant_type": "client_credentials",
            "client_id": self.appId,
            "client_secret": self.appSecret]
        let paramData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        var request = URLRequest(url: self.apiTokenUrl!)
        request.httpMethod = "POST"
        request.httpBody = paramData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(String(paramData.count), forHTTPHeaderField: "Content-Length")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
            self.token = json!["access_token"] as? String
        }
        
        task.resume()

    }
    
    func getUserName(project_id: Int) {
        if self.token == nil {
            print("error")
        }
        else {
            let url = "https://api.intra.42.fr/v2/projects/\(project_id)"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = [
                "Authorization": "Bearer \(self.token!)"
            ]

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

                guard let data = data, error == nil else {
                    print("error")
                    return
                }

                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }

                let dataString = String(decoding: data, as: UTF8.self)
                let dataData = Data(dataString.utf8)
                let json = try? JSONSerialization.jsonObject(with: dataData, options: [])
                print(json)
            }
            
            task.resume()
        }
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

