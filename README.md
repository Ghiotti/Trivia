# Trivia

## Requirements

- Xcode 12
- Swift 5
- Target OS: iOS 12+


## Dependencies

Cocoapods (CocoaPods is the dependency manager for iOS projects check https://cocoapods.org/)

External Libs by Cocoapods:
- Alamofire
- ObjectMapper

## How to run app

1. Install Xcode 11.3.1 
2. Install and setup CocoaPods running the following commands from the terminal:

$ [sudo] gem install cocoapods 
$ pod setup  

For more information go to www.cocoapods.org

3. Restart the terminal and check if it was successfully installed running “pod --version”.
4. Before opening Xcode, from the terminal in root project folder (/SeguritechApp) run the following command on your project directory:

$ pod install

5. After CocoaPods downloaded all the dependencies, you should open the .xcworkspace file instead of the .xcodeproj file. 
6. Finally, you should be able to proceed and compile the sources as you normally do.


## Architecture

Wer are using a simple version of MVP as follow:

MODEL < - > PRESENTER < - > VIEW CONTROLLER


## Networking

`Alamofire` is our main networking framework 

##Comments reference 

// TODO: 
Known pending feature


## Contact ##

- Franco Ghiotti fran.ghiotti@gmail.com
