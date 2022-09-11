import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertaskkssmart/controller/sharedpreferences.dart';
import 'package:fluttertaskkssmart/view/userinterface/userscreen.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import '../../constants/constantcolors.dart';
import '../../constants/constantvariables.dart';

class MyBio extends StatefulWidget {
  const MyBio({Key? key}) : super(key: key);

  @override
  State<MyBio> createState() => _MyBioState();
}

class _MyBioState extends State<MyBio> {
  var dateController = TextEditingController();
  var allData;
  var uid;
  var forLoopDatas;
  var loop;
  var dataLoop;
  List nameList = [];
  var l = Logger();
  @override
  void initState() {
    //fetchData();
    getCredentials();
    //getDetailsFromUid();
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
            MaterialPageRoute(builder: (context) => const UserScreen()));
        return Future.value(false);
      },
      child: Scaffold(
        body: uid == null || uid.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
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
                          ConstantVariables.myBio,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        //color: Colors.red,
                      ),
                      SizedBox(
                          height: height * 0.35,
                          width: width,
                          //color: Colors.blue,
                          child: Column(
                            children: [
                              customBox(
                                  hintText: "${ConstantVariables.userName} - " +
                                      allData[0]['name']),
                              customBox(
                                  hintText: "${ConstantVariables.password} - " +
                                      allData[0]['password']),
                              customBox(
                                  hintText:
                                      "${ConstantVariables.dateOfBirth} - " +
                                          allData[0]['dateOfBirth']),
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
                                                borderRadius:
                                                    BorderRadius.zero)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.black)),
                                    onPressed: () {
                                      getDetailsFromUid();
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const UserScreen()));
                                    },
                                    child: const Text(
                                      ConstantVariables.submit,
                                      style: TextStyle(
                                          color: ConstantColors.white),
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

  Padding customBox({hintText}) {
    return Padding(
        padding: const EdgeInsets.only(
            top: 25.0, left: 20.0, right: 20.0, bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: const TextStyle(
                      color: ConstantColors.black, fontWeight: FontWeight.w500),
                  filled: true,
                  fillColor: ConstantColors.grey),
            )
          ],
        ));
  }

  datePicking() async {
    var dateFormat = DateFormat('yyyy-MM-dd');
    var todaysDate = DateTime.now();
    var date = await showDatePicker(
        context: context,
        initialDate: todaysDate,
        firstDate: DateTime(2000, 8),
        lastDate: DateTime(todaysDate.year + 5));
    if (date == null) return;
    setState(() {
      dateController.text = dateFormat.format(date);
    });
  }

  getCredentials() async {
    await LocalStore().localStorage().then((value) {
      uid = value.getString('items');
      l.i(uid);
    });
    await getDetailsFromUid();
  }

  getDetailsFromUid() async {
    final CollectionReference _collection =
        FirebaseFirestore.instance.collection('users');
    var querySnapshot = await _collection.where('id', isEqualTo: uid).get();

    setState(() {
      allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    });
    // var dat =Text(allData.tostring().replaceAll('[]\\,\\', '')

    l.e(allData);
  }
}
