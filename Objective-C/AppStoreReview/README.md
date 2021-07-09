App Store Review Solution
-------------------------
As of iOS 11, it is not allowed to show an interstitial to a user before directting them to the AppStore. 
There is a new API which allows the user to rate the app without being directed to the AppStore. 
- [requestReview() API](https://developer.apple.com/documentation/storekit/skstorereviewcontroller/2851536-requestreview)

The requestReview() API may or may not show the rating dialog to the user when called so showing an interstitial before calling it wouldn't make sense.
This solution uses a [Swrve Embedded Campaign](https://docs.swrve.com/user-documentation/campaigns/campaign-builder/content/embedded-campaigns/) to trigger the requestReview() API.

How to Run This Demo in XCode
----------------------------
- Run the "pod install" command inside the AppStoreReviewSolution folder.
- Open the project located under AppStoreReviewSolution/AppStoreReviewSolution.xcworkspace
- Replace YOUR_APP_ID in AppDelegate.m with your Swrve App ID.
- Replace YOUR_API_KEY in AppDelegate.m with your Swrve API key.
- Run AppStoreReviewSolution app normally.

Code Changes Required
---------------------
- See the changes required marked clearly in the AppDelegate.m file.
- The main change is to configure the SwrveEmbeddedMessageConfig
- You need to provide the callback method which will be called when any Swrve Embedded Campaign is triggered.
- Inside the callback you have access to the JSON string added in the Content of the Campaign in the Swrve Dashboard.
- In this example we check for a "campaign_type" parameter which should be set to "app_review". 
- If this is the case we call the native iOS requestReview method

Dashboard Setup
---------------
- Create an Embedded campaign with the followin JSON content:
```
{"campaign_type":"app_review"}
```
- Set a target audience and triggering point for the campaign.
- When the campaign is triggered a request to apple's requestReview() API will be made. 
- The dialog may or may not be shown - Apple decide whether or not it should be shown.
