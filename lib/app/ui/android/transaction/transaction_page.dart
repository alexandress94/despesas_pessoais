import 'package:despesas_pessoais/app/controller/transaction_controller.dart';
import 'package:despesas_pessoais/app/ui/android/transaction/widgets/alert_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/background_gradient_widget.dart';
import 'widgets/flexible_space_bar_widget.dart';
import 'widgets/transaction_list_widget.dart';

class TransactionPage extends GetView {
  
  final _controller = Get.find<TransactionController>();

  List _buildList() {

    List<Widget> listItems = [];
    for (int index = 0;
        index < _controller.transactionModelList.length;
        index++) {
          _controller.indexTransaction = _controller.transactionModelList[index];
      listItems.add(
        TransactionListWidget(
          transactions: _controller.transactionModelList[index],
          key: ValueKey(_controller.transactionModelList[index].id),
        ),
      );
    }
    
    return listItems.reversed.toList();

  }


void showAlertDialog(BuildContext context) {

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialogWidget(
          title:        "Inserir Transação",
          buttonBack:   "Voltar",
          buttonAciton: "Inserir",
        );
      },
    );
  }


  Widget _isEmptyTransaction() {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Nenhuma transação cadastrada!'),
          Container(
            padding: const EdgeInsets.only(top: 20),
            height: 200,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          BackgroundGradient(),
          Obx(
            () {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    elevation: 0.0,
                    actions: [
                      IconButton(
                        icon: Icon(Icons.add),
                        // onPressed: () => _alertDialog(),
                        onPressed: () => showAlertDialog(context),
                      ),
                    ],
                    centerTitle: false,
                    title: Text('Despesas Pessoais'),
                    floating: true,
                    pinned: true,
                    snap: true,
                    expandedHeight: 200,
                    flexibleSpace: FlexibleSpaceBar(
                      background: FlexibleSpaceBarWidget(),
                    ),
                  ),
                  _controller.transactionModelList.isEmpty
                      ? _isEmptyTransaction()
                      : SliverList(
                          delegate: SliverChildListDelegate(
                            _buildList(),
                          ),
                        ),
                ],
              );
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> showAlertDialog(context),
        // onPressed: () => _alertDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}
