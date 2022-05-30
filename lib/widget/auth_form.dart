import 'dart:io';

import 'package:chats/pickers/user_image.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
      this.submitFn,
      this.isLoading
      );

  final bool isLoading;

  final void Function(
      String email,
      String password,
      String username,
      File image,
      bool isLogin,
  BuildContext ctx,
      ) submitFn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey=GlobalKey<FormState>();
 var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  var _userImageFile;

  void _pickedImage(File image){
    _userImageFile=image;
  }



  void _trySubmit(){
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(_userImageFile == null && !_isLogin){
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('please pick an image'),
        backgroundColor: Theme.of(context).errorColor,
      ),
      );
      return;
    }
    if(isValid){
      _formKey.currentState?.save();
      widget.submitFn(
        _userEmail.trim(),
        _userName.trim(),
        _userPassword.trim(),
        _userImageFile,
        _isLogin,
          context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
             child: Column(
               mainAxisSize: MainAxisSize.min,
               children: <Widget>[
                 if(!_isLogin)
                    UserImage(_pickedImage),

                 TextFormField(
                   key: const ValueKey('email'),
                   validator: (value){
                     if(value == null || value.isEmpty || !value.contains('@') || !value.contains('.') ){
                       return 'please enter correct email address';
                     }
                     return null;
                   },
                   keyboardType: TextInputType.emailAddress,
                   decoration: const InputDecoration(
                     labelText: 'email address',
                   ),
                   onSaved: (value){
                     _userEmail=value!;
                   },
                 ),
                 if(!_isLogin)
                 TextFormField(
                   key: const ValueKey('username'),
                   validator: (value){
                     if(value == null || value.isEmpty || value.length<2){
                       return 'short user name';
                     }
                     return null;
                   },
                   decoration: const InputDecoration(
                     labelText: 'username'
                   ),
                   onSaved: (value){
                     _userName=value!;
                   },
                 ),
                 TextFormField(
                   key: const ValueKey('password'),

                   validator: (value){
                     if(value == null || value.isEmpty || value.length < 4){
                       return 'password must be at least 5 ';
                     }
                     return null;
                   },
                   decoration: const InputDecoration(
                     labelText: 'password'
                   ),
                   obscureText: true,
                   onSaved: (value){
                     _userPassword=value!;
                   },
                 ),

                 const SizedBox(height: 12,),
                 if(widget.isLoading)
                   CircularProgressIndicator(),
                 if(!widget.isLoading)
                 RaisedButton(
                 child: Text(_isLogin ? 'login' : 'sign up'),
                   onPressed: _trySubmit,
                 ),
                    if(!widget.isLoading)
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(_isLogin
                          ? 'create new account'
                          : 'i already have an account'),
                      onPressed: () {
                        setState(() {
                          _isLogin = ! _isLogin;
                        });
                    },

                    ),
               ],
             ),
            ),
          ),
        ),
      ),
    );
  }
}
