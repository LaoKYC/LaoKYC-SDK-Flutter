<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->



## Features

LaoKYC_Button Login is a Flutter package to help your client connect to your application via LaoKYC, 
this package developed by LaoKYC.

This Package will help you to provide an optional login for your client, who lack of an ability
to registry with your application.

## Installation
Add the following code to your pubspec.yaml:

        dependencies:
            laokyc_logbottom: ^0.1.6

## Usage

Import the package

    import ' package:laokyc_logbottom/laokyc_logbottom.dart '

Add your clienId, clientSecret, redirectUrl, route, lang and scope

LaoKYCButton(
    clienId = 'Your clientId',
    clientSecret = 'Your clientSecret',
    redirectUrl = 'Your redirectUrl',
    route = Your page after client login success
    lang = 'LA' or 'EN', //Choose between  LA or EN for language to show Login dialog LA(Laos), EN(English)
    scope = 'This will be provide by LaoKYC',
);

P.S All of this parameter will be provide by LaoKYC


## Additional information

Don't forget to config in android project

- add the following code in build.gradle android project : 
 defaultConfig {
 .
 .
 manifestPlaceholders = [
 'appAuthRedirectScheme': 'Your Redirect Url'
 ]
 }

 - add the following code in AndroidManifest.xml android project :
in tag manifest
<queries>
 <intent>
 <action android:name="android.intent.action.VIEW" />
 <category android:name="android.intent.category.BROWSABLE" />
 <data android:scheme="https" />
 </intent>
 <intent>
 <action android:name="android.intent.action.VIEW" />
 <category android:name="android.intent.category.APP_BROWSER" />
 <data android:scheme="https" />
 </intent>
</queries>
