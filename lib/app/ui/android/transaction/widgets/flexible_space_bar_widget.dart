import 'package:despesas_pessoais/app/controller/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlexibleSpaceBarWidget extends GetView {
  
  static const double appBarHeight = 66;

  @override
  Widget build(BuildContext context) {
    // final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      padding: const EdgeInsets.only(top: appBarHeight),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: GetBuilder<TransactionController>(
            builder: (_) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'R\$ ',
                      ),
                      TextSpan(
                        text: '${_.totalValue.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 36,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_upward,
                            color: Colors.green,
                          ),
                          Column(
                            children: [
                              Text('Receitas'),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'R\$ ',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    TextSpan(
                                      text: '${_.recipes.toStringAsFixed(2)}',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_downward,
                            color: Colors.red,
                          ),
                          Column(
                            children: [
                              Text('Despesas'),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'R\$ ',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    TextSpan(
                                      text: '${_.expenses.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _.transactionModelList.isEmpty
                          ? SizedBox.shrink()
                          : Text('Últimas transações'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
