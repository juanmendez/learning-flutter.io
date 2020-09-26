# Flash Chat ⚡️

- everything is setup, but here is what's needed
    - for iOS add: `ios/Runner/GoogleService-Info.plist`
    - for Android add: `android/app/google-services.json`
    
- next for Macbook, in the terminal run the following at the project root level
    - `sudo gem install cocoapods`
    - `pod setup`  
    
    
Defined rules for Firestore, just for now:
```
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

What we send:
- table name is `messages`
- each object has the following attributes
  - `sender`
  - `text`

```
_firestore.collection("messages").add( {
   "sender": _loggedInUser.email,
   "text": messageText
});
```

Viewed from the app:
<img width="422" alt="image" src="https://user-images.githubusercontent.com/3371622/94347227-05a6a100-fff8-11ea-93d3-7b7c78aa4b16.png">

Shown in Firestore:
<img width="1274" alt="image" src="https://user-images.githubusercontent.com/3371622/94347333-d6dcfa80-fff8-11ea-9ecd-54d74df6ce95.png">
