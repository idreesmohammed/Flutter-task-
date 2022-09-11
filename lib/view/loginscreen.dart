import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertaskkssmart/constants/constantcolors.dart';
import 'package:fluttertaskkssmart/constants/constantvariables.dart';
import 'package:fluttertaskkssmart/controller/sharedpreferences.dart';
import 'package:logger/logger.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'admininterface/adminscreen.dart';
import 'userinterface/userscreen.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var allData;
  var storingUid;
  bool hidePassword = true;
  List nameList = [];
  final l = Logger();
  List valuForuId = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: SingleChildScrollView(
            child: SizedBox(
              height: height,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.40,
                    width: width,
                    //color: Colors.red,
                  ),
                  SizedBox(
                      height: height * 0.24,
                      width: width,
                      //color: Colors.blue,
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 40.0,
                                  left: 20.0,
                                  right: 20.0,
                                  bottom: 20.0),
                              child: TextFormField(
                                controller: userNameController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: ConstantVariables.userName,
                                    hintStyle: TextStyle(
                                        color: ConstantColors.black,
                                        fontWeight: FontWeight.w500),
                                    filled: true,
                                    fillColor: ConstantColors.grey),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  left: 20.0,
                                  right: 20.0,
                                  bottom: 20.0),
                              child: TextFormField(
                                obscureText: hidePassword,
                                controller: passwordController,
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            hidePassword = !hidePassword;
                                          });
                                        },
                                        icon: Icon(
                                          hidePassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: ConstantColors.black,
                                        )),
                                    border: InputBorder.none,
                                    hintText: ConstantVariables.password,
                                    hintStyle: const TextStyle(
                                        color: ConstantColors.black,
                                        fontWeight: FontWeight.w500),
                                    filled: true,
                                    fillColor: ConstantColors.grey),
                              )),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, top: 20.0),
                    child: SizedBox(
                      height: height * 0.33,
                      width: width,
                      //color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * 0.07,
                            width: width * 0.5,
                            child: TextButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black)),
                                onPressed: () {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  // print(nameList);
                                  if (userNameController.text.isEmpty ||
                                      passwordController.text.isEmpty) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    const snackBar = SnackBar(
                                      content:
                                          Text(ConstantVariables.errorMessage),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else if (valuForuId
                                      .contains(passwordController.text)) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  } else if (userNameController.text ==
                                          ConstantVariables.adminId &&
                                      passwordController.text ==
                                          ConstantVariables.adminPassword) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    const snackBar = SnackBar(
                                      content:
                                          Text(ConstantVariables.loginSuccess),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AdminScreen()));
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    //justCheck();
                                    filerFun();
                                  }
                                },
                                child: const Text(
                                  ConstantVariables.login,
                                  style: TextStyle(color: ConstantColors.white),
                                )),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  filerFun() async {
    final CollectionReference _collection =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = await _collection
        .where('password', isEqualTo: passwordController.text)
        .get();
    allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    l.w(allData);
    if (allData == [] || allData == null || allData.isEmpty) {
      const snackBar = SnackBar(
        content: Text(ConstantVariables.invalid),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      setState(() {
        storingUid = allData[0]['id'];
      });
      const snackBar = SnackBar(
        content: Text(ConstantVariables.loginSuccess),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      l.e("hello");
      LocalStore().localStorage().then((value) async {
        await value.setString('items', storingUid);
      });

      await Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const UserScreen()));
    }
  }
}
