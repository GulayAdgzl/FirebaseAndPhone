import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:map/map.dart';

class FireBase extends StatefulWidget {
  const FireBase({Key? key, required String title}) : super(key: key);
  @override
  State<FireBase> createState() => _FireBaseState();
}

class _FireBaseState extends State<FireBase> {
  final _fireStore = FirebaseFirestore.instance;
  List _found = [];

  Future getDocName() async {
    await FirebaseFirestore.instance
        .collection('Phone')
        .orderBy('name', descending: true)
        .get()
        .then((search) => search.docs.forEach((document) {
              print(document.reference);
              _found.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference phoneRef = _fireStore.collection('Phone');
    var oneRef = phoneRef.doc('1');

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 217, 154, 154),
        title: Container(
          height: 38,
          child: TextField(
            onChanged: (value) => getDocName(),
            decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 109, 10, 10),
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 78, 195, 129),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none),
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                hintText: "Search users"),
          ),
        ),
      ),
      body: Container(
        child: Column(children: [
          StreamBuilder<QuerySnapshot>(

              //neyi dinlediğimizi,hangi streami
              stream: phoneRef.snapshots(),
              //Streamden her yeni veri aktığında,aşağıdaki metodu çalıştır

              builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
                if (asyncSnapshot.hasError) {
                  return Center(child: Text('Bir hata oluştuu'));
                } else {
                  if (asyncSnapshot.hasData) {
                    List<DocumentSnapshot> listSnap = asyncSnapshot.data.docs;
                    // List<DocumentSnapshot> _found = [];
                    return Flexible(
                      child: ListView.builder(
                          itemCount: listSnap.length,
                          itemBuilder: (context, index) {
                            //var currentPerson = asyncSnapshot.data[index];

                            return Card(
                              child: ListTile(
                                //title: Text('${listSnap[index]}'),
                                title: Text('${listSnap[index]['name']}' +
                                    '' +
                                    '${listSnap[index]['Surname']}'),
                                leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        '${listSnap[index]['avatar']}')),

                                //subtitle: Text(currentPerson.Surname),
                              ),
                            );
                          }

                          /* children: asyncSnapshot.data.documents
                        .map((doc) => ListTile(
                              title: Text(doc['name']),
                              subtitle: Text(doc['Surname']),
                            ))
                        .toList(),*/
                          ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }
              }

              /*return Text(
                    '${asyncSnapshot.data.data()}',
                    style: TextStyle(fontSize: 24),
                  );*/

              )
        ]),
      ),
    );
  }
}
