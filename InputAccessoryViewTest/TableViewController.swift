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
        (inputAccessoryView as? InputAccessoryView)?.delegate = self
        becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let lastIndexPath = IndexPath(row: tableView.numberOfRows(inSection: 0) - 1, section: 0)
        tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: false)
    }
    
    deinit {
        print(">> No retain cycle!!!")
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
    
    
    override var canBecomeFirstResponder: Bool { return true }
    
    private var _inputAccessoryView: UIView?
    override var inputAccessoryView: UIView? {
        if _inputAccessoryView == nil {
            _inputAccessoryView = Bundle.main.loadNibNamed("InputAccessoryView", owner: self, options: nil)?.first as? UIView
            _inputAccessoryView?.frame = CGRect(origin: CGPoint.zero, size: _inputAccessoryView!.intrinsicContentSize)
        }
        return _inputAccessoryView
    }
}

extension TableViewController: InputAccessoryViewDelegate {
    func inputAccessoryDidBeginEditing() {
        let lastIndexPath = IndexPath(row: tableView.numberOfRows(inSection: 0) - 1, section: 0)
        tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
    }
    
    func addRow(text: String) {
        _model.rows.append(text)
        let lastIndexPath = IndexPath(row: _model.rows.count - 1, section: 0)
        tableView.insertRows(at: [lastIndexPath], with: .automatic)
    }
    
    func inputAccessoryDidChangeSize() {
        let lastIndexPath = IndexPath(row: tableView.numberOfRows(inSection: 0) - 1, section: 0)
        tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
    }
    
    func inputAccessoryDidEndEditing() {
        let lastIndexPath = IndexPath(row: tableView.numberOfRows(inSection: 0) - 1, section: 0)
        tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
    }
}
