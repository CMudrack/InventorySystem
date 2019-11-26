//
//  QRCodeDetails.swift
//  InventoryProject
//
//  Created by Cody Mudrack on 11/23/19.
//  Copyright © 2019 Cody Mudrack. All rights reserved.
//

// This website helped with this page: https://www.pdftron.com/blog/ios/how-to-add-a-pdf-viewer-using-swift/

import Foundation
import UIKit
import PDFKit
import Firebase

class QRCodeDetails: UIViewController {
    
    var chemicalName: String?
    
    let storageRef = Storage.storage(url: "gs://chemreserve-d952f.appspot.com").reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add PDFView to view controller.
        let pdfView = PDFView(frame: self.view.bounds)
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(pdfView)

        // Fit content in PDFView.
        pdfView.autoScales = true

        if let pdf = chemicalName {
            let pdfURL = storageRef.child("\(pdf).pdf")
            pdfURL.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
                if let error = error {
                    print("There was an error: \(error)")
                    let noPDFAlert = UIAlertController(title: "No SDS Found", message: "SDS for \(pdf) could not be found", preferredStyle: .alert)
                    noPDFAlert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    self.navigationController?.popViewController(animated: true)
                    self.present(noPDFAlert, animated: true, completion: nil)
                } else {
                    pdfView.document = PDFDocument(data: data!)
                }
            }
        }
    }
}
