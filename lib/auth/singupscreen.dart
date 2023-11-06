import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:task3/auth/loginscreen.dart';
import 'package:task3/controllers/loadingcontroller.dart';
import 'package:task3/utils/mytextfield.dart';

import '../screens/home.dart';

class SignUpScreen extends StatefulWidget {

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  File? imagefile;

  final namecontroller = TextEditingController();

  final emailcontroller = TextEditingController();

  final passwordcontroller = TextEditingController();

  final loadingController = Get.put(LoadingController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final _auth = FirebaseAuth.instance;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              Get.isDarkMode?'assets/images/darkblueback.jpg':'assets/images/lightblueback.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: height*0.125,),
                  Stack(
                    children: [
                      CircleAvatar(
                          radius: width * 0.25,
                          backgroundColor: Theme.of(context).primaryColor,
                          backgroundImage:imagefile !=null ?FileImage(imagefile!,scale: 1):null,
                          child: imagefile==null ? Icon(Icons.person,size: width*0.25,color: Theme.of(context).primaryColorDark,):null,
                        ),
                      Positioned(
                        right: width*0.001,
                        bottom: height*0.001,
                        child: ElevatedButton(onPressed:(){
                          Get.bottomSheet(Container(
                            padding: EdgeInsets.all(height*0.005),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(height*0.05)),
                            ),
                            height: height*0.2,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(radius: width*0.15,backgroundColor: Theme.of(context).primaryColorDark,child: IconButton(onPressed: () async {
                                    },icon: Icon(Icons.camera_alt,size: width*0.15,),),),
                                    const Text("Camera"),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(radius: width*0.15,backgroundColor: Theme.of(context).primaryColorDark,child: IconButton(onPressed: () async {
                                      _pickImagefromGallery();
                                    },icon: Icon(Icons.photo,size: width*0.15,),),),
                                    const Text("Gallery"),
                                  ],
                                ),
                              ],
                            ),
                          ));
                        },style: ElevatedButton.styleFrom(shape:const CircleBorder()), child: const Icon(Icons.edit)),),
                    ],
                  ),
                  MyTextField(
                    keyboardtype: TextInputType.text,
                    labeltext: "Name",
                    controller: namecontroller,
                  ),
                  MyTextField(
                    keyboardtype: TextInputType.emailAddress,
                    labeltext: "Email",
                    controller: emailcontroller,
                  ),
                  MyTextField(
                    keyboardtype: TextInputType.text,
                    labeltext: "Password",
                    obsure: true,
                    controller: passwordcontroller,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("Forgot Password?"),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Obx(
                        ()=> ElevatedButton(
                        onPressed: () async{

                          loadingController.loading.value=true;
                          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text).then((value) async {
                            _auth.currentUser?.updateDisplayName(namecontroller.text) ;
                            loadingController.loading.value=false;


                            await FirebaseFirestore.instance.collection('Users').doc(_auth.currentUser?.uid.toString()).set({
                              'uid':_auth.currentUser?.uid,
                              'name':namecontroller.text,
                              'email':emailcontroller.text,
                            });
                            Get.off(()=>Home());


                          }).onError((error, stackTrace){
                            loadingController.loading.value=false;
                            debugPrint(error.toString());
                          });
                        },
                        child: loadingController.loading.value? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColorDark,)): const Text("Login"),
                      ),
                    ),
                  ),
                  SizedBox(height: height*0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Already Have A Account?",style: Theme.of(context).textTheme.displaySmall,),
                      TextButton(onPressed: (){
                        Get.off(()=>LoginScreen(),transition: Transition.cupertino);
                      }, child: const Text("Login",style: TextStyle(fontWeight: FontWeight.bold),),),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _pickImagefromGallery() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imagefile=File(file!.path);
    });
  }
}
