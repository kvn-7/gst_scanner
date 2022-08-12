import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final gstno;

  const SearchBar({Key? key, required this.gstno}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
        child: TextFormField(
          style: TextStyle(fontSize: 16),
          cursorColor: Colors.black,
          onChanged: (value) {},
          initialValue: widget.gstno,
          decoration: InputDecoration(
              filled: true,
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                color: Colors.black,
                onPressed: () {},
              ),
              hintText: 'Search',
              fillColor: Colors.grey.shade300,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10))),
        ),
      ),
    );
  }
}
