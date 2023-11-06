import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRoom extends StatelessWidget{

  final message = TextEditingController();
  String oppusername;
  final chatroomid;
  ChatRoom({required this.chatroomid,required this.oppusername});
  @override
  Widget build(BuildContext context) {
    TextAlign alignment;
    List chatlist=[];
    final height = MediaQuery.of(context).size.height;
    final _auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(oppusername),
        actions: [
          IconButton(onPressed:() async {
            await FirebaseFirestore.instance.collection('Chats').doc(chatroomid).delete();
            Get.back();
          },icon: Icon(Icons.delete),),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Chats").doc(chatroomid).snapshots(),
              builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator());
                }
                else if(!snapshot.data!.exists)
                {
                  return const Center(child: Text("No Chats"));
                }
                else{
                  print(snapshot.data!.data());
                  chatlist=snapshot.data!.data()![chatroomid];
                  return ListView.builder(reverse: true,padding: const EdgeInsets.symmetric(horizontal: 10),physics: const BouncingScrollPhysics(),itemCount: chatlist.length,itemBuilder: (context,index){
                    return Card(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: chatlist[index]['sentby']==_auth.currentUser!.displayName.toString() ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            Text(chatlist[index]['sentby'],style: Theme.of(context).textTheme.titleMedium),
                            Text(chatlist[index]['message'],style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ),
                    );
                  });
                }
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(height*0.01),
            height: height*0.1,
            child: Row(
              children: [
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: message,
                    decoration: InputDecoration(
                      hintText: "Enter Message",
                    ),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                )),
                IconButton(onPressed: (){
                  chatlist.add({
                    'message':message.text,
                    'sentby':_auth.currentUser!.displayName.toString(),
                    'reciever':oppusername,
                  });
                  FirebaseFirestore.instance.collection("Chats").doc(chatroomid).set({
                    chatroomid:chatlist,
                  }).onError((error, stackTrace){
                    print(error.toString());
                  });
                  message.clear();
                }, icon: Icon(Icons.send),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}