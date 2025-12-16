import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /* ----------------------------------------------------
   🔹 REGISTER WITH EMAIL + ROLE + SEND VERIFICATION
  ---------------------------------------------------- */
  Future<User?> registerWithEmail({
    required String email,
    required String password,
    required String role, // super_admin | admin | student
  }) async {
    try {
      final UserCredential credential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = credential.user;

      if (user != null) {
        // Send verification email
        if (!user.emailVerified) {
          await user.sendEmailVerification();
        }

        // Save user profile & role in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'email': email,
          'role': role,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return user;
    } catch (e) {
      rethrow;
    }
  }

  /* ----------------------------------------------------
   🔹 LOGIN WITH EMAIL (ONLY IF VERIFIED)
  ---------------------------------------------------- */
  Future<User?> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential credential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = credential.user;

      if (user == null) return null;

      // ❌ Block login if email not verified
      if (!user.emailVerified) {
        await _auth.signOut();
        throw FirebaseAuthException(
          code: 'email-not-verified',
          message: 'Please verify your email before login.',
        );
      }

      return user;
    } catch (e) {
      rethrow;
    }
  }

  /* ----------------------------------------------------
   🔹 GOOGLE SIGN-IN (AUTO STUDENT ROLE)
  ---------------------------------------------------- */
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser =
          await _googleSignIn.signIn();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential =
          GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        // Check if user already exists in Firestore
        final doc =
            await _firestore.collection('users').doc(user.uid).get();

        if (!doc.exists) {
          // Default role = student
          await _firestore.collection('users').doc(user.uid).set({
            'email': user.email,
            'role': 'student',
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
      }

      return user;
    } catch (e) {
      rethrow;
    }
  }

  /* ----------------------------------------------------
   🔹 GET USER ROLE
  ---------------------------------------------------- */
  Future<String> getUserRole(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.data()?['role'] ?? 'student';
  }

  /* ----------------------------------------------------
   🔹 RESEND EMAIL VERIFICATION
  ---------------------------------------------------- */
  Future<void> resendVerificationEmail() async {
    final User? user = _auth.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  /* ----------------------------------------------------
   🔹 LOGOUT
  ---------------------------------------------------- */
  Future<void> logout() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
  /* ----------------------------------------------------
   🔹 CURRENT USER
  ---------------------------------------------------- */
  User? get currentUser => _auth.currentUser;
}
