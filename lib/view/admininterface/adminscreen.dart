import 'package:flutter/material.dart';
import 'package:fluttertaskkssmart/view/loginscreen.dart';
import '../../constants/constantcolors.dart';
import '../../constants/constantvariables.dart';
import 'createproject.dart';
import 'createuser.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  bool radioButtonColor = false;
  bool radioButtonColor2 = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        showAlertDialog(context);
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
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
                        SizedBox(
                          height: height * 0.1,
                          width: width * 0.75,
                          //color: Colors.grey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: width * 0.1,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    radioButtonColor = true;
                                    radioButtonColor2 = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: ConstantColors.black,
                                          width: 3.0)),
                                  child: CircleAvatar(
                                    radius: 7,
                                    backgroundColor: radioButtonColor == true
                                        ? ConstantColors.blue
                                        : ConstantColors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.05,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    radioButtonColor = true;
                                    radioButtonColor2 = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  alignment: Alignment.centerLeft,
                                  height: height * 0.08,
                                  width: width * 0.4,
                                  color: ConstantColors.grey,
                                  child: const Text(
                                    ConstantVariables.createUser,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.1,
                          width: width,
                          //color: Colors.grey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: width * 0.1,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    radioButtonColor2 = true;
                                    radioButtonColor = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: ConstantColors.black,
                                          width: 3.0)),
                                  child: CircleAvatar(
                                    radius: 7,
                                    backgroundColor: radioButtonColor2 == true
                                        ? ConstantColors.blue
                                        : ConstantColors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.05,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    radioButtonColor2 = true;
                                    radioButtonColor = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  alignment: Alignment.centerLeft,
                                  height: height * 0.08,
                                  width: width * 0.4,
                                  color: ConstantColors.grey,
                                  child: const Text(
                                      ConstantVariables.createProject,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 70.0, top: 20.0, left: 70.0),
                  child: SizedBox(
                    height: height * 0.33,
                    width: width,
                    //color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.07,
                          width: width * 0.6,
                          child: TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          ConstantColors.black)),
                              onPressed: () {
                                if (radioButtonColor == true) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CreateUser()));
                                } else if (radioButtonColor2 == true) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CreateProject()));
                                } else {
                                  const snackBar = SnackBar(
                                    content:
                                        Text(ConstantVariables.errorMessage),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              child: const Text(
                                ConstantVariables.submit,
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
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget confirmButton = TextButton(
      child: const Text(ConstantVariables.confirm),
      onPressed: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      },
    );
    Widget cancelButton = TextButton(
      child: const Text(ConstantVariables.cancel),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text(ConstantVariables.alert),
      content: const Text(
        "Are you sure you need Navigate to Home screen?",
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      actions: [confirmButton, cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
