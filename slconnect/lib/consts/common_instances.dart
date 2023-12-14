import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;
Future<SharedPreferences> prefs = SharedPreferences.getInstance();
const oneSignalAppId = "05849719-1b2a-453c-a8d7-981308d70e22";
