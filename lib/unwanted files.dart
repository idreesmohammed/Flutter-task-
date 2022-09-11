///deleted from login screen
// fetchData() async {
//   final QuerySnapshot result =
//       await FirebaseFirestore.instance.collection('users').get();
//   final List<DocumentSnapshot> documents = result.docs;
//   print('documents: {$documents}');
//   documents.forEach((element) {
//     print("document: ${element.data()}");
//   });
//   GetUserDetails().getData(allData: allData, loop: loop).then((value) {
//     l.w(value);
//     setState(() {
//       valuForuId = value;
//     });
//     l.e("hi");
//     l.w(valuForuId);
//     l.e("hi");
//     for (int i = 0; i < value.length; i++) {
//       setState(() {
//         print("hello");
//         l.w(value[i]["name"]);
//
//         forLoopDatas = value[i]["name"];
//         dataLoop = value[i]['name'];
//         nameList.add(value[i]['name']);
//       });
//
//       // print();
//     }
//     l.w(nameList);
//     //print(name);
//   });
//   //await filerFun();
// }

// justCheck() async {
//   final CollectionReference _collection =
//       FirebaseFirestore.instance.collection('users');
//   var query = await _collection
//       .where('password', isEqualTo: passwordController.text.toString())
//       .get();
//   print(query.docs.map((doc) => doc.data()).toList());
//   //.getDocuments();
//   // print(_collection
//   //     .where('password', isEqualTo: passwordController.text)
//   //     .get()
//   //     .docs
//   //     .map((doc) => doc.data())
//   //     .toList());
// }
// if (userNameController.text ==
//         ConstantVariables.adminId &&
//     passwordController.text ==
//         ConstantVariables.adminPassword) {
//   setState(() {
//     isLoading = true;
//   });
//   Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//           builder: (context) =>
//               const AdminScreen()));
// } else {
//   setState(() {
//     isLoading = true;
//   });
//   Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//           builder: (context) =>
//               const UserScreen()));
// }
/// deleted from create project
// for (int i = 0; i < value.length; i++) {
//   setState(() {
//     print("hello");
//     l.w(value[i]["name"]);
//
//     forLoopDatas = value[i]["name"];
//     dataLoop = value[i]['name'];
//     nameList.add(value[i]['name']);
//   });
//
//   // print();
// }
// l.w(nameList);
//print(name);
// for (int i = 0; i < chooseboard['result'].length; i++) {
//   items.add({
//     "value": chooseboard['result'][i]['board_id'],
//     "label": chooseboard['result'][i]['board']
//   });
//}
// for (int i = 0; i < chooseboard['result'].length; i++) {
// items.add({
// "value": chooseboard['result'][i]['board_id'],
// "label": chooseboard['result'][i]['board']
// });
// }
// createProjectPostMethod() async {
//   final CollectionReference _collection =
//       FirebaseFirestore.instance.collection('users');
//   QuerySnapshot querySnapshot = await _collection
//       .where('name', isEqualTo: nameController.text)
//       .get()
//       .then((snapShotsValue) {});

// FirebaseFirestore.instance
//     .collection('users')
//     .where('name', isGreaterThan: 20)
//     .get()
//     .then(...);
//}
// itemclass.clear();

// for (int i = 0; i < chooseclass['result'].length; i++) {
//   setState(() {
//     itemclass.add({
//       "value": chooseclass['result'][i]['class_id'],
//       "label": chooseclass['result'][i]['class']
//     });
//     l.wtf(chooseclass['result'][i]['class_id']);
//   });
// }
// final QuerySnapshot result =
// await FirebaseFirestore.instance.collection('users').get();
// final List<DocumentSnapshot> documents = result.docs;
// print('documents: {$documents}');
// documents.forEach((element) {
//   print("document: ${element.data()}");
// });
///deleted from create user
// Future createUser({name, password, date}) async {
//   final documentUser = FirebaseFirestore.instance.collection('users').doc();
//   final user = CreateUserModel(
//       id: documentUser.id, name: name, password: password, dateOfBirth: date);
//   final json = user.toJson();
//   if (loop["name"] == name) {
//     print("Not correct");
//   } else {
//     await documentUser.set(json);
//   }
// }

// final CollectionReference _collectionRef =
//     FirebaseFirestore.instance.collection('users');
// Future<void> getData() async {
//   QuerySnapshot querySnapshot = await _collectionRef.get();
//   allData = querySnapshot.docs.map((doc) => doc.data()).toList();
//   l.w(allData);
//   for (int i = 0; i < allData.length; i++) {
//     setState(() {
//       loop = allData[i];
//     });
//     hello.add(loop);
//     l.w("kk");
//     print(loop);
//     l.w("kk");
//   }
// }
// await AuthendicationServ().createUser(
//     name: userNameController.text,
//     password: passwordController.text,
//     dateOfBirth: dateController.text,
//     context: context);

// setState(() {
//   isLoading = true;
// });

// await createUser(
//     name: userNameController.text,
//     password: passwordController.text,
//     date: dateController.text);
// fetchData() async {
//   GetUserDetails().getData(allData: allData, loop: loop).then((value) {
//     l.w(value);
//
//     for (int i = 0; i < value.length; i++) {
//       setState(() {
//         print("hello");
//         l.w(value[i]["name"]);
//
//         forLoopDatas = value[i]["name"];
//         dataLoop = value[i]['name'];
//         nameList.add(value[i]['name']);
//       });
//
//       // print();
//     }
//     l.w(nameList);
//     //print(name);
//   });
// }
