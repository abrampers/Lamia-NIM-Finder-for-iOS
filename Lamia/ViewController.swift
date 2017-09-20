//
//  ViewController.swift
//  Lamia
//
//  Created by Faza Fahleraz on 8/20/17.
//  Copyright © 2017 Faza Fahleraz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    // MARK: Outlets
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var mahasiswaTableView: UITableView!
    @IBOutlet weak var resultsLabel: UILabel!
    
    // MARK: Properties
    
    var mahasiswaData: [Mahasiswa] = []
    var mahasiswaCount: Int!
    var pageCount: Int!
    var currentPage: Int = 0
    
    // MARK: apala
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This is for rounded corners
        mahasiswaTableView.layer.cornerRadius = 10
        mahasiswaTableView.layer.masksToBounds = true
        
        self.resultsLabel.text = "No results"
        
        searchField.delegate = self
        
    }
    
    // MARK: Actions
    
    @IBAction func doNextPage(_ sender: Any) {
        
        if self.currentPage < self.pageCount {
            self.currentPage += 1
            doSearch(nil)
            self.resultsLabel.text = "Results 5 of \(self.mahasiswaCount)"
        }
        
    }
    
    @IBAction func doPrevPage(_ sender: Any) {
        
        if self.currentPage > 0 {
            self.currentPage -= 1
            doSearch(nil)
            self.resultsLabel.text = "Results 5 of \(self.mahasiswaCount)"
        }
        
    }
    
    @IBAction func doSearch(_ sender: Any?) {
        
        print(searchField.text!)
        
        let params = ["query": searchField.text!, "major": "[]", "page": "\(currentPage)", "year": "[]"]
        
        guard let url = URL(string: "https://yonasadiel.com/lamia/search") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        guard let requestBody = try? JSONSerialization.data(withJSONObject: params, options: []) else { return }
        request.httpBody = requestBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    print(json)
                    
                    // parse JSON Object
                    guard let jsonObj = json as? [String: Any] else { return }
                    
                    // get page count
                    if let mahasiswaCount = jsonObj["count"] as? Int {
                        
                        self.mahasiswaCount = mahasiswaCount
                        self.pageCount = Int(ceil(Double(mahasiswaCount / 5)))
                    
                    }
                    
                    // get result array
                    if let students = jsonObj["result"] as? [Any] {
                        
                        // update table view data source
                        var newMahasiswaData: [Mahasiswa] = []
                        
                        for student in students {
                            
                            guard let studentDict = student as? [String: String] else { return }
                            
                            let mahasiswa = Mahasiswa(dictionary: studentDict)
                            newMahasiswaData.append(mahasiswa)
                            
                        }
                        
                        // change resultsLabel text
                        self.resultsLabel.text = "Results 5 of \(self.mahasiswaCount)"
                        
                        self.mahasiswaData = newMahasiswaData
                        
                        // reload mahasiswaTableView data
                        DispatchQueue.main.async(execute: { () -> Void in
                            self.mahasiswaTableView.reloadData()
                        })
                        
                    }
                    
                } catch {
                    print(error)
                }
            }
        }.resume()

        
    }
    
    // MARK: Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mahasiswaData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MahasiswaCell") as! TableViewCell
        let mahasiswa = self.mahasiswaData[(indexPath as NSIndexPath).row]
        
        // Set the name
        cell.myName.text = mahasiswa.name
        cell.myDetails.text = "[\(mahasiswa.major)] \(mahasiswa.NIM_TPB) | \(mahasiswa.NIM_Major)"
        cell.myEmail.text = "\(mahasiswa.email)@s.itb.ac.id"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    // MARK: Text Field Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    
    
}

