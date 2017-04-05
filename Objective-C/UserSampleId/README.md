Swrve SDK User Sample Id
-------------------------
Example of how to use the user id to generate an int between 1 and 100 and update a user property in Swrve

Overview
--------
This solution generates a number between 1 and 100 and assign it to each user as a user property. 
This number can then be used to sort users into different groups (or Swimlanes) and then target them with different marketing strategies over multiple campaigns.

How to Run This Demo in XCode
----------------------------
- Run the "pod install" command inside the UserSampleId folder.
- Open the project located under UserSampleIdExample/UserSampleIdExample.xcodproj
- Replace YOUR_APP_ID in AppDelegate.m with your Swrve app ID.
- Replace YOUR_API_KEY in AppDelegate.m with your Swrve API key.
- Run UserSampleIdExample app normally.
- Add the device as a QA device to see the "user_sample_id" user property being sent to Swrve.

How to Use This in Your Own App
-------------------------------
- Copy UserSampleIdUtils.h and UserSampleIdUtils.m into your own project
- Immediately after Initializing Swrve, call the [UserSampleIdUtils generateNumberForUser:swrveUserId] method.
- This method takes the swrve_user_id as a parameter and generates a number from 1-100.
- It then updates the "user_sample_id" user property with the value generated.
- This "user_sample_id" user_property can be used to target groups of users with different marketing strategies.