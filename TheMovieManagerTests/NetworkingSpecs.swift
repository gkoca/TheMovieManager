//
//  NetworkingSpecs.swift
//  TheMovieManagerTests
//
//  Created by Gökhan KOCA on 9.04.2021.
//

import Foundation
import Quick
import Nimble
@testable import TheMovieManager

class NetworkingSpec: QuickSpec {
	override func spec() {
		describe("networking") {
			it("gets numerous of employees") {
				var count = 0
				var fifth: Empoyee?
				var status: String?
				waitUntil { (done) in
					TestService.employees.call(shoudShowLoading: false) { (response: EmployeesResponse?, error) in
						count = response?.data?.count ?? 0
						fifth = response?.data?[5]
						status = response?.status
						done()
					}
				}
				
				expect(count) == 24
				expect(fifth?.id) == "6"
				expect(fifth?.name) == "Brielle Williamson"
				expect(fifth?.salary) == "372000"
				expect(fifth?.age) == "61"
				expect(status) == "success"
			}
			
			it("gets single employee") {
				
				var employee: EmpoyeeDetail?
				var status: String?
				var message: String?
				waitUntil { (done) in
					TestService.employee(id: "6").call(shoudShowLoading: false) { (response: EmployeeResponse?, error) in
						employee = response?.data
						status = response?.status
						message = response?.message
						done()
					}
				}
				
				expect(employee?.id) == 6
				expect(employee?.name) == "Brielle Williamson"
				expect(employee?.salary) == 372000
				expect(employee?.age) == 61
				expect(status) == "success"
				expect(message) == "Successfully! Record has been fetched."
			}
		}
	}
}

//http://dummy.restapiexample.com/api/v1/employees
//http://dummy.restapiexample.com/api/v1/employee/1
enum TestService: Caller {
	
	
	case employees
	case employee(id: String)
	var apiKey: String? {
		return nil
	}
	
	var baseURL: URL {
		return URL(forceString: "http://dummy.restapiexample.com/api/v1")
	}
	
	var path: String {
		switch self {
		case .employees:
			return "/employees"
		case .employee(let id):
			return "/employee/\(id)"
		}
	}
	
	var method: HTTPMethod {
		return .get
	}
	
	var body: [String : Any]? {
		return nil
	}
	
	var queryString: [String : Any]? {
		return nil
	}
	
	var mock: Data? {
		return nil
	}
}

struct EmployeesResponse: Decodable {
	let status: String?
	let data: [Empoyee]?
}

struct EmployeeResponse: Decodable {
	let status: String?
	let data: EmpoyeeDetail?
	let message: String
}

struct Empoyee: Decodable {
	let id: String?
	let name: String?
	let salary: String?
	let age: String?
	let image: String
	
	enum CodingKeys: String, CodingKey {
		case id
		case name = "employee_name"
		case salary = "employee_salary"
		case age = "employee_age"
		case image = "profile_image"
	}
}

struct EmpoyeeDetail: Decodable {
	let id: Int?
	let name: String?
	let salary: Double?
	let age: Int?
	let image: String
	
	enum CodingKeys: String, CodingKey {
		case id
		case name = "employee_name"
		case salary = "employee_salary"
		case age = "employee_age"
		case image = "profile_image"
	}
}
