import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../components/sheet_form.dart';
import '../../models/record.dart';
import '../../repository/client.dart';
import '../../utils/crud_utils.dart';
import 'home_appbar.dart';
import 'home_header.dart';
import 'home_records.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Result<List<Record>, DioError>? _records;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getRecords();
  }

  Future<void> _getRecords() async {
    setState(() {
      _isLoading = true;
    });
    final newRecords = await GetIt.I.get<ApiClient>().getRecords();
    setState(() {
      _records = newRecords;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const HomeAppBar(),
          ];
        },
        body: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Header(),
                Records(
                  records: _records,
                  onRefresh: _getRecords,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showSheetForm(
          context,
          onRefresh: _getRecords,
          type: Operation.create,
        ),
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}
