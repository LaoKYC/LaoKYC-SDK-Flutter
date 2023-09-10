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

**LaoKYC Login Button** is a Flutter package to help your client connect to your application via LaoKYC, 
this package developed by LaoKYC.

This Package will help you to provide an optional login for your client, who lack of an ability
to registry with your application.

## Installation
Add the following code to your **pubspec.yaml** :

        dependencies:
            laokyc_button: ^0.8.4
            
<p align="center">
  <img src="https://github.com/LaoKYC/LaoKYC-SDK-Flutter/raw/main/assets/ScreenShotDemo.png">
</p>


## Usage

Import the package

    import ' package:laokyc_button/laokyc_login_button.dart '

- add your clienId, clientSecret, redirectUrl, route, lang and scope

    
        LaoKYCButton(
                clienId = 'Your clientId',
                clientSecret = 'Your clientSecret',
                redirectUrl = 'Your redirectUrl',
                route = Your page after client login success
                locale = const Locale('en') or const Locale('lo'), //Choose between Locale('en') or Locale('lo') for language to show Login dialog Locale('lo') for Lao, Locale('en') for English
                scope = 'This will be provide by LaoKYC',
        );
    


P.S All of this parameter will be provide by **LaoKYC**
   ``` 
   Email : partner@sbg.com
   Mobile : +8562058988895
   ```



## Additional information

Don't forget to config in android project

- add the following code in **build.gradle** android project :

                defaultConfig {
                        .
                        .
                     manifestPlaceholders = [
                         'appAuthRedirectScheme': 'Your Redirect Url'
                                ]
                        }

 - add the following code in **AndroidManifest.xml** android project :
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
 - Finally , You'll get data reult in page after client login success
    
    - Add the following code to your **pubspec.yaml** :
 
                dependencies:
                    shared_preferences: ^2.0.6
                    
    - Add the following code to your **LoginPage.dart** :
                
                class LoginPage extends StatelessWidget {
                  @override
                  Widget build(BuildContext context) {
                    return Scaffold(
                        appBar: AppBar(
                          title: Text('LaoKYC Login'),
                        ),
                        body: Center(
                          child: LaoKYCButton(
                          clientId: 'Your clientId',
                          clientSecret: 'Your clientSecret',
                          redirectUrl: 'Your redirectUrl',
                          scope: 'This will be provide by LaoKYC',
                          route: Your page after client login success,
                          locale = const Locale('en') or const Locale('lo'), //Choose between Locale('en') or Locale('lo') for language to show Login dialog Locale('lo') for Lao and Locale('en') for English
                        )));
                  }
                }
           
    - Add the following code to your **DashboardPage.dart** :   
             
                String? AccessToken;
    
                getPref() async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    setState(() {
                        AccessToken = prefs.getString('access_token');
                    });
                }
                
                @override
                  void initState() {
                    super.initState();
                    getPref();
                }


