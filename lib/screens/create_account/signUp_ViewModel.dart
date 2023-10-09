import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/base.dart';
import 'package:todo/firebase/firebase_functions.dart';
import 'package:todo/models/user_model.dart';
import 'package:todo/screens/create_account/signUp_connector.dart';

class SignUpViewModel extends BaseViewModel<SignUpConnector> {

  void createAccount(String name, String email, String password, String birthday, Function created) async{
    try {
      connector!.showLoading("");
      var credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userModel = UserModel(
          id: credential.user!.uid,
          name: name,
          birthday: birthday,
          email: email);
      connector!.hideDialog();
      FirebaseFunctions.addUserToFirestore(userModel).then((value) {
        created();
        connector!.goToHome();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        connector!.showMessage(e.message??"");
      } else if (e.code == 'email-already-in-use') {
        connector!.showMessage(e.message??"");
      }
    } catch (e) {
      connector!.showMessage(e.toString());
    }
  }
}