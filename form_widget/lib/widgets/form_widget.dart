import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {

  final _formKey = GlobalKey<FormState>();
  final _fullNameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  bool _isHidePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Form Widget"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: _buildFormView(),);
  }

  Widget _buildFormView()
  {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          SizedBox(height: 16,),
          _buildFullNameText(),
          SizedBox(height: 16,),
          _buildPasswordFormText(),
        ],
      ),
    );
  }

  Widget _buildFullNameText()
  {
    return TextFormField(
      controller: _fullNameCtrl,
      decoration: InputDecoration(
        prefix: Icon(Icons.text_fields),
        hintText: "Enter full Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),

        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber, width: 2),
        ),
      ),

      validator: (text){
        if(text!.isEmpty) return "Full name is requred";
        return null;
      },
    );
  }

  Widget _buildPasswordFormText()
  {
    return TextFormField(
      controller: _passwordCtrl,
      obscureText: _isHidePassword,
      decoration: InputDecoration(
        prefix: Icon(Icons.key),
        hintText: "Enter password",
        suffix: IconButton(onPressed: (){
          setState(() {
            (() => _isHidePassword=!_isHidePassword);
          });
          }, 
          icon: Icon(_isHidePassword ? Icons.visibility : Icons.visibility_off)
        )
      ),
      validator: (text){
        if (text!.isEmpty) return "Passowrd is required";
        if (text.length<6) return "Password must be at least 6 chars";
        return null;
      },
      textInputAction: TextInputAction.send,
    );
  }
}