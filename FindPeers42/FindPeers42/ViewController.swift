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
    
    let appId = "c4412565fc115e8f6e2c00ef1cd54e52dd76f65568c5b76809b576576b71a75c"
    let appSecret = "28c4dab18a488c3bda5b33622280b74c94de4eb800128b532ba5d8b1438ea930"
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
        print(project)
        getUserName(user_id: 72458)
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
    
    func getUserName(user_id: Int) {
        if self.token == nil {
            print("error")
        }
        else {
            let url = "https://api.intra.42.fr/" + "/v2/users/\(user_id)"
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

                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                print(json!["login"]!)
                
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

