import 'package:flutter/material.dart';

class InfoTemplate extends StatefulWidget {
  final String userName;
  final String imageUrl;
  const InfoTemplate({
    Key? key,
    required this.userName,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<InfoTemplate> createState() => _InfoTemplateState();
}

class _InfoTemplateState extends State<InfoTemplate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              "Hi,${widget.userName}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 200.0),
            child: SizedBox(
              height: 45.0,
              width: 45.0,
              child: CircleAvatar(
                radius: 50,
                child: ClipOval(
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
