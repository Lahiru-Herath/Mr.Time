import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // GOOGLE SIGN IN
  signInWithGoogle() async {
    // BEGIN INTERACTIVE SIGN IN PROCESS
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // OBTAIN AUTH DETAILS FROM REQUEST
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // CREATE A NEW CREDENTIAL FOR USER
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // SIGNING IN
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
