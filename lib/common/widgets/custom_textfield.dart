import 'package:flutter/material.dart';
/*
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText; 
  final int maxLines;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPassword = hintText == 'Password';  //

    return TextFormField(
      controller: controller,
      obscureText: isPassword,    //
      decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          )),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          ))),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
*/

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final TextInputType keyboardType;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text, 
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.hintText == 'Password';

    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: isPassword && _obscureText,
      decoration: InputDecoration(
        labelText: widget.hintText,
        hintText: widget.hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your ${widget.hintText}';
        }
        return null;
      },
      maxLines: widget.maxLines,
    );
  }
}


// class CustomTextFieldP extends StatefulWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final int maxLines;
//   const CustomTextFieldP({
//     Key? key,
//     required this.controller,
//     required this.hintText,
//     this.maxLines = 1,
//   }) : super(key: key);

//    bool _obscureText = true;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       obscureText: _obscureText,
//       decoration: InputDecoration(
//           hintText: hintText,
//           suffixIcon: IconButton(
//           icon: Icon(
//             _obscureText ? Icons.visibility : Icons.visibility_off,
//           ),
//           onPressed: () {
//           setState(() {
//               _obscureText = !_obscureText; // Toggle the value.
//             });
//           },
//         ),
//           border: const OutlineInputBorder(
//               borderSide: BorderSide(
//             color: Colors.black38,
//           )),
//           enabledBorder: const OutlineInputBorder(
//               borderSide: BorderSide(
//             color: Colors.black38,
//           ))),
//       validator: (val) {
//         if (val == null || val.isEmpty) {
//           return 'Enter your $hintText';
//         }
//         return null;
//       },
//       maxLines: maxLines,
//     );
//   }
// }