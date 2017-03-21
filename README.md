# Bandlab

## How to cache audio
- I'm using `NSCache` to cache every loading `AVPlayerItem`, with key is `audioLink`
- Using only one instance of `AVPlayer` to plays all audios in app, avoid create too many players it leading to crash
- When playing an audio, just checking it whether in cache or not.
  + If cache already had that audio the get corresponding `AVPlayerItem` and replace to the player.
  + If cache not contains that audio then create new `AVPlayerItem`, replace into the player and add it into cache


## Repo structure
* **<u>Engine</u>**: Shared classes, enums, structures, or logic, business on backend, networks, parsers, helpers, caches, data store, etc...
	* **Manager**: Contains Singleton class to handle Application product
		* Authentication manager
		* Push notifications manager
		* REST manager files
	* **Constant**:
	 	* AppConstants file
	 	* RESTConstants file
	 	* Constants file
	 	* ...
	* **Utility**:
	 	* AppUtils file
		* RESTUtils file  
		* ...
	* **Config**: Contains everything contribute for configuration app
	 	* AppConfig file: Configure all setting in app: Feedback, geting started with third party libraries, configure server's hosts, configure logger, ...
	* **Extension**: Extend class / struct / enum
	* **Service**:
	 	* **ApiService**: Call API
	 	* **SystemService**: Handle system service (Push Notification, ...)
	* **Persistence**: Store entities here
* **<u>ViewModule</u>**: Every module contains View, ViewModel & anything related to front end.
 	* **Component**: The views that they will be share between multiple screens. With each screen should be has a folder for itself
 	* **View**: Represent for the screens. With each screen should be has a folder for itself
 	 	* E.g. Feed:
 	 	 	* ```FeedViewController.swift``` file
 	 	 	* ```FeedViewModel.swift``` file  
* **<u>Resource</u>**: Can be contains Images, Sounds, Layout config file, etc.
 	* ```Assets.xcassets```
 	* ```Localizable.strings```
 	* ...
* **<u>Storyboard</u>**: Put all storyboards at here. With each screen should be has a storyboard file for itself => Reduce conflicts when merge **Pull Request** 
