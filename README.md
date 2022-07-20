# Todo_App
_This project is a simple todo app with local storage by using hydrated_bloc package_.

Additional Info:
- hydrated_bloc is an extension package of bloc.
- Hive is used for the local storage so no need to worry about performance issues.
- path_provider package is used to get the applicationDocumentsDirectory because this is where we store it.
- WidgetsFlutterBinding.ensureInitialized() is added first in the main.dart to avoid error because HydratedStorage.build will call native code.
- We need toJson and fromJson methods for the local storage to work. (storing and retrieving).
- Uuid package is used for the unique id's of each todo.

# Demo

https://user-images.githubusercontent.com/75658617/179934885-13459159-e83d-4a2a-9c89-3b975c2b0583.mp4


