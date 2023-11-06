import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task3/auth/singupscreen.dart';
import 'package:task3/controllers/loadingcontroller.dart';
import 'package:task3/screens/home.dart';
import 'package:task3/utils/mytextfield.dart';

class LoginScreen extends StatelessWidget {
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final loadingController = Get.put(LoadingController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                  SizedBox(height: height*0.325,),
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
                        onPressed: () async {
                          loadingController.loading.value=true;
                          await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text).then((value){
                            loadingController.loading.value=false;
                            Get.off(()=>Home());
                          }).onError((error, stackTrace){
                            loadingController.loading.value=false;
                            debugPrint("Kuch Gadbad hai Mere Dost");
                          });
                        },
                        child: loadingController.loading.value? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColorDark,)): const Text("Login"),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Dont Have A Account?",style: Theme.of(context).textTheme.displaySmall,),
                      TextButton(onPressed: (){
                        Get.off(()=>SignUpScreen(),transition: Transition.cupertino);
                      }, child: const Text("SignUp",style: TextStyle(fontWeight: FontWeight.bold),),),
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
}
