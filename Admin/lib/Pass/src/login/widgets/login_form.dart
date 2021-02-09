import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keepapp/widgets/LoginCliper.dart';
import 'package:keepapp/Pass/src/auth/bloc/authentication_bloc.dart';
import 'package:keepapp/Pass/src/auth/bloc/authentication_event.dart';
import 'package:keepapp/Pass/src/data/api/user_repository.dart';
import 'package:keepapp/Pass/src/login/bloc/login_bloc.dart';
import 'package:keepapp/Pass/src/login/bloc/login_event.dart';
import 'package:keepapp/Pass/src/login/bloc/login_state.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState loginState) {
    return loginState.isFormValid && isPopulated && !loginState.isSubmitting;
  }

  Function _reset;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  void _onEmailChanged() {
    _loginBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _loginBloc.add(PasswordChanged(password: _passwordController.text));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onFormSubmitted() {
    _loginBloc.add(LoginWithCredentialsPressed(
        email: _emailController.text, password: _passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(state.errorMessage), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSuccess) {
          print("reach in sign in : login form");
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          print("reach in sign in: login form : success");
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Color(0xFFDFF8FE),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,

              ///decoration: BoxDecoration(color: Color(0xFFDFF8FE)),
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Welcome Back!",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.02,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF4BB8F4),
                                ),
                                // GoogleFonts.roboto(
                                //     fontSize:
                                //         MediaQuery.of(context).size.width *
                                //             0.02,
                                //     fontWeight: FontWeight.w900,
                                //     color: Color(0xFF4BB8F4),
                                //     ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Stack(
                            children: [
                              //Making of the Login Part
                              Positioned(
                                top: 20,
                                left: 20,
                                right: 20,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.66,
                                  width:
                                      MediaQuery.of(context).size.width * 0.98,
                                  child: Stack(
                                    children: [
                                      CustomPaint(
                                        //Shadow for the Box
                                        painter: loginShadowPaint(),
                                        child: ClipPath(
                                          //WIll make  a clip Path of the shape as Login
                                          clipper: loginClipper(),

                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.6,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.92,
                                            decoration: BoxDecoration(
                                                color: Colors.white),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.02,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 30, top: 20),
                                                  child: Text(
                                                    "Login",
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.02,
                                                        color: Colors.black),

                                                    // GoogleFonts.roboto(
                                                    //     fontWeight:
                                                    //         FontWeight.w600,
                                                    //     fontSize: MediaQuery.of(
                                                    //                 context)
                                                    //             .size
                                                    //             .width *
                                                    //         0.02,
                                                    //     color: Colors.black),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.015,
                                                ),
                                                Container(
                                                    width: 75,
                                                    margin: EdgeInsets.only(
                                                      left: 30,
                                                    ),
                                                    height: 12,
                                                    child: Card(
                                                        elevation: 2,
                                                        color:
                                                            Color(0xFF4BB8F4))),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.02,
                                                ),
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                    margin: EdgeInsets.only(
                                                      left: 30,
                                                    ),
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.05,
                                                    child: TextFormField(
                                                      controller:
                                                          _emailController,
                                                      autovalidate: true,
                                                      keyboardType:
                                                          TextInputType
                                                              .emailAddress,
                                                      validator: (_) {
                                                        return !state
                                                                .isEmailValid
                                                            ? "Enter valid email"
                                                            : null;
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        icon: Icon(
                                                          Icons.mail,
                                                          size: 24,
                                                          color:
                                                              Color(0xFF4BB8F4),
                                                        ),
                                                        hintText:
                                                            'Email Address',
                                                        // labelText:
                                                        //     "Email Address",
                                                        labelStyle: TextStyle(
                                                            fontFamily: 'Lato',
                                                            fontSize: 16,
                                                            color: Colors
                                                                .grey[500]),
                                                        // GoogleFonts.lato(
                                                        //     fontSize: 16,
                                                        //     color: Colors
                                                        //             .grey[
                                                        //         500]),
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.02,
                                                ),
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                    margin: EdgeInsets.only(
                                                      left: 30,
                                                    ),
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.055,
                                                    child: TextFormField(
                                                      controller:
                                                          _passwordController,
                                                      obscureText: true,
                                                      autovalidate: true,
                                                      autocorrect: false,
                                                      validator: (value) => !state
                                                              .isPasswordValid
                                                          ? "Password can't be empty"
                                                          : null,
                                                      decoration:
                                                          InputDecoration(
                                                        icon: Icon(
                                                          FontAwesomeIcons
                                                              .eyeSlash,
                                                          size: 20,
                                                          color:
                                                              Color(0xFF4BB8F4),
                                                        ),
                                                        hintText: 'Password',
                                                        // labelText:
                                                        //     "Password",
                                                        labelStyle: TextStyle(
                                                            fontFamily: 'Lato',
                                                            fontSize: 16,
                                                            color: Colors
                                                                .grey[500]),
                                                        // GoogleFonts.lato(
                                                        //     fontSize: 16,
                                                        //     color: Colors
                                                        //             .grey[
                                                        //         500]),
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.015,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 28),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Spacer(),
                                                      Text(
                                                        "Forgot Password ?",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12,
                                                            color: Color(
                                                                0xFF4BB8F4)),
                                                        // GoogleFonts.roboto(
                                                        //     fontWeight:
                                                        //         FontWeight
                                                        //             .w600,
                                                        //     fontSize: 12,
                                                        //     color: Color(
                                                        //         0xFF4BB8F4)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.015,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 28),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Material(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    100.0),
                                                        color:
                                                            Color(0xFFDFF8FE),
                                                        child: IconButton(
                                                          onPressed: () =>
                                                              _onFormSubmitted(),
                                                          icon: Icon(Icons
                                                              .arrow_forward),
                                                          color:
                                                              Colors.blueAccent,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
