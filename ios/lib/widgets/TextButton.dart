import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_const.dart';

class TextButtonWithLoader extends StatefulWidget {
  final VoidCallback? onPressed; // Callback for button press
  final String text; // Button text

  const TextButtonWithLoader({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  _TextButtonWithLoaderState createState() => _TextButtonWithLoaderState();
}

class _TextButtonWithLoaderState extends State<TextButtonWithLoader> {
  bool _isLoading = false;

  void _handlePress() async {
    if (widget.onPressed == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      widget.onPressed!(); // Call the passed function
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 500,
        child: TextButton(
          onPressed: _isLoading ? null : _handlePress,
          style: TextButton.styleFrom(
            backgroundColor: AppConstants.critical,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
          ),
          child: _isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: AppConstants.white,
                    strokeWidth: 2.0,
                  ),
                )
              : Text(
                  widget.text,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppConstants.white,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
