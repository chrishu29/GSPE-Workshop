import 'package:flutter/material.dart';

class AssetSearchBar extends StatefulWidget {
  @override
  _AssetSearchBarState createState() => _AssetSearchBarState();
}

class _AssetSearchBarState extends State<AssetSearchBar> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onChanged: (value) {
          // Perform search operation based on the entered value
          // You can update the search results or trigger a search callback here
          print('Search query: $value');
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
