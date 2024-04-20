import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../core/widget/snac_bar.dart';
import 'login_states.dart';
import 'dart:io';
import 'package:path/path.dart';

class RegisterCubit extends Cubit <RegisterStates>{
  RegisterCubit() : super(InitialLoginState());
  static RegisterCubit get(context) => BlocProvider.of(context);
//////////////////////////////////////////////////////////////////////////////
  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential? userCredentialRegister;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  createUser({email, password, context, urlImage, firstName, lastName, location, schoolName, phoneNumber}) async {
    emit(RegisterLoading());
    userCredentialRegister = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      defaultSnackBar(
          context: context,
          color: Colors.green,
          text: 'Your Email is Generated successfully');
      users.doc(FirebaseAuth.instance.currentUser?.uid).set({
        'urlImage': urlImage,
        'emailAddress': email,
        'firstName': firstName,
        'lastName': lastName,
        'password': password,
        'location': location,
        'schoolName': schoolName,
        'phoneNumber': phoneNumber,
        'uid': FirebaseAuth.instance.currentUser?.uid,
      });
      emit(RegisterSuccess());
    }).catchError((e){
      print('error is ${e.toString()}');
      emit(RegisterError(e.toString()));
    });
  }
/////////////////////////////////////////////////////////////////////////////////////////// login
  UserCredential? userCredentialLogin;
  loginUser( String email, String password, BuildContext context ) async {
    emit(LoginLoading());
    userCredentialLogin = await auth.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      defaultSnackBar(text: 'Login Successfully' , context: context , color: Colors.green);
      emit(LoginSuccess());
    }).catchError((error){
      defaultSnackBar(text: error.toString(), context: context,color: Colors.red);
      emit(LoginError(error.toString())
      );
    });
  }
/////////////////////////////////////////////////////////////////////////////////////////// upload image
  File? file;
  var imagePicker = ImagePicker();
  String? url;
  uploadImage() async {
    emit(UploadImageRegisterLoading());
    try {
      XFile? imgPicked = await imagePicker.pickImage(source: ImageSource.gallery);
      var nameImage = basename(imgPicked!.path);
      if (imgPicked != null) {
        file = File(imgPicked.path);
        var random = Random().nextInt(10000);
        nameImage = '$random$nameImage';
        var refStorage = FirebaseStorage.instance.ref("images/$nameImage");
        await refStorage.putFile(file!);
        url = await refStorage.getDownloadURL();
      }
      emit(UploadImageRegisterSuccess());
    } catch (e) {
      debugPrint('error is $e');
      emit(UploadImageRegisterError());
    }
  }
/////////////////////////////////////////////////////////////////////////////////////////// forget password
  Future sendCodeResetPassword({email, context}) async {
    emit(ResetPasswordLoading());
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      defaultSnackBar(text: 'Reset password link sent to your email, please check it' , context: context , color: Colors.red);
      emit(ResetPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      defaultSnackBar(text: e.message!.toString() , context: context , color: Colors.red);
      emit(ResetPasswordError());
    }
  }
/////////////////////////////////////////////////////////////////////////////////////////// get profile data
  Map<String, dynamic> profileData = {};
  getProfileData() async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    emit(GetProfileDataLoading());
    await fireStore.collection('users').where('emailAddress' , isEqualTo: FirebaseAuth.instance.currentUser?.email).get().then((value) {
      if (profileData == {}) {
        profileData = value.docs[0].data();
      } else {
        profileData = {};
        profileData = value.docs[0].data();
      }
      if (kDebugMode) {print(profileData);}
      emit(GetProfileDataSuccess());
    }).catchError((error) {
      if (kDebugMode) {print("error search = $error");}
      emit(GetProfileDataError());
    });
    return profileData;
  }
}