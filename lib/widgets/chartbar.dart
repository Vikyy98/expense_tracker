import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final label;
  final spendingAmount;
  final spendingPTCofAmount;
  ChartBar(this.label, this.spendingAmount, this.spendingPTCofAmount);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraint) {
        return Column(
          children: [
            Container(height: constraint.maxHeight * 0.15, child: Text(label)),
            SizedBox(
              height: constraint.maxHeight * 0.05,
            ),
            Container(
              height: constraint.maxHeight * 0.6,
              width: 10,
              child: Stack(
                //Aligned from bottom to top
                children: [
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 1),
                          color: Theme.of(context).primaryColor)),
                  FractionallySizedBox(
                    heightFactor: spendingPTCofAmount,
                    child: Container(color: Colors.black),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constraint.maxHeight * 0.05,
            ),
            Container(
                height: constraint.maxHeight * 0.15,
                child: FittedBox(child: Text('\$${spendingAmount.toString()}')))
          ],
        );
      },
    );
  }
}
