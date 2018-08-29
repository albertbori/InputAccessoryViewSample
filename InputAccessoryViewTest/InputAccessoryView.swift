//
//  InputAccessoryView.swift
//  InputAccessoryViewTest
//
//  Created by Albert Bori on 8/29/18.
//  Copyright © 2018 Albert Bori. All rights reserved.
//

import UIKit

class InputAccessoryView: UIView {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var addButton: UIButton!
    
    weak var delegate: InputAccessoryViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.autoresizingMask = .flexibleHeight
        textViewDidChange(textView)
    }
    
    @IBAction func add(_ sender: Any) {
        delegate?.addRow(text: textView.text)
        textView.text = ""
        textViewDidChange(textView)
    }
}

extension InputAccessoryView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude))
        if textViewHeightConstraint.constant != size.height {
            textViewHeightConstraint.constant = size.height
            textView.reloadInputViews()
            delegate?.inputAccessoryDidChangeSize()
        }
        addButton.isEnabled = textView.text != ""
    }
}

protocol InputAccessoryViewDelegate: class {
    func addRow(text: String)
    func inputAccessoryDidChangeSize()
}
