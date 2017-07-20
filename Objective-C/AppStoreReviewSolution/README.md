App Store Review Solution
-------------------------
As of iOS 11 Apple don't allow you to show an interstitial to a user before directting them to the app store. 
They have a new API which allows the user to rate the app without being directed to the app store. 
- [requestReview() API](https://developer.apple.com/documentation/storekit/skstorereviewcontroller/2851536-requestreview)

The requestReview() API may or may not show the rating dialog to the user when called so showing an interstitial before calling it wouldn't make sense.
This solution lets you create an In App Message Campaign in Swrve and instead of showing an In App Message you will simply trigger the requestReview() API.
This will allow you to trigger a call to the requestReview without triggering an In App Message.

How to Run This Demo in XCode
----------------------------
- Run the "pod install" command inside the AppStoreReviewSolution folder.
- Open the project located under AppStoreReviewSolution/AppStoreReviewSolution.xcworkspace
- Replace YOUR_APP_ID in AppDelegate.m with your Swrve app ID.
- Replace YOUR_API_KEY in AppDelegate.m with your Swrve API key.
- Run AppStoreReviewSolution app normally.

Code Changes Required
---------------------
- See the changes required marked clearly in the AppDelegate.h and AppDelegate.m files.
- The main change is to add a showMessage Delegate which takes over the normal rendering of an In App Message. 
- The showMessageDelegate checks to see if the name of the Campaign contains "AppStore Review".
- If it does - trigger the requestReview() API without showing a message.
- If it does not - trigger the In App Message as normal.

Dashboard Setup
---------------
- Create an In App Message campaign with a name containing "AppStore Review".
- Set a target audience and triggering point for the campaign.
- When the campaign is triggered a request to apple's requestReview() API will be made. 
- The dialog may or may not be shown - Apple decide whether or not it should be shown.
