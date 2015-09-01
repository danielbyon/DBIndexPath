# DBIndexPath
DBIndexPath is a simple wrapper struct around an NSIndexPath, to make it possible to define an index path enum and switch on its cases. This is especially useful in UITableViewDataSource & UITableViewDelegate methods, where you might execute different code depending on which row you are dealing with.

DBIndexPath's can be created by manually specifying the section/row, with a string of the format "section,row", or with an existing NSIndexPath instance:

    public init(section: Int, row: Int)
    public init?(_ indexPath: NSIndexPath)
    public init(stringLiteral value: StringLiteralType)

DBIndexPath was written with Xcode 7 beta 6 and Swift 2.0.

## Installation
DBIndexPath is easily installed using Cocoapods:

Put this into your podfile:

    platform :ios, '8.0'
    use_frameworks!
    
    pod 'DBIndexPath', '~> 0.1'

And run this to install:

    pod install

## The old way

NSIndexPath does not conform to RawRepresentable, so it cannot be used in enums. It also does not conform to the string, character, or any of the integer or floating-point number type convertible protocols, so it cannot be statically defined. This makes it difficult to easily write maintainable and defect-free code when we want to execute different code based upon the index path.

This is the old way, compatible in Objective-C:

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                // Handle selection
            } else if indexPath.row == 1 {
                // Handle selection
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                // Handle selection
            }
        }

This is not very maintainable and error prone, because when we want to add a new row to be handled, we must update every function that has this logic. There is also a much greater potential for mistyping the indices.

Swift tuples and pattern matching allows us to clean this up a little:

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            // Handle selection
        case (0, 1):
            // Handle selection
        case (1, 0):
            // Handle selection
        default:
            assertionFailure("invalid indexPath: \(indexPath)")
        }
    }

This makes the code more readable, but still does not solve the problem of having to define these indices at each function site.

## The new way
DBIndexPath was designed to be used in conjunction with enums to allow you to switch on a given index path. The enum allows for the index paths to be declared in one place. This makes it easier to add new index paths in the future without needing to copy/paste the hard-coded information.

When you add a new value to the enum, all your switch statements (that don't have a "default" case) will break, forcing you to update them to handle the new value.

### Usage
Define an enum that inherits from DBIndexPath inside your view controller, using string literals:

    enum TableIndex: DBIndexPath {
        case One = "0,0"
        case Two = "0,1"
        case Three = "1,0"
    }

Then, inside a method where you are passed in an NSIndexPath, i.e. tableView(didSelectRowAtIndexPath:):

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let rawValue = DBIndexPath(indexPath), tableIndex = TableIndex(rawValue: rawValue) {
            switch tableIndex {
                case .One:
                    // Handle selection
                case .Two:
                    // Handle selection
                case .Three:
                    // Handle selection
            }
        } else {
            assertionFailure("invalid indexPath: \(indexPath)")
        }
    }

Now all the logic of determining which index path we are dealing with has been abstracted away from the delegate function, and we can focus on handling the row selection.

### DBIndexPathSwitchable Protocol

The may be some instances where the all table view index paths and rows are known at compile time. In other words, the defined enum cases is the exhaustive list of all index paths that will be used.

In these instances, the DBIndexPathSwitchableProtocol can to simplify the code:

In your view controller class, declare conformance to the protocol:

    class ViewController: UITableViewController, DBIndexPathSwitchableProtocol {
        typealias DBIndexPathType = TableIndex
        enum TableIndex: DBIndexPath {
            case One = "0,0"
            case Two = "0,1"
            case Three = "1,0"
        }
    }

Then you can simplify the function sites to:

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPathFromNSIndexPath(indexPath) {
            case .One:
                // Handle selection
            case .Two:
                // Handle selection
            case .Three:
                // Handle selection
        }
    }

# License

MIT license. See the LICENSE file for details.
