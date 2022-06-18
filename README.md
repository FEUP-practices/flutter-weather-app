# weather_app

## Execution

Simply put the .env file with the Google Places API Key and the Open weather API key under the root folder. After this, just execute in the terminal:

> flutter run -t lib/app/main.dart

## Architecture

The project is built under the hexagonal architecture, to make everything maintainable and clean. In order to have a covenient global state, the Redux pattern is used as a simple state manager, making the app state more scalable.

The Google Places API is used to make autocompletion on the search tab, in order to make it a lot easier. It makes an HTTP request every 2 seconds if there has been any changes on the search bar input.

The system architecture is pretty simple: the iOS or Android device connects directly to the APIs. If we wanted to scalate the project, we would need to decouple it and separate in a server and proccess the incoming data before sending it back to the client.

## Folder structure



## Bugs

- The application let the user have at most 5 tracked cities. He call delete any city when he want in order to add more. When one city is deleted and the global state is updated, sometimes the index of the bottom nav bar is broken and gets out of range. Possible solution: put the current index into the global state and change it according to the number of items left.
- When there is only one city saved, the Bottom Navigation Bar used is not allow to have less than two items, so even if there is only one city, two dots will appear on the bottom nav bar. Possible solution: mantain the extra dot but make it invisible.

## Performance

These performance tests are made manually and with the Flutter Devtools (https://docs.flutter.dev/development/tools/devtools/performance). 

### iPhone XR

On the iPhone the framerate is always at 60 solid fps and everything works ok.

### Samsung A40

On the Android the framerate slows up to 40 fps when sliding between fragments and scrolling vertically through them. It is something to analyze deeper and try to fix it in future development. 

## Testing

- [ ] Add one city by searching it and see if everything is okey
- [ ] Try to add the same city and see if it is still the same and there is no duplications
- [ ] Try to add more that five cities and get and error
- [ ] Delete one city and see if the global state is updated
- [ ] Delete every city (if bugs allow it) and check if you are left with the welcome page again
