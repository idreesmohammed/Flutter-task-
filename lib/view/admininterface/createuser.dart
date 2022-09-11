import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertaskkssmart/model/createusermodel.dart';
import 'package:fluttertaskkssmart/view/admininterface/adminscreen.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import '../../constants/constantcolors.dart';
import '../../constants/constantvariables.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../controller/sharedpreferences.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  var dateController = TextEditingController();
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  List nameList = [];
  var adminId;
  var loop;
  var forLoopDatas;
  var dataName;
  bool isLoading = false;
  var allData;
  var dataLoop;
  final l = Logger();
  @override
  void initState() {
    adminCred();
    //fetchData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AdminScreen()));
        return Future.value(false);
      },
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: SingleChildScrollView(
            child: SizedBox(
              height: height,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: height * 0.23,
                    width: width,
                    child: const Text(
                      ConstantVariables.createUser,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    //color: Colors.red,
                  ),
                  SizedBox(
                      height: height * 0.35,
                      width: width,
                      //color: Colors.blue,
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 25.0,
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
                                controller: passwordController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: ConstantVariables.password,
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
                                readOnly: true,
                                controller: dateController,
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          datePicking();
                                        },
                                        icon: const Icon(
                                            Icons.arrow_drop_down_outlined)),
                                    border: InputBorder.none,
                                    hintText: ConstantVariables.dateOfBirth,
                                    hintStyle: const TextStyle(
                                        color: ConstantColors.black,
                                        fontWeight: FontWeight.w500),
                                    filled: true,
                                    fillColor: ConstantColors.grey),
                              )),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20.0),
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
                            width: width * 0.72,
                            child: TextButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            ConstantColors.black)),
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  if (userNameController.text.isEmpty ||
                                      passwordController.text.isEmpty ||
                                      dateController.text.isEmpty) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    const snackBar = SnackBar(
                                      content: Text(
                                          ConstantVariables.createProjectError),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    const snackBar = SnackBar(
                                      content: Text(ConstantVariables
                                          .createdSuccessfully),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    await createUser(
                                        name: userNameController.text,
                                        password: passwordController.text,
                                        date: dateController.text,
                                        nameList: nameList,
                                        context: context);
                                    setState(() {
                                      isLoading = false;
                                    });
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
      ),
    );
  }

  datePicking() async {
    var dateFormat = DateFormat('yyyy-MM-dd');
    var todaysDate = DateTime.now();
    var date = await showDatePicker(
        context: context,
        initialDate: todaysDate,
        firstDate: DateTime(2000, 8),
        lastDate: todaysDate);
    if (date == null) return;
    setState(() {
      dateController.text = dateFormat.format(date);
    });
  }

//   LocalStore()..then((value) async {
//   await value.setString('items', storingUid);
// });
  adminCred() async {
    await LocalStore().localStoreForAdmin().then((value) {
      setState(() {
        adminId = value.getString('admin');
      });
    });
  }

  Future createUser({name, password, date, nameList, context}) async {
    final documentUser = FirebaseFirestore.instance.collection('users').doc();
    final user = CreateUserModel(
        id: documentUser.id, name: name, password: password, dateOfBirth: date);
    final json = user.toJson();

    if (nameList.contains(name)) {
      const snackBar = SnackBar(
        content: Text(ConstantVariables.userAddedSuccessfully),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      const snackBar = SnackBar(
        content: Text(ConstantVariables.userAddedSuccessfully),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      await documentUser.set(json);
      await Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const AdminScreen()));
    }
  }
}
