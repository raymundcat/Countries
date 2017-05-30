# Countries App

![simulator screen shot 30 may 2017 11 42 01 pm](https://cloud.githubusercontent.com/assets/4937515/26592394/3bdef844-4593-11e7-94a6-9f6752793e06.png)

This is a simple Ojective-C iOS app built on a Reactive MVVM-C architecture with Reactive Cocoa. The aim of this app is to let users explore the [Countries API](https://restcountries.eu/) and be able to show then basic information about each countries.

The App consists of 3 main features:

### Categorised Countries List

This is the home/main screen of the app which lets users explore countries by regional categories (Region/Sub Region/Regional Bloc).

For faster loading of images, I've avoided loading multiple flags via the included SVG url from Countries API as this has been observed to easily hog the app's memory.

This module sources the flag images as small PNG files from [www.geognos.com](http://www.geognos.com/geo/en/world-countries-API.html) API. Geognos doesnt have a secured HTTP so an exception for it has been added on the info.plist.

Countries are categorised by adding a category enum and extending the Country Object to return a value per category. This enables future development to easily add more categorisations for the countries.

### Countries Search

Countries searching is enabled through Countries API's name searching endpoint. Results are presented on a collection view the same way as Countries List feature, with the thumbnail flags sourced from the same Geognos API.


### Country Details

Country Details are presented by categorising each presentable details through enum and extending the Country object to return a value per category. This enables future development to easily add more presentable details for each countries.

The Country flag is presented via UIWebview from the SVG image included from Countries API. Tapping on the flag launches an even bigger webview to let the users zoom for the finer details.

### Tests

Unit Tests are added in this project to make sure the more logical parts of the app works as intended.

Country objects decoding and Presenter behaviors are tested by mocking the network layer/API through mocked JSON files added into the repository.

### Other Resources

Reactive Cocoa is the main framework used for the reactive/observer pattern design. The main goal was to dimish delegations and clean up data bindings inbetween Views, Presenters and Flow Controllers.

Masonry is the layouting helper/syntactic sugar used on setting up the view instead of manually setting up the constraints natively.

AFNetworking is the main network/REST call framework used, which enabled the app to cache previous requests for offline functionality.

SDWebImage is the image loading framework used for fetching the Flag PNGs. It also enables the app to cache previously loaded images to ease up data usage and offline functionality.

Hero Animations is a Swift library used to create a seamless transition inbetween screens.

ChameleonFramework is a UIColor manager used to enable easy gradient implementations.

MBProgressHUD is the preferred progress indicator used for this app.

### License

License is MIT. Feel free to make use of the code found on this repo. Contributions/PRs/Critiques are also ver much welcome ^^
