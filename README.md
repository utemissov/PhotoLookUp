# PhotoLookUp
The photos searching app, Flickr API used underneath

Setup Process
* Clone or Download repo
* Run `pod install`

Project structure
* Project architecture is VIPE(R not using router)
* Heavy use of protocols to decouple modules
* The most part of the code is located in `ImagesModule` folder
* IMHO it's better to start from `ImagesCollectionViewController` which you can find in ImagesModule->View
