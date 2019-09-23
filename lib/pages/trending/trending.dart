import 'package:flutter/material.dart';
import 'package:gitme_reborn/pages/trending/developer.dart';
import 'package:gitme_reborn/pages/trending/project.dart';

enum TrendingDateRange { daily, weekly, monthly }

class TrendingPage extends StatefulWidget {
  @override
  _TrendingPageState createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  TrendingDateRange _dateRange = TrendingDateRange.daily;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            tabs: <Widget>[
              Tab(text: "Project"),
              Tab(text: "Developer"),
            ],
          ),
          actions: <Widget>[
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<TrendingDateRange>(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.date_range),
                        SizedBox(width: 8.0),
                        Text("Date range"),
                      ],
                    ),
                    enabled: false,
                  ),
                  CheckedPopupMenuItem<TrendingDateRange>(
                    value: TrendingDateRange.daily,
                    checked: _dateRange == TrendingDateRange.daily,
                    child: Text("daily"),
                  ),
                  CheckedPopupMenuItem<TrendingDateRange>(
                    value: TrendingDateRange.weekly,
                    checked: _dateRange == TrendingDateRange.weekly,
                    child: const Text("weekly"),
                  ),
                  CheckedPopupMenuItem<TrendingDateRange>(
                    value: TrendingDateRange.monthly,
                    checked: _dateRange == TrendingDateRange.monthly,
                    child: const Text("monthly"),
                  ),
                ];
              },
              onSelected: (TrendingDateRange range) {
                setState(() {
                  _dateRange = range;
                });
              },
            ),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            TrendingProjects(dateRange: _dateRange),
            TrendingDevelopers(dateRange: _dateRange),
          ],
        ),
      ),
    );
  }
}
