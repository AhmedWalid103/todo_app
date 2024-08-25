import 'package:flutter/material.dart';
import 'package:todo_app/core/features/page_route_names.dart';
import 'package:todo_app/firebase/firebaseUtils.dart';
import 'package:todo_app/modules/menu/menu_view.dart';
import 'package:todo_app/modules/settings/settings_view.dart';

class LayoutView extends StatefulWidget {
  LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size.height;
    var theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFDFECDB),
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              "Login",
              style: theme.textTheme.bodyLarge
                  ?.copyWith(color: const Color(0xFFFFFFFF)),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: mediaQuery * 0.22),
                  Align(
                    alignment: Alignment.centerLeft,
                    child:
                        Text("Welcome Back!", style: theme.textTheme.bodyLarge),
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      RegExp emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                      if (!emailRegex.hasMatch(value)) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                    cursorColor: theme.primaryColor,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      hintText: "Enter your email address",
                      hintStyle: theme.textTheme.displaySmall
                          ?.copyWith(color: Colors.black),
                      label: Text("Email", style: theme.textTheme.displaySmall),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: theme.primaryColor),
                      ),
                      suffixIcon: const Icon(Icons.email_rounded),
                      errorStyle: const TextStyle(fontSize: 10),
                    ),
                  ),
                  TextFormField(
                    obscureText: isObscured,
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      RegExp passwordRegex = RegExp(
                          r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
                      if (!passwordRegex.hasMatch(value)) {
                        return """Password must contain:
- At least one uppercase letter
- At least one lowercase letter
- At least one digit
- At least one special character
- At least 8 characters""";
                      }
                      return null;
                    },
                    cursorColor: theme.primaryColor,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      hintText: "Enter your password",
                      hintStyle: theme.textTheme.displaySmall
                          ?.copyWith(color: Colors.black),
                      label:
                          Text("Password", style: theme.textTheme.displaySmall),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: theme.primaryColor),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            isObscured = !isObscured;
                          });
                        },
                        child: Icon(
                          isObscured ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                      errorStyle: const TextStyle(fontSize: 10),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Forget password?",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.pushNamed(context, PageRouteNames.account);
                        FireBaseUtils.signIn(
                                emailController.text, passwordController.text)
                            .then((value) {
                          if (value) {
                            Navigator.pushReplacementNamed(
                                context, PageRouteNames.menu);
                          }
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Login",
                          style: theme.textTheme.displayMedium
                              ?.copyWith(color: Colors.white),
                        ),
                        const Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, PageRouteNames.registration);
                    },
                    child: const Text(
                      "Or create my account",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: "menu"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "settings"),
            ],
          )),
    );
  }
}
