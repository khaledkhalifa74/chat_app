import 'package:chat_firebase/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_firebase/blocs/auth_bloc/auth_event.dart';
import 'package:chat_firebase/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_firebase/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_firebase/helper/showSnackBar.dart';
import 'package:chat_firebase/screens/chat_screen.dart';
import 'package:chat_firebase/screens/register_screen.dart';
import 'package:chat_firebase/widgets/custom_button.dart';
import 'package:chat_firebase/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../blocs/auth_bloc/auth_state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static String id = 'LoginScreen';
  bool isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, ChatScreen.id);
          isLoading = false;
        } else if (state is LoginFailure) {
          showSnackBar(context, state.errorMessage);
          isLoading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: const Color(0xff2B475E),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'LOGIN',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFormField(
                      controller: emailController,
                      // onChanged: (data) {
                      //   email = data;
                      // },
                      hintText: 'Email address',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFormField(
                      controller: passwordController,
                      // onChanged: (data) {
                      //   password = data;
                      // },
                      hintText: 'Password',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                              email: emailController.text.toString(),
                              password: passwordController.text.toString(),
                          ));
                        } else {}
                      },
                      text: 'LOGIN',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'don\'t have an account ?',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterScreen.id);
                          },
                          child: const Text(
                            '  Register',
                            style: TextStyle(
                              color: Color(0xffC7EDE6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
