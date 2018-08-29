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
    @IBOutlet weak var addButton: UIButton!
    
    weak var delegate: InputAccessoryViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.autoresizingMask = .flexibleHeight
        textView.delegate = self
        textViewDidChange(textView)
    }
    
    @IBAction func add(_ sender: Any) {
        delegate?.addRow(text: textView.text)
        textView.text = ""
        textView.resignFirstResponder()
    }
    
    override var intrinsicContentSize: CGSize {
        return self.sizeThatFits(CGSize(width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
    }
}

extension InputAccessoryView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            self.delegate?.inputAccessoryDidBeginEditing()
        })
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude))
        if textView.frame.size.height != size.height {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                self.delegate?.inputAccessoryDidChangeSize()
            })
        }
        addButton.isEnabled = textView.text != ""
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            self.delegate?.inputAccessoryDidEndEditing()
        })
    }
}

protocol InputAccessoryViewDelegate: class {
    func inputAccessoryDidBeginEditing()
    func addRow(text: String)
    func inputAccessoryDidChangeSize()
    func inputAccessoryDidEndEditing()
}
