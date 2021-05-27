//
//  Utility.swift
//  e360
//
//  Created by Sauvik Dolui on 29/11/16.
//  Copyright © 2016 Innofied Solution Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit

let nfc = NotificationCenter.default

class Utility {
	
	// MARK: - JSON
	class func JSON(file: String) -> Any? {
		
		guard let path = Bundle.main.url(forResource: file, withExtension: "json") else {
			print("File Not Found \(file).json")
			return nil
		}
		
		do {
			let stringData = try Data(contentsOf: path)
			return try JSONSerialization.jsonObject(with: stringData, options: .mutableContainers)
		} catch (let error) {
			print("\(error)")
			return nil
		}
	}
	
	// MARK: - Date Calculations
	class func getDateStringFromFormat(formatString: String, date: Date) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = formatString
		return dateFormatter.string(from: date)
	}
    
    
    class func getDateFromDateString(formatString: String, dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        //dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = formatString
        return dateFormatter.date(from: dateString)!
    }

	class func getISO8601DateString(date: Date) -> String {
		return getDateStringFromFormat(formatString: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", date: date)
	}
    
    class func getHourString(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    class func getDateString(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: date)
    }
    
    class func getDateStringForUPC(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM,yyyy"
        return dateFormatter.string(from: date)
    }
    
    class func getWeekDayString(date: Date) -> String {
        
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: date)
        
        switch weekDay {
            
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tue"
        case 4:
            return "Wed"
        case 5:
            return "Thurs"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
            
        default:
            return ""
        }
    }
    
    class func getNumberOfItemsText(numberOfItems: Int) -> String {
        return numberOfItems > 1 ? "Items" : "Item"
    }
    
	// MARK: - Log
	class func logAllAvailableFonts() {
		for family in UIFont.familyNames {
			print("\(family)")
			for name in UIFont.fontNames(forFamilyName: family) {
				print("   \(name)")
			}
		}
	}
    
    class func createTimeStampFromDateString(dateString : String, withFormat : String) -> Double{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = withFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = dateFormatter.date(from: dateString)
        let timeIntervalsince1970 = date?.timeIntervalSince1970
        
        return timeIntervalsince1970!
    }
    
    class func createTimeStampFromDate(date : Date) -> Double{
        let timeIntervalsince1970 = date.timeIntervalSince1970
        return timeIntervalsince1970
    }

    
    class func createDateStringFromTimeStamp(timeStamp : NSNumber, withFormat : String) -> String{
        
        let date = Date(timeIntervalSince1970: TimeInterval(Double(timeStamp.int64Value) / 1000.0))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = withFormat
        let stringDate = dateFormatter.string(from: date)
        
        return stringDate
    }
    
    
    class func createDateFromTimeStamp(timeStamp : NSNumber) -> Date{
        
        let date = Date(timeIntervalSince1970: TimeInterval(Double(timeStamp.int64Value) / 1000.0))        
        return date
    }

    class func getJSONFromDictionary(dictionary: [String: AnyObject]) -> String? {
        do {
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            return String(data: data, encoding:.utf8)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        return nil
    }
    
    // MARK: VERSION
    class func getVersionString() -> String {
        // CFBundleDisplayName
        // CFBundleShortVersionString Version Number
        // CFBundleVersion Build Number
        guard let infoPlistDictionary = Bundle.main.infoDictionary  else {
            return ""
        }
        let appName = "V" //infoPlistDictionary["CFBundleDisplayName"] as? String ?? ""
        let versionNumber = infoPlistDictionary["CFBundleShortVersionString"] as? String ?? ""
        let buildNumber = infoPlistDictionary["CFBundleVersion"] as? String ?? ""
        
        //return appName + " " + "\(buildNumber)"
        return appName + " " + versionNumber + "(\(buildNumber))"
    }
    

}
