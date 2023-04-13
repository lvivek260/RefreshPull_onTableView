//
//  ViewController.swift
//  PullToRefresh_OnTableView
//
//  Created by PHN MAC 1 on 13/04/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var namesTableView: UITableView!
    var names:[String] = ["Vivek","Pavan","Samadhan","Rahul","Shivam"]
    let refreshPull = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setRefreshPullControl()
    }
    
    private func setTableView(){
        namesTableView.dataSource = self
        namesTableView.allowsMultipleSelection = true
    }
    
    private func setRefreshPullControl(){
      //  refreshPull.attributedTitle = NSAttributedString(string: "Loading...")
        refreshPull.tintColor = .red
        
        refreshPull.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.namesTableView.refreshControl = refreshPull
       // self.namesTableView.addSubview(refreshPull)
    }
    @objc func refresh(sender:UIRefreshControl){
        DispatchQueue.main.async {
            self.names.append("name \(self.names.count)")
            self.namesTableView.reloadData()
            sender.endRefreshing()
        }
        
    }
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
}
