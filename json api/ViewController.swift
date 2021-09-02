//
//  ViewController.swift
//  json api
//
//  Created by Abdirizak Hassan on 9/1/21.
//

import UIKit

class ViewController: UITableViewController {
    var users = [User]()
    var apiURL = "https://jsonplaceholder.typicode.com/users"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "fetch users APi"
        getUser()
    }
    
    
    func getUser() {
        if let url = URL(string: apiURL) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    if let res = response as? HTTPURLResponse {
                        print(res.statusCode)
                    }
                    if let data = data {
                        //print(String(data: data, encoding: .utf8) ?? "")
                        self.parse(json: data)
                    }
                    
                    if let err = error {
                        print(err)
                    }
                }
                
            }.resume()
        }
    }
    
    
    func parse(json: Data) {
        do {
            let result = try JSONDecoder().decode([User].self, from: json)
            print("result: ", result)
            self.users = result
            tableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = String(user.id) + user.name
        cell.detailTextLabel?.text = user.email
        return cell
    }
        

}

