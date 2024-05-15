
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChannelCubit extends Cubit<List<String>> {
  ChannelCubit(String tur,String kanal) : super([]) {
    channelDoc = FirebaseFirestore.instance.collection('oyun').doc(tur).collection(kanal).doc('oyuncular');

    channelDoc.snapshots().listen((event) {
      List cartArray = event.data()?['player'] ?? [];
      emit([...cartArray]);
    });
  }

  late DocumentReference<Map<String, dynamic>> channelDoc;

  Future<void> channelEkleCikar(String uid) async {
    channelDoc.update({
      'player': state.contains(uid)
          ? FieldValue.arrayRemove([uid])
          : FieldValue.arrayUnion([uid])
    });
  }
}
