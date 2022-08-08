# rijksmuseum

First checkout the project and start the **rijksmuseum.xcodeproj** file, there are no third party dependencies, so it’s pretty simple. In case you want to build on a real device, add your bundle ID project settings. 

# User Interface:
* Just build the app and you will see the loading screen while the art list data is being fetched from the API. 
* You can scroll down to the bottom of the list to fetch more.
* After the successful data retrieval, art list is shown in collection view list with 2 columns.
* In case of any error an alert is presented (turn the internet off and restart the app or try to tap a destination to try it out). Of course, this can be done in much more detail if Reachability class is used, but it would go outside of scope of this test project and it was mentioned to avoid 3rd party libs or other solutions. 
* To see the art details tap on the cell and Art Details Screen will appear. Tap again on the image and you will be able to explore it by zooming and panning 

# Architecture:
* MVP + Coordinator
* Networking module is independent and can be implemented anywhere. It is based on Apple's “URLSession” and generics so no third party libs have been used.
* Repository separate presenter layer and services layer. It also converts Response models to Domain models.
* Test Coverage 83.7%
* Unit tests are made for presenters, repository and moc JSON of art products list and details, they are just examples and many more tests can be done.
* UI tests for main flow and pagination mechanic.
* File organisation: 
```
├── AppDelegate.swift
├── SceneDelegate.swift - Coordinator started
├── Features
│   ├── DetailPage
│   │   ├── DetailPageConfigure.swift - Builder for Detail Page feature
│   │   ├── DetailPagePresenter.swift
│   │   └── DetailPageView.swift
│   └── List
│       ├── Cells
│       │   ├── ArtCell.swift
│       │   ├── HeaderView.swift
│       │   └── IndicatorCell.swift
│       ├── Common
│       │   └── ListViewItemsSourcing.swift
│       ├── ListConfigure.swift - Builder for List feature
│       ├── ListPresenter.swift
│       ├── ListSectionModel.swift
│       └── ListView.swift
├── Coordinator
│   ├── CoordinatorProtocol.swift
│   └── MainCoordinator.swift
├── Dependency
│   └── Dependency.swift – Build Repository and Services (NetworkService)
└── Views
│   └── ArtImageView.swift
├── Models - Domain models
│   ├── ArtCollection.swift
│   ├── ArtCollectionObject.swift
│   ├── ArtDetails.swift
│   └── ArtImage.swift
├── Network
│   ├── ImageDownloader
│   │   ├── ImageCache.swift - Simple example how to cache images without NSCache and FileManager
│   │   └── ImageDownloader.swift
│   ├── NetworkManager
│   │   ├── NetworkEnvironmentProtocol.swift
│   │   ├── NetworkError.swift
│   │   └── NetworkRouteProtocol.swift
│   ├── Response - Response models
│   │   ├── ArtCollectionResponse.swift
│   │   ├── ArtDetailObjectResponse.swift
│   │   ├── ArtDetailsResponse.swift
│   │   ├── ArtObjectResponse.swift
│   │   └── ArtWebImageResponse.swift
│   ├── RijksEnvironment.swift
│   └── RijksNetworkService.swift
├── Repository
│   └── RijksRepository.swift
└── Resources
    ├── Assets.xcassets
    ├── Constants.swift
    └── Localizable.strings
```