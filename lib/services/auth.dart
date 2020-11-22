import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spent_share/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  // user objectbased on google user

  AppUser _appUserFromGoogleUser(User user){
      return user != null ? AppUser(uid: user.uid, displayName: user.displayName, email: user.email) : null;
  }

  //auth change user stream
  Stream<AppUser> get user {
    return _auth.authStateChanges()
    //.map((User user) => _appUserFromGoogleUser(user));
    .map(_appUserFromGoogleUser);
  }

  Future signInGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn().catchError((onError) => print(onError));
      
      if(googleSignInAccount == null)
        return null;

      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User user = authResult.user;

      if (user != null) {
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        final User currentUser = _auth.currentUser;
        assert(user.uid == currentUser.uid);

        print('signInWithGoogle succeeded: $user');



        return _appUserFromGoogleUser(user); //'$user';
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  //sign in with google

  //sign out
  Future<void> signOutGoogle() async {
    try{
      await googleSignIn.signOut();
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}
