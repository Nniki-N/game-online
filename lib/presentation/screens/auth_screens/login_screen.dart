import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game/common/navigation/app_router.gr.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:game/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:game/presentation/constants/colors_constants.dart';
import 'package:game/presentation/screens/auth_screens/login_form_separator.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_icon_outlined_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_outlined_button.dart';
import 'package:game/presentation/widgets/custom_buttons/custom_text_button.dart';
import 'package:game/presentation/widgets/fields/custom_field.dart';
import 'package:game/presentation/widgets/texts/custom_text.dart';
import 'package:game/resources/resources.dart';

// class LogInScreen extends StatelessWidget {
//   const LogInScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final emailController = TextEditingController(text: 'user1@gmail.com');
//     final passwordController = TextEditingController(text: '12345678');
//
//     return Scaffold(
//       body: BlocConsumer<AuthBloc, AuthState>(
//         listener: (content, state) {
//           // shows loading
//           if (state is LoadingAuthState) {
//             log('login ------------------ show loading');
//             LoadingOverlay.instance().show(
//               title: null,
//               context: context,
//               text: 'Loading...',
//             );
//           } else {
//             log('login ------------------ hide loading');
//             LoadingOverlay.instance().hide();
//           }
//
//           // displays an error message if an error accurs
//           final authError = state.error;
//           if (authError != null) {
//             log('error login');
//             showNotificationDialog(
//               context: content,
//               dialogTitle: authError.errorTitle,
//               dialogContent: authError.errorText,
//               buttonText: 'Ok',
//             );
//           }
//
//           // navigates to the main screen if the user is logged in
//           if (state is LoggedInAuthState) {
//             log('login ------------------ go to main');
//             // LoadingOverlay.instance().hide();
//             AutoRouter.of(context).replace(const MainRouter());
//           }
//         },
//         builder: (context, state) {
//           // if (state is LoadingAuthState) {
//           //   return const LoadingScreen();
//           // }
//
//           return Center(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text('Log in'),
//                       TextButton(
//                         onPressed: () {
//                           log('login ------------------ go to registration');
//                           AutoRouter.of(context)
//                               .replace(const RegistrationRouter());
//                         },
//                         child: const Text('Register'),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   TextField(
//                     controller: emailController,
//                     decoration: const InputDecoration(hintText: 'Email'),
//                   ),
//                   const SizedBox(height: 20),
//                   TextField(
//                     controller: passwordController,
//                     decoration: const InputDecoration(hintText: 'Password'),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       log('login ------------------ log in button');
//                       final email = emailController.text.trim();
//                       final password = passwordController.text.trim();
//
//                       if (email.isNotEmpty && password.isNotEmpty) {
//                         context.read<AuthBloc>().add(
//                               LogInAuthEvent(
//                                 email: email,
//                                 password: password,
//                               ),
//                             );
//                       }
//                     },
//                     child: const Text('Log in'),
//                   ),
//                   const SizedBox(height: 20),
//                   const Divider(),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       context
//                           .read<AuthBloc>()
//                           .add(const LogInAnonymouslyAuthEvent());
//                     },
//                     child: const Text('Log in anonymously'),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       context
//                           .read<AuthBloc>()
//                           .add(const LogInWithGoogleAuthEvent());
//                     },
//                     child: const Text('Log in with Google'),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Sign in',
                      fontSize: 27.sp,
                      color: CustomColors.mainTextColor,
                    ),
                    CustomTextButton(
                      text: 'Register',
                      onTap: () {
                        log('signin ------------------ go to registration');
                        AutoRouter.of(context)
                            .replace(const RegistrationRouter());
                      },
                    ),
                  ],
                ),
                SizedBox(height: 35.h),
                CustomField(
                  controller: emailController,
                  hintText: 'Email',
                ),
                SizedBox(height: 20.h),
                CustomField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  text: 'Sign in',
                  onTap: () {
                    log('signin ------------------ log in button');
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();

                    if (email.isNotEmpty && password.isNotEmpty) {
                      context.read<AuthBloc>().add(
                            LogInAuthEvent(
                              email: email,
                              password: password,
                            ),
                          );
                    }
                  },
                ),
                SizedBox(height: 35.h),
                const LogInFormSeparator(),
                SizedBox(height: 35.h),
                CustomOutlinedButton(
                  text: 'Sign in anonymously',
                  color: CustomColors.mainDarkColor,
                  onTap: () {
                    context
                        .read<AuthBloc>()
                        .add(const LogInAnonymouslyAuthEvent());
                  },
                ),
                SizedBox(height: 20.h),
                CustomIconOutlinedButton(
                  text: 'Sign in with Google',
                  color: CustomColors.mainDarkColor,
                  svgPicture: SvgPicture.asset(
                    Svgs.gogleIcon,
                    width: 28.w,
                    height: 28.w,
                  ),
                  onTap: () {
                    context
                        .read<AuthBloc>()
                        .add(const LogInWithGoogleAuthEvent());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
