//
//  TableViewController.swift
//  InputAccessoryViewTest
//
//  Created by Albert Bori on 8/29/18.
//  Copyright © 2018 Albert Bori. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    private var _model = TableViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        (tableView.inputAccessoryView as? InputAccessoryView)?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let lastIndexPath = IndexPath(row: tableView.numberOfRows(inSection: 0) - 1, section: 0)
        tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: false)
        tableView.becomeFirstResponder()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _model.rows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = _model.rows[indexPath.row]
        cell.textLabel?.numberOfLines = 0

        return cell
    }
}

extension TableViewController: InputAccessoryViewDelegate {
    func addRow(text: String) {
        _model.rows.append(text)
        let lastIndexPath = IndexPath(row: tableView.numberOfRows(inSection: 0) - 1, section: 0)
        tableView.insertRows(at: [lastIndexPath], with: .automatic)
    }
    
    func inputAccessoryDidChangeSize() {
        let lastIndexPath = IndexPath(row: tableView.numberOfRows(inSection: 0) - 1, section: 0)
        tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
    }
}
