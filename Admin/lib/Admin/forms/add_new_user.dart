import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keepapp/Admin/Bloc/AddUserBloc/bloc.dart';
import 'package:keepapp/Admin/widget/theme.dart';

class AddNewUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  AddUserBloc _bloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty;

  bool isRegisteredButtonEnabled(AddUserState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AddUserBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _confirmPasswordController.addListener(_onConfirmPasswordChanged);
  }

  void _onEmailChanged() {
    _bloc.add(EmailChangedEvent(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _bloc.add(PasswordChangedEvent(
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text));
  }

  void _onConfirmPasswordChanged() {
    _bloc.add(ConfirmPasswordChanged(
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text));
  }

  int tag = 0;
  List<String> options = [
    'Sr.Manager',
    'Manager',
    'Employee',
    'Security',
  ];
  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    final _formKey = GlobalKey<FormState>();
    return BlocListener<AddUserBloc, AddUserState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Adding User...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('User Added Successfully'),
                  ],
                ),
              ),
            );

          // Fluttertoast.showToast(msg: "User Added Successfully");
          // BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          // Navigator.of(context).pop();
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(state.errorMessage),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<AddUserBloc, AddUserState>(
        builder: (context, state) {
          return Center(
            child: Material(
              elevation: 10,
              shadowColor: Colors.grey,
              borderRadius: BorderRadius.circular(4),
              child: Container(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                height: _media.height / 1.2 - 5,
                width: _media.width / 2.5 - 12,
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Add User',
                        style: cardTitleTextStyle,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Material(
                        elevation: 8.0,
                        shadowColor: Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          autovalidate: true,
                          validator: (_) {
                            return !state.isValidEmail
                                ? "Enter valid email"
                                : null;
                          },
                          decoration: InputDecoration(
                              icon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Icon(Icons.email, color: Color(0xff224597)),
                              ),
                              hintText: 'User E-mail Id',
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0.0))),
                        ),
                      ),
                      SizedBox(height: 30),
                      Material(
                        elevation: 8.0,
                        shadowColor: Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          autocorrect: false,
                          autovalidate: true,
                          validator: (_) {
                            return !state.isValidPassword
                                ? "Password can't be empty"
                                : null;
                          },
                          decoration: InputDecoration(
                              icon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Icon(Icons.lock, color: Color(0xff224597)),
                              ),
                              hintText: 'Password',
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0.0))),
                        ),
                      ),
                      SizedBox(height: 30),
                      Material(
                        elevation: 8.0,
                        shadowColor: Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          autocorrect: false,
                          autovalidate: true,
                          validator: (_) {
                            if (!state.isValidConfirmPassword) {
                              return "Password can not empty";
                            } else if (!state.isPasswordMatch) {
                              return "Password should match";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              icon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Icon(Icons.lock, color: Color(0xff224597)),
                              ),
                              hintText: 'Confirm Password',
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0.0))),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text("Select Role"),
                      SizedBox(
                        height: 10,
                      ),
                      ChipsChoice<int>.single(
                        value: tag,
                        options: ChipsChoiceOption.listFrom<int, String>(
                          source: options,
                          value: (i, v) => i,
                          label: (i, v) => v,
                        ),
                        onChanged: (val) => setState(() => tag = val),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: InkWell(
                          onTap: _onFormSubmitted,
                          child: Material(
                            shadowColor: Colors.grey,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            color: Colors.greenAccent,
                            child: Container(
                              alignment: Alignment.center,
                              height: 35,
                              width: 80,
                              child: Text(
                                'Add',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onFormSubmitted() {
    _bloc.add(SubmitFormEvent(
        email: _emailController.text,
        password: _passwordController.text,
        role: options[tag]));
  }
}
