//
//  ViewController.swift
//  downloadPdf
//
//  Created by Michael de Guzman on 7/29/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var urlTextField: UITextField!
    var pdfURL: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func openPDFButtonPressed(_ sender: Any) {
        let pdfViewController = PDFViewController()
        pdfViewController.pdfURL = self.pdfURL
        present(pdfViewController, animated: false, completion: nil)
    }
    //"https://www.tutorialspoint.com/swift/swift_tutorial.pdf"
    @IBAction func downloadButtonPressed(_ sender: Any) {
        guard let urlString = urlTextField.text else {
        return
    }
        guard let url = URL(string: urlString) else { return }
          
          let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
          
          let downloadTask = urlSession.downloadTask(with: url)
          downloadTask.resume()
      }


}

extension ViewController:  URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("downloadLocation:", location)
        // create destination URL with the original pdf name
        guard let url = downloadTask.originalRequest?.url else { return }
        let documentsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
        // delete original copy
        try? FileManager.default.removeItem(at: destinationURL)
        // copy from temp to Document
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
            self.pdfURL = destinationURL
        } catch let error {
            print("Copy Error: \(error.localizedDescription)")
        }
    }
}
