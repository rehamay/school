import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:school/school/signinschool.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_states.dart';
import '../users_schools.dart';


class SignUpschool extends StatefulWidget {
  @override
  State<SignUpschool> createState() => _SignUpschoolState();
}

class _SignUpschoolState extends State<SignUpschool> {
  late RegisterCubit registerCubit;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is RegisterSuccess){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignInSchool(),
              ),
            );
          }
        },
        builder: (context, state) {
          registerCubit = RegisterCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent, // Make app bar background transparent
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserSchool(),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_circle_left_outlined),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 35, right: 25, top: 10),
                child: Column(
                  //logo
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ConditionalBuilder(
                          condition: state is! UploadImageRegisterLoading,
                          builder: (context) => GestureDetector(
                            onTap: () {
                              registerCubit.uploadImage();
                            },
                            child: registerCubit.url == null ? SvgPicture.asset(
                              "images/profilePicture.svg",
                              color: Colors.grey.withOpacity(.5),
                              width: 80,
                              height: 80,
                            ) : Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage('${registerCubit.url}')
                                  )
                              ),
                            ),
                          ),
                          fallback: (context) => const Center(child: CircularProgressIndicator(),),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    //sign in!
                    const Text(
                      '-----------  Sign up!  -----------',
                      style: TextStyle(fontSize: 25, color: Colors.blue),
                    ),

                    // school Name
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, top: 30),
                        child: Text(
                          'School Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7F8F9),
                                border: Border.all(
                                  color: const Color(0xFFE8ECF4),
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: TextFormField(
                                  controller: schoolNameController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    border: InputBorder.none,
                                    hintText: 'Enter your school name',
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

                    //email
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          'Email',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7F8F9),
                                border: Border.all(
                                  color: const Color(0xFFE8ECF4),
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.email_outlined),
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

                    // Last Name
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          'Location',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7F8F9),
                                border: Border.all(
                                  color: const Color(0xFFE8ECF4),
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: TextFormField(
                                  controller: locationController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.location_on_outlined),
                                    border: InputBorder.none,
                                    hintText: 'Enter your location',
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

                    // Nationality
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          'phone number',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7F8F9),
                                border: Border.all(
                                  color: const Color(0xFFE8ECF4),
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: phoneController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.phone),
                                    border: InputBorder.none,
                                    hintText: 'Enter your phone number',
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

                    // Email

                    // Password
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          'Password',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7F8F9),
                                border: Border.all(
                                  color: const Color(0xFFE8ECF4),
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: TextFormField(
                                  obscureText: true,
                                  controller: passwordController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.lock_open_outlined),
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

                    // Confirm Password
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          'Confirm Password',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7F8F9),
                                border: Border.all(
                                  color: const Color(0xFFE8ECF4),
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.lock_open_outlined),
                                    border: InputBorder.none,
                                    hintText: 'Confirm your password',
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

                    //sign up button
                    ConditionalBuilder(
                        condition: state is !RegisterLoading,
                        builder: (context) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 60,
                            vertical: 50,
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
                                    registerCubit.createUser(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        urlImage: registerCubit.url ?? "",
                                        firstName: "",
                                        lastName: "",
                                        location: locationController.text.isNotEmpty ? locationController.text : "",
                                        phoneNumber: phoneController.text.isNotEmpty ? phoneController.text : "",
                                        schoolName: schoolNameController.text.isNotEmpty ? schoolNameController.text : "",
                                        context: context
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
                        fallback: (context) => const Center(child: CircularProgressIndicator())
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
