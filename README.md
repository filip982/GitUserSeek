# GitUserSeek
Discover and explore GitHub users effortlessly with GitUserSeek.

## Installation
The process is automatic thanks to Swift Package Manager. Just open Xcode project and Xcode will do everything for ya :-) 

## Usage
Run on simulator or device. Requires latest iOS v17.0

## Dependencies
SPM libraries:
 - Alamofire - for more convenient networking
 - JGProgressHUD - Pretty loading spinner
 - SwiftMessages - Nice pop up messages to inform user about errors

## Architecture
Uses MVVM design pattern for presentation layer while Domain Logic is in Service classes.
Unit tests are performed on ViewModels.