import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/parent/registerscreen.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_states.dart';
import '../users_schools.dart';
import 'forgetpass.dart';
import 'home_page_parent.dart';

class SignIn extends StatelessWidget {
  late RegisterCubit registerCubit;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is LoginSuccess){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Home_Page_Parent(),
              ),
            );
          }
        },
        builder: (context, state) {
          registerCubit = RegisterCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              // Make app bar background transparent
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserSchool(),
                    ),
                  );
                },
                icon: Icon(Icons.arrow_circle_left_outlined),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 35, right: 25, top: 10),
                child: Column(
                  //logo
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 80, right: 80, top: 0),
                      child: Image(image: AssetImage('images/logo2.png')),
                    ),

                    //sign in!
                    Text(
                      '-----------  Sign in!  -----------',
                      style: TextStyle(fontSize: 25, color: Colors.blue),
                    ),

                    //email
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 30),
                        child: Text(
                          'Email',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          //email
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7F8F9),
                                border: Border.all(
                                  color: const Color(0xFFE8ECF4),
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.email_outlined),
                                    suffix: Icon(
                                      Icons.email,
                                      color: Color(0xFF8391A1),
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Enter your email',
                                    hintStyle: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Color(0XFFCDDDF9),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Password ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          //email
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 10,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7F8F9),
                                border: Border.all(
                                  color: const Color(0xFFE8ECF4),
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                child: TextFormField(
                                  obscureText: true,
                                  controller: passwordController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.lock_open_outlined),
                                    suffix: Icon(
                                      Icons.remove_red_eye,
                                      color: Color(0xFF8391A1),
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Enter your password',
                                    hintStyle: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Color(0XFFCDDDF9),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //forgot password
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ResetPass(),
                              ),
                            );
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ),

                    //sign in button
                    ConditionalBuilder(
                      condition: state is !LoginLoading,
                      builder: (context) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: MaterialButton(
                                color: const Color(0xFFEFAEAC),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                onPressed: () {
                                  registerCubit.loginUser(emailController.text, passwordController.text, context);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    "Sign in",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      fallback: (context) => const Center(child: CircularProgressIndicator(),),
                    ),

                    //sign up button
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                              color: const Color(0XFFCDDDF9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUp(),
                                  ),
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                  "sign up",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
