# Viaplay
Work Sample - Navigating Viaplay's API

## Requirements
- iOS 12.0+
- Xcode 10.2

## Installation

Use [CocoaPods](http://cocoapods.org/) to install frameworks and libraries:

- Open up Terminal;
- `cd` into your top-level project directory;
- `pod install` run project.

## Architecture 

1. App runs on MVVM architecture type:
   The idea behind MVVM pattern is that each View on the screen will be backed by a View Model that represents the data for the view.
This means if we are building an application to display sections, then the view might consists of a UIViewController which allows to display the section item and the view model will consists of the data representing the section item like title, description, and links.

2. Navigation 

MVVM pattern supposes that View Model controls navigation. For this purpose I use ScreenRouter with enum RouteType to determine screen which should be performed.

3. Network 

To perform network request I use URLSession dataTask and map response to Swift structure with using Decodable protocol. The request is very light and doesn't need network framework (such as Alamofire or Moyo).

3. Local storage 

To cache data fetched from network and display it in offline mode, I use Realm BD. Realm is a mobile database that runs directly inside device and super easy to use. 
