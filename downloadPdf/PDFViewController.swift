//
//  PDFViewController.swift
//  downloadPdf
//
//  Created by Michael de Guzman on 7/29/22.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {
    
    var pdfView = PDFView()
    var pdfURL: URL!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(pdfView)
        
        if let document = PDFDocument(url: pdfURL) {
            pdfView.document = document
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        pdfView.frame = view.frame
    }
}
