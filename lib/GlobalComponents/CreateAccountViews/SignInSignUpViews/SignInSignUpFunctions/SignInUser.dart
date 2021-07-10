//
//
// Future<String> signInUser(_email, _password, key) async {
//   setState(() {
//     _errorMessage = '';
//     _isLoading = true;
//   });
//   if (validateAndSave(key)) {
//     String userId = '';
//     try {
//       userId = await widget.auth.signIn(_email, _password, context);
//       log('Signed in: $userId');
//       setState(() {
//         _isLoading = false;
//       });
//       if (userId.length > 0 && userId != null && _isLoginForm) {
// //          widget.loginCallback();
//
//         final User user = _auth.currentUser;
// //          widget.loginRequestName();
//
//         assert(user.uid == userId);
//
//         print('signInWithEmail succeeded: $user');
//
//         Navigator.pop(context);
//         return '$user';
//       }
//     } catch (e) {
//       log('Error: $e');
//       setState(() {
//         _isLoading = false;
//         _errorMessage = e.message;
//         _formKey.currentState.reset();
//       });
//     }
//   }
// }
//
// bool validateAndSave(_key) {
//   final form = _key.currentState;
//   if (form.validate()) {
//     form.save();
//     return true;
//   } else {
//     return false;
//   }
// }
//
// bool validateEmailAndSave(_key) {
//   final form = _key.currentState;
//   if (EmailValidator.validate(_email)) {
//     form.save();
//     return true;
//   } else {
//     return false;
//   }
// }
