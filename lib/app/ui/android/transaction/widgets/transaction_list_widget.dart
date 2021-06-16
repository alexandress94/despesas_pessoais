import 'package:despesas_pessoais/app/controller/transaction_controller.dart';
import 'package:despesas_pessoais/app/data/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionListWidget extends GetWidget {
  final TransactionModel transactions;

  TransactionListWidget({
    Key key,
    this.transactions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller   = Get.find<TransactionController>();
    final bool isRadio  = transactions.radio == 0;    


    Widget cardItemsRecipes() {
      return ListTile(
        onTap: () {
          print("${transactions.description}");
        },
        leading: CircleAvatar(backgroundColor: Colors.green, radius: 5),
        trailing: FittedBox(
          child: Text(
            'R\$ ${transactions.value.toStringAsFixed(2)}',
            style: TextStyle(color: Colors.green),
          ),
        ),
        title: Text(
          '${transactions.description}',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${transactions.date}',
          style: TextStyle(color: Colors.white60, fontSize: 16),
        ),
      );
    }

    Widget cardItemsExpenses() {
      return ListTile(
        onTap: (){
          print("${transactions.description}");
        },
        leading: CircleAvatar(
          backgroundColor: Colors.red,
          radius: 5,
        ),
        trailing: FittedBox(
          child: Text(
            '- R\$ ${transactions.value.toStringAsFixed(2)}',
            style: TextStyle(color: Colors.red),
          ),
        ),
        title: Text(
          '${transactions.description}',
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${transactions.date}',
          style: TextStyle(color: Colors.white60, fontSize: 16),
        ),
      );
    }

    return Dismissible(
      key: key,
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
         _controller.removedTransactions = transactions;
        _controller.deleteTransaction(transactions.id);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Removendo o item \"${transactions.description}\"'),              
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: (){
                    _controller.insertTransactionRemoved();
                    Get.back();

                  }, child: Text('Desfazer')),
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('Confirmar')),
                ],
              ),
            );
          },
        );
      },
      background: Container(
        color: Theme.of(context).errorColor,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      child: Card(
        shape: Border.all(color: Colors.white24),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        color: Colors.transparent,
        elevation: 5,
        child: isRadio ? cardItemsRecipes() : cardItemsExpenses(),
      ),
    );
  }
}
