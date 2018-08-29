//
//  InputAccessoryTableView.swift
//  InputAccessoryViewTest
//
//  Created by Albert Bori on 8/29/18.
//  Copyright © 2018 Albert Bori. All rights reserved.
//

import UIKit

class InputAccessoryTableView: UITableView {

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
