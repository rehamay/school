import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school/school/signinschool.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_states.dart';
import 'forget2.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({super.key});

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  late RegisterCubit registerCubit;
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is ResetPasswordSuccess){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> SignInSchool()));
          }
        },
        builder: (context, state) {
          registerCubit = RegisterCubit.get(context);
          return Scaffold(
            extendBodyBehindAppBar: true, // Extend body behind the app bar
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent, // Make app bar background transparent
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPass(),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_circle_left_outlined),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 100),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 80, right: 80, top: 30),
                      child: Image(image: AssetImage('images/logo2.png')),
                    ),
                    const SizedBox(height: 30),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '--------- Reset Password ---------',
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Email
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 40),
                        child: Text(
                          'Email',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7F8F9),
                                border: Border.all(color: const Color(0xFFE8ECF4)),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.email_outlined),
                                    suffix: Icon(Icons.email, color: Color(0xFF8391A1)),
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
                    const SizedBox(height: 30),
                    // Send Password Reset Button
                    ConditionalBuilder(
                        condition: state is !ResetPasswordLoading,
                        builder: (context) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: MaterialButton(
                            color: const Color(0XFFCDDDF9),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                            onPressed: () {
                              registerCubit.sendCodeResetPassword(context: context, email: emailController.text);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "Send Password Reset",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        fallback: (context) => const Center(child: CircularProgressIndicator(),)
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
