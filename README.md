# Regatta Timer
Regatta Timer allows Android and WearOS users manage their time in the pre-start of sail racing regattas by providing them with relevant timing information as well as audio visual cues.

## Features
* **High Octane UI:**               The pre-start of a sailing regatta is a hectic environment and Regatta Timer's UI respects that. We do not focus on elegant visuals but on practicality, meaning big buttons, big numbers and accidental interaction prevention.
* **Set Start Time:**               Different start procedures use various different start times, so the user can select their appropriate time conveniently from the main screen.
* **Synchronize Start Time:**       Is is quite common that the start procedure signal is not caught exactly by the racing teams in the heat of the pre-start. This is why Regatta Timer allows users to synchronize their approximate timer with the closest full minute when the appropriate signal is given.
* **Start Procedure Flags:**        As part of the start procedure, the race committee is required to set and douse certain flag signals at given time intervals. Regatta Timer's Start Procedure Flags feature displays the expected flags at each point in time of the pre-start, so the user can validate their time keeping.
* **Audio Visual Signals:**         Regatta Timer will vibrate and read out the time at relevant intervals, helping the user keep track of time without having to look at the app, letting them focus on what's happening around them.
* **Race Data:**                    On supported platforms, Regatta Timer displays heading and speed information after the start. A race timer is displayed on all platforms.
* **Charly Mode:**                  Charly Mode is a training mode inspired by Charly Fernbach, in which whenever a pre-start timer ends, a new one is started, reducing the time by half compared to the previous round. This mode is meant for a team to practice a variety of start situations under increasingly time constrained conditions.
* **Rich Configuration Options:**   Regatta Timer allows you a wealth of configuration such as:
  * Enabling / disabling the above mentioned Charly Mode
  * Requiring long presses on different buttons to prevent accidental interactions
  * Wake Locks to prevent the app from going to sleep in the most critical parts of the race
  * App Lock to prevent Regatta Timer from being closed by accidentally pressing the back button on wearable devices
  * Enabling / Disabling the above mentioned Start Procedure Flags
  * Enabling / Disabling the above mentioned Voice Notifications
  * Enabling / Disabling the above mentioned Location services


## Google Play Store
Regatta is available on both Android mobile and wearOS wearable devices such as smart watches through the [Google Play Store](https://play.google.com/store/apps/details/Regatta_Timer?id=ch.masus.regatta_timer_v2&gl=US).

## Feature Requests
Please feel free to open issues for any features you would like to see implemented in the app.

## Limitations
* Due to some limitations of Flutter on wearOS, location data is not accessible on wearOS, hence heading and speed cannot be displayed on wearable devices.
* Regatta Timer is developed in Flutter, which currently does not support wearOS well. This leads to some instances where the Google Play Store requires certain features to be implemented, which are not supported by the framework. For this reason the app currently cannot be updated on the play store. We are looking for solutions for these instances.