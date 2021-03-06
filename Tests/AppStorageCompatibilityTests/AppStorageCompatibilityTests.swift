import XCTest
import SwiftUI
@testable import AppStorage

@available(macOS 11, iOS 14, tvOS 14, watchOS 7, *)
final class AppStorageCompatibilityTests: XCTestCase {

    func testStoringBooleansShouldBeEquivalentToAppStorage() {
        let storeSwiftUI = UserDefaults(suiteName: #function + "SwiftUI")!
        let storePackage = UserDefaults(suiteName: #function + "Package")!

        // SwiftUI
        let swiftUI = AppStorage(wrappedValue: true, "boolean", store: storeSwiftUI)
        swiftUI.wrappedValue = false

        // AppStorage Package
        let package = AppStorageCompat(wrappedValue: true, "boolean", store: storePackage)
        package.wrappedValue = false

        XCTAssertEqual(storePackage.bool(forKey: "boolean"), false)
        XCTAssertEqual(storeSwiftUI.dictionaryRepresentation() as NSDictionary,
                       storePackage.dictionaryRepresentation() as NSDictionary)
    }

    func testStoringIntegersShouldBeEquivalentToAppStorage() {
        let storeSwiftUI = UserDefaults(suiteName: #function + "SwiftUI")!
        let storePackage = UserDefaults(suiteName: #function + "Package")!

        // SwiftUI
        let swiftUI = AppStorage(wrappedValue: 42, "magic number", store: storeSwiftUI)
        swiftUI.wrappedValue = 43

        // AppStorage Package
        let package = AppStorageCompat(wrappedValue: 42, "magic number", store: storePackage)
        package.wrappedValue = 43

        XCTAssertEqual(storePackage.integer(forKey: "magic number"), 43)
        XCTAssertEqual(storeSwiftUI.dictionaryRepresentation() as NSDictionary,
                       storePackage.dictionaryRepresentation() as NSDictionary)
    }

    func testStoringDoublesShouldBeEquivalentToAppStorage() {
        let storeSwiftUI = UserDefaults(suiteName: #function + "SwiftUI")!
        let storePackage = UserDefaults(suiteName: #function + "Package")!

        // SwiftUI
        let swiftUI = AppStorage(wrappedValue: 42.0, "magic number", store: storeSwiftUI)
        swiftUI.wrappedValue = 42.1

        // AppStorage Package
        let package = AppStorageCompat(wrappedValue: 42.0, "magic number", store: storePackage)
        package.wrappedValue = 42.1

        XCTAssertEqual(storePackage.double(forKey: "magic number"), 42.1)
        XCTAssertEqual(storeSwiftUI.dictionaryRepresentation() as NSDictionary,
                       storePackage.dictionaryRepresentation() as NSDictionary)
    }

    func testStoringStringsShouldBeEquivalentToAppStorage() {
        let storeSwiftUI = UserDefaults(suiteName: #function + "SwiftUI")!
        let storePackage = UserDefaults(suiteName: #function + "Package")!

        // SwiftUI
        let swiftUI = AppStorage(wrappedValue: "surfin' bird", "the word", store: storeSwiftUI)
        swiftUI.wrappedValue = "bird"

        // AppStorage Package
        let package = AppStorageCompat(wrappedValue: "surfin' bird", "the word", store: storePackage)
        package.wrappedValue = "bird"

        XCTAssertEqual(storePackage.string(forKey: "the word"), "bird")
        XCTAssertEqual(storeSwiftUI.dictionaryRepresentation() as NSDictionary,
                       storePackage.dictionaryRepresentation() as NSDictionary)
    }

    func testStoringURLsShouldBeEquivalentToAppStorage() {
        let storeSwiftUI = UserDefaults(suiteName: #function + "SwiftUI")!
        let storePackage = UserDefaults(suiteName: #function + "Package")!

        let url1 = URL(string: "https://example.com")!
        let url2 = URL(string: "https://example.org")!

        // SwiftUI
        let swiftUI = AppStorage(wrappedValue: url1, "url", store: storeSwiftUI)
        swiftUI.wrappedValue = url2

        // AppStorage Package
        let package = AppStorageCompat(wrappedValue: url1, "url", store: storePackage)
        package.wrappedValue = url2

        XCTAssertEqual(storePackage.url(forKey: "url"), url2)
        XCTAssertEqual(storeSwiftUI.dictionaryRepresentation() as NSDictionary,
                       storePackage.dictionaryRepresentation() as NSDictionary)
    }

    func testStoringDataShouldBeEquivalentToAppStorage() {
        let storeSwiftUI = UserDefaults(suiteName: #function + "SwiftUI")!
        let storePackage = UserDefaults(suiteName: #function + "Package")!

        let data1 = "0101".data(using: .utf8)!
        let data2 = "1010".data(using: .utf8)!

        // SwiftUI
        let swiftUI = AppStorage(wrappedValue: data1, "raw data", store: storeSwiftUI)
        swiftUI.wrappedValue = data2

        // AppStorage Package
        let package = AppStorageCompat(wrappedValue: data1, "raw data", store: storePackage)
        package.wrappedValue = data2

        XCTAssertEqual(storePackage.data(forKey: "raw data"), data2)
        XCTAssertEqual(storeSwiftUI.dictionaryRepresentation() as NSDictionary,
                       storePackage.dictionaryRepresentation() as NSDictionary)
    }

    func testStoringStringEnumsShouldBeEquivalentToAppStorage() {
        let storeSwiftUI = UserDefaults(suiteName: #function + "SwiftUI")!
        let storePackage = UserDefaults(suiteName: #function + "Package")!

        enum StringEnum: String { case a, b }

        // SwiftUI
        let swiftUI = AppStorage(wrappedValue: StringEnum.a, "string enum", store: storeSwiftUI)
        swiftUI.wrappedValue = .b

        // AppStorage Package
        let package = AppStorageCompat(wrappedValue: StringEnum.a, "string enum", store: storePackage)
        package.wrappedValue = .b

        XCTAssertEqual(storePackage.string(forKey: "string enum"), "b")
        XCTAssertEqual(storeSwiftUI.dictionaryRepresentation() as NSDictionary,
                       storePackage.dictionaryRepresentation() as NSDictionary)
    }

    func testStoringIntegerEnumsShouldBeEquivalentToAppStorage() {
        let storeSwiftUI = UserDefaults(suiteName: #function + "SwiftUI")!
        let storePackage = UserDefaults(suiteName: #function + "Package")!

        enum IntEnum: Int { case a, b }

        // SwiftUI
        let swiftUI = AppStorage(wrappedValue: IntEnum.a, "int enum", store: storeSwiftUI)
        swiftUI.wrappedValue = .b

        // AppStorage Package
        let package = AppStorageCompat(wrappedValue: IntEnum.a, "int enum", store: storePackage)
        package.wrappedValue = .b

        XCTAssertEqual(storePackage.integer(forKey: "int enum"), 1)
        XCTAssertEqual(storeSwiftUI.dictionaryRepresentation() as NSDictionary,
                       storePackage.dictionaryRepresentation() as NSDictionary)
    }
}
