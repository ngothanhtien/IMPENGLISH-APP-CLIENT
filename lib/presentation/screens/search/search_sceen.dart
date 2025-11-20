
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/widgets/recent_search.dart';
import 'package:learning_app_client/component/widgets/search_input_field.dart';
import 'package:learning_app_client/component/widgets/search_results.dart';
import 'package:learning_app_client/component/widgets/suggested_categories.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late TextEditingController _searchController;

  bool _isSearching = false;
  String _searchQuery = '';
  Timer? _debounce;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _searchController = TextEditingController();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if(query.trim().isEmpty) query = '';
    setState(() {
      _searchQuery = query;
      _isSearching = query.isNotEmpty;
    });
    if(_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), (){
      if(query.isNotEmpty){
        setState(() {

        });
      }
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _searchQuery = '';
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SafeArea(
          child: Column(
            children: [
              // Search Header
              Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 16,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SearchInputField(
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                        onClear: _clearSearch,
                      ),
                    ),
                  ],
                ),
              ),

              // Search Content
              Expanded(
                child: _isSearching
                    ? SearchResults(query: _searchQuery)
                    : const SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RecentSearches(),
                      SizedBox(height: 12),
                      SuggestedCategories(),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
