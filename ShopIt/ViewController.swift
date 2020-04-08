//
//  ViewController.swift
//  ShopIt
//
//  Created by Yoo Hwa Park on 2020/04/08.
//  Copyright © 2020 Yoo Hwa Park. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingItems = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearList))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        toolbarItems = [spacer, share]
        navigationController?.isToolbarHidden = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingItems[indexPath.row]
        return cell
    }
    
    @objc func addItem() {
        let ac = UIAlertController(title: "Enter item to shopping list", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }

        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        shoppingItems.insert(answer, at: 0)

        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func clearList() {
        shoppingItems.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func shareTapped() {
        let list = shoppingItems.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
         vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem // this only has effect on iPad
         present(vc, animated: true)
    }


}

