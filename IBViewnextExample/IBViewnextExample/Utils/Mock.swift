//
//  Mock.swift
//  IBViewnextExample
//
//  Created by David M. on 02/10/2020.
//

import Foundation
import OHHTTPStubs

class Mock: NSObject {
    
    static let shared = Mock()
    
    @objc class func config() {
        loadMocks()
    }

    static func loadMocks() {
        Mock.shared.loadInvoices()
    }
    
    func loadInvoices() {
        addStub(path: "/invoices", status: 200, file: "invoices.json")
        addStub(path: "/invoicesDetail", status: 200, file: "detail.json")
        addStub(path: "/ultimaFacturaRS", status: 200, file: "ultimaFacturaRS.json")
    }
    
    func addStub(path: String, status: Int32, file: String) {

        stub(condition:  pathEndsWith(path)) { _ in
            if let stubPath = OHPathForFile(file, type(of: self)) {
                return fixture(filePath: stubPath, headers: ["Content-Type":"application/json"])
            } else {
                let stubData = "Json mock not found".data(using: .utf8)
                return fixture(filePath: file, headers: ["Content-Type":"application/json"])
            }
        }
        
    }
    
}
