import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kuclasspreview/constants.dart';

import '../models/intro_model.dart';

class IntroProvider {
  DocumentReference<Intro> introRef = FirebaseFirestore.instance
      .collection(FirebaseConstants.intro)
      .doc(FirebaseConstants.intro)
      .withConverter<Intro>(
        fromFirestore: (snapshot, _) => Intro.fromJson(snapshot.data()!),
        toFirestore: (Intro, _) => Intro.toJson(),
      );

  Future<Intro> getIntro() async {
    DocumentSnapshot<Intro> documentSnapshot = await introRef.get();
    return documentSnapshot.data() ??
        Intro(intro: "", notice: "", updateAt: "");
  }
}
