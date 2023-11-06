import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task3/auth/singupscreen.dart';
import 'package:task3/themes.dart';

import '../auth/loginscreen.dart';

class MySettings extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Column(
              children: [
                Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        width: width*0.2,
                        child: Divider(color: Theme.of(context).primaryColor,),
                      ),
                      Text("Themes",style: Theme.of(context).textTheme.displayMedium,),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Divider(color: Theme.of(context).primaryColor,),
                        ),
                      ),
                    ]
                ),
                ListTile(
                  onTap: (){
                    Get.bottomSheet(Container(
                      height: height*0.2,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorDark,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(height*0.01)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ListTile(
                            title: const Text("Light Mode"),
                            leading: const Icon(Icons.sunny),
                            onTap: (){
                              Get.isDarkMode?Get.changeTheme(Themes.lighttheme):null;
                              Get.back();
                            },
                            subtitle: Get.isDarkMode?const Text(""):const Text("Currently Light Mode"),
                          ),
                          ListTile(
                            onTap: (){
                              Get.isDarkMode?null:Get.changeTheme(Themes.darktheme);
                              Get.back();
                            },
                            title: const Text("Dark Mode"),
                            leading: const Icon(Icons.dark_mode),
                            subtitle: Get.isDarkMode?const Text("Currently Dark Mode"):const Text(""),
                          ),
                        ],
                      ),
                    ),isScrollControlled: true);
                  },
                  leading: const Icon(Icons.phone_android),
                  subtitle: const Text("Change Theme Mode from Light/Dark/System",overflow: TextOverflow.ellipsis,),
                  title: const Text("Theme Mode"),
                ),
                Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                  width: width*0.2,
                        child: Divider(color: Theme.of(context).primaryColor,),
                      ),
                      Text("Info",style: Theme.of(context).textTheme.displayMedium,),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Divider(color: Theme.of(context).primaryColor,),
                        ),
                      ),
                    ]
                ),
                ListTile(
                  onTap: (){
                    Get.bottomSheet(Container(
                      width: width,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorDark,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(20))
                      ),
                      padding: EdgeInsets.all(width*0.05),
                      height: height*0.33,
                      child: Column(
                        children: [
                          Text("App Details",style: Theme.of(context).textTheme.titleMedium,),
                          Divider(),
                          Expanded(
                            child: ListView(
                              children: [
                                ListTile(
                                  title: Text("Provides a Decent User Interface",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400),),
                                ),
                                ListTile(
                                  title: Text("Provides Authentication Service",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400),),
                                ),
                                ListTile(
                                  title: Text("One to One Chat Functionality",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400),),
                                ),
                                ListTile(
                                  title: Text("Dark/Light Theme Mode Available",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400),),
                                ),
                                ListTile(
                                  title: Text("Delete Chat Option",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400),),
                                ),
                                ListTile(
                                  title: Text("Delete Account Option",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400),),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ));
                  },
                  leading: const Icon(Icons.info),
                  subtitle: const Text("About the Application , Features , User Interaction",overflow: TextOverflow.ellipsis,),
                  title: const Text("App Info"),
                ),
                ListTile(
                  leading: const Icon(Icons.help),
                  subtitle: const Text("Contact our Creator for Any Issues faced .",overflow: TextOverflow.ellipsis,),
                  title: const Text("Help"),
                ),
                Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        width: width*0.2,
                        child: Divider(color: Theme.of(context).primaryColor,),
                      ),
                      Text("Accounts",style: Theme.of(context).textTheme.displayMedium,),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Divider(color: Theme.of(context).primaryColor,),
                        ),
                      ),
                    ]
                ),
                ListTile(
                  leading:const Icon(Icons.edit),
                  subtitle: const Text("Change Your Profile Pic , Password , Username etc ....",overflow: TextOverflow.ellipsis,),
                  title: const Text("Edit Profile"),
                ),
                ListTile(
                  onTap: (){
                    Get.dialog(Dialog(
                      child: Container(
                        height: height/3.5,
                        width: width/1.2,
                        padding: EdgeInsets.all(height*0.025),
                        child: Column(
                          children: [
                            Text("Are you Sure You want to Delete your Account?",style: TextStyle(fontSize: 22,color: Theme.of(context).primaryColor),maxLines: 2,),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(onPressed: ()async{
                                  await FirebaseAuth.instance.currentUser?.delete().then((value) {
                                    Get.back();
                                    Get.back();
                                    Get.off(() => LoginScreen(),
                                        transition: Transition.cupertino);
                                  });
                                  Get.back();
                                }, child: const Text("Yes"),),
                                SizedBox(width: width*0.03,),
                                ElevatedButton(onPressed: (){
                                  Get.back();
                                }, child: const Text("No"),),
                              ],
                            )
                          ],
                        ),
                      ),
                    ));
                  },
                  leading:const Icon(Icons.person_off),
                  subtitle: const Text("All Your Data will be lost including your chats , calls etc",overflow: TextOverflow.ellipsis,),
                  title: const Text("Delete Account"),
                ),
                ListTile(
                  onTap: () async {
                    Get.dialog(Dialog(
                      child: Container(
                        height: height/3.5,
                        width: width/1.2,
                        padding: EdgeInsets.all(height*0.025),
                        child: Column(
                          children: [
                            Text("Are you Sure You want to Log Out?",style: TextStyle(fontSize: 22,color: Theme.of(context).primaryColor),maxLines: 2,),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(onPressed: ()async{
                                  await FirebaseAuth.instance.signOut().then((value) {
                                    Get.back();
                                    Get.back();
                                    Get.off(() => LoginScreen(),
                                        transition: Transition.cupertino);
                                  });
                                }, child: const Text("Yes"),),
                                SizedBox(width: width*0.03,),
                                ElevatedButton(onPressed: (){
                                  Get.back();
                                }, child: const Text("No"),),
                              ],
                            )
                          ],
                        ),
                      ),
                    ));
                  },
                  leading:const Icon(Icons.logout),
                  subtitle: const Text("LogOut from your Account"),
                  title: const Text("LogOut"),
                ),
              ],
            ),
          ),),
    );
  }
}
