import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPcOfTotal;

  const ChartBar(this.label, this.spendingAmount, this.spendingPcOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){
      return Column(
        children: <Widget>[
          Container(
            height: constraints.maxHeight * .1,
            child: FittedBox(
              child: Text("\$${spendingAmount.toStringAsFixed(0)}"),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * .05,
          ),
          Container(
            height: constraints.maxHeight * .7,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPcOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * .05,
          ),
          Container(
              height:constraints.maxHeight * .1,
              child: FittedBox(child: Text(label)),
          ),
        ],
      );
    }) ;
  }
}
