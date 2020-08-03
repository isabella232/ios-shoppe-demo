//
//  CartTableViewCell.swift
//  ios-shoppe-demo
//
//  Created on 4/7/20.
//  Copyright © 2020 FullStory All rights reserved.
//

import Foundation
import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var orderTotalLabel: UILabel!
    @IBOutlet var checkoutButton: UIButton!

    weak var cartTableViewController: CartTableViewController?
    weak var checkoutTableViewController: CheckoutTableViewController? {
        didSet {
            DispatchQueue.main.async {
                self.setTextForPlacingOrder()
            }
        }
    }

    func setup() {
        checkoutButton.curveViewCornersWithShadow()
        orderTotalLabel.adjustsFontSizeToFitWidth = true
        orderTotalLabel.text = order.cartOrderTotal.toCurrency()
    }

    func setTextForPlacingOrder() {
        self.checkoutButton.setTitle("Place your order", for: .normal)
        self.checkoutButton.attributedTitle(for: .normal)
    }

    @IBAction func proceedToCheckout(_ sender: Any) {
        if cartTableViewController != nil {
            cartTableViewController?.presentCheckout()
        }
        else {
            // trigger crash when subtotal exceeds 20 for Crashlytics demo purpose
            if(order.cartOrderTotal > 20) { fatalError("A crash that's hard to troubleshoot'") }
            checkoutTableViewController?.presentProductView()
        }
    }
}
