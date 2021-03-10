# MovieDB
### Access Movies/TV Shows DB and Cinemas
![logo](https://raw.githubusercontent.com/LuongPV/moviedb/master/screenshots/ic_logo.png)

## Features

- View Trending Movies/TV Shows
- View Movie and TV Show posters
- View detail Movie/TV Show including Casts, Rating, IMDB Info, Categories, Youtube Trailer Videos
- View Cast details including IMDB Info, Played Movies
- Scan QR code to open a Youtube Video
- Get nearby cinemas on current location

## Tech

MovieDB uses a number of open source sdk/library to work properly:

- [Flutter SDK] - SDK for creating cross platform mobile app
- [The Movie DB] - Open Movie DB for free access
- [QR Code Scanner] - Scanning QR to open the correct video
- [Google Place API] - Find nearby Cinemas
- [Google Direction API] - Find directions to Cinemas

## Installation

MovieDB requires [Flutter SDK] to run.

Move to the flutter application root directory

```sh
cd <app dir>
```

For build Fat (Universal - containing all the ABIs) APK

```sh
flutter build apk
(The flutter build command defaults to --release)
```

For build Split APKs

```sh
flutter build apk --split-per-abi
```

Install an APK on a connected device

```sh
flutter install
```

## Screenshots

![home](https://raw.githubusercontent.com/LuongPV/moviedb/master/screenshots/home.jfif)
![movie_detail](https://raw.githubusercontent.com/LuongPV/moviedb/master/screenshots/movie_detail.jfif)
![cast_detail](https://raw.githubusercontent.com/LuongPV/moviedb/master/screenshots/cast_detail.jfif)
![movies_by_category](https://raw.githubusercontent.com/LuongPV/moviedb/master/screenshots/movies_by_category.jfif)
![nearby_cinemas](https://raw.githubusercontent.com/LuongPV/moviedb/master/screenshots/nearby_cinemas.png)
![qr_scan](https://raw.githubusercontent.com/LuongPV/moviedb/master/screenshots/qr_scan.jfif)
![menu](https://raw.githubusercontent.com/LuongPV/moviedb/master/screenshots/menu.jfif)
![search](https://raw.githubusercontent.com/LuongPV/moviedb/master/screenshots/search.png)
![login](https://raw.githubusercontent.com/LuongPV/moviedb/master/screenshots/login.jfif)

## Development

Want to contribute? Great! Just fork the project, make your code and don't be hesitated to create merge requests. I'll be happy to check it

## License

MIT

**Free Software, Hell Yeah!**

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)


   [Google Direction API]: <https://developers.google.com/maps/documentation/directions/overview>
   [Google Place API]: <https://developers.google.com/maps/documentation/places/web-service/search>
   [QR Code Scanner]: <https://pub.dev/packages/qr_code_scanner>
   [The Movie DB]: <https://www.themoviedb.org>
   [Flutter SDK]: <https://flutter.dev>

