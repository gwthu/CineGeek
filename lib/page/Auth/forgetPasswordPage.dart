import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/theme.dart';
import '../../helper/utility.dart';
import '../../state/authState.dart';
import '../../widgets/customWidgets.dart';

class ForgetPasswordPage extends StatefulWidget {
  final VoidCallback? loginCallback;

  const ForgetPasswordPage({Key? key, this.loginCallback}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  FocusNode? _focusNode;
  TextEditingController? _emailController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _focusNode = FocusNode();
    _emailController = TextEditingController();
    _emailController!.text = '';
    _focusNode!.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode!.dispose();
    super.dispose();
  }

  Widget _body(BuildContext context) {
    return Container(
        height: fullHeight(context),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _label(),
            const SizedBox(
              height: 50,
            ),
            _entryFeild('Enter email', controller: _emailController),
            // SizedBox(height: 10,),
            _submitButton(context),
          ],
        ));
  }

  Widget _entryFeild(String hint,
      {TextEditingController? controller, bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(30)),
      child: TextField(
        focusNode: _focusNode,
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(
            fontStyle: FontStyle.normal, fontWeight: FontWeight.normal),
        obscureText: isPassword,
        decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                borderSide: const BorderSide(color: Colors.blue)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10)),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        width: MediaQuery.of(context).size.width,
        child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: TwitterColor.dodgetBlue,
          onPressed: _submit,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child:
              const Text('Submit', style: const TextStyle(color: Colors.white)),
        ));
  }

  Widget _label() {
    return Container(
        child: Column(
      children: <Widget>[
        customText('Forget Password',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: customText(
              'Enter your email address below to receive password reset instruction',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54),
              textAlign: TextAlign.center),
        )
      ],
    ));
  }

  void _submit() {
    if (_emailController!.text == null || _emailController!.text.isEmpty) {
      customSnackBar(_scaffoldKey, 'Email field cannot be empty');
      return;
    }
    var isValidEmail = validateEmal(
      _emailController!.text,
    );
    if (!isValidEmail) {
      customSnackBar(_scaffoldKey, 'Please enter valid email address');
      return;
    }

    _focusNode!.unfocus();
    var state = Provider.of<AuthState>(context, listen: false);
    state.forgetPassword(_emailController!.text, scaffoldKey: _scaffoldKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: customText('Forget Password',
            context: context, style: const TextStyle(fontSize: 20)),
        centerTitle: true,
      ),
      body: _body(context),
    );
  }
}
