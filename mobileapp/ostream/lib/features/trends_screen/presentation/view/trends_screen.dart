import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ostream/utils/resources/constants.dart';

class TrendsScreen extends StatelessWidget {
  static const routeName = "/TrendsScreen";

  const TrendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Trends Over Time"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.pagePadding),
        child: ListView(
          children: [
            // Title for Line Chart
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Weekly Trends (Line Chart)",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 300,
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Theme.of(context).canvasColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 61), // Week 1 data
                            FlSpot(1, 63), // Week 2 data
                            FlSpot(2, 68), // Week 3 data
                            FlSpot(3, 65), // Week 4 data
                            FlSpot(4, 63), // Week 5 data
                            FlSpot(5, 55), // Week 6 data
                            FlSpot(6, 57), // Week 7 data
                            FlSpot(7, 65), // Week 8 data
                            FlSpot(8, 68), // Week 9 data
                            FlSpot(9, 66), // Week 10 data
                          ],
                          isCurved: true,
                          dotData: FlDotData(show: false),
                          color: Colors.blue,
                        ),
                      ],
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 10,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toString(),
                                style: const TextStyle(fontSize: 12),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              // Display actual week number
                              return Text(
                                "Week ${value.toInt() + 1}",
                                style: const TextStyle(fontSize: 10),
                              );
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: const Border(
                          left: BorderSide(color: Colors.black, width: 1),
                          bottom: BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                      gridData: FlGridData(show: true),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Title for Bar Chart
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Monthly Trends (Bar Chart)",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 300,
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Theme.of(context).cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BarChart(
                    BarChartData(
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(toY: 15, color: Colors.red),
                          ],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(toY: 20, color: Colors.green),
                          ],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barRods: [
                            BarChartRodData(toY: 10, color: Colors.blue),
                          ],
                        ),
                        BarChartGroupData(
                          x: 3,
                          barRods: [
                            BarChartRodData(toY: 25, color: Colors.orange),
                          ],
                        ),
                        BarChartGroupData(
                          x: 4,
                          barRods: [
                            BarChartRodData(toY: 18, color: Colors.purple),
                          ],
                        ),
                      ],
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return Text("${value.toInt()}");
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              // Replacing with real month names
                              List<String> months = ["Jan", "Feb", "Mar", "Apr", "May"];
                              return Text(months[value.toInt() % months.length]);
                            },
                          ),
                        ),
                      ),
                      gridData: FlGridData(show: true),
                      borderData: FlBorderData(show: true),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Title for Pie Chart
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Category Distribution (Pie Chart)",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 300,
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Theme.of(context).primaryColorLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          value: 30,
                          title: "30% Tech",
                          color: Colors.blue,
                        ),
                        PieChartSectionData(
                          value: 20,
                          title: "20% Lifestyle",
                          color: Colors.green,
                        ),
                        PieChartSectionData(
                          value: 50,
                          title: "50% Sports",
                          color: Colors.orange,
                        ),
                      ],
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
