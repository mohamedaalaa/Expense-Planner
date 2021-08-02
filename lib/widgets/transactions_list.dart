import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planner/models/transactions.dart';

class TranactionsList extends StatelessWidget {
  final List<Transactions> transactions;
  final Function(String id) onDelete;

  TranactionsList(this.transactions,this.onDelete);

  @override
  Widget build(BuildContext context) {

     return transactions.isEmpty
          ? LayoutBuilder(builder: (context,constraints){
            return Column(
              children: <Widget>[
                Text(
                  "no transactions added yet!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: constraints.maxHeight * .6,
                  child: Image.asset(
                    "images/z.png",
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
     })


          : ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(6),
                  child: Card(
                    elevation: 6,
                    child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: FittedBox(
                              child: Text(
                                  "\$${transactions[index].amount.toStringAsFixed(2)}"),
                            ),
                          ),
                        ),
                        title: Text(
                          transactions[index].title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          DateFormat.yMMMd()
                              .format(transactions[index].DateTime),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            size: 35,
                            color: Colors.red,
                          ),
                          onPressed: (){
                            onDelete(transactions[index].id);
                          },
                        )),
                  ),
                );
              },
              itemCount: transactions.length,
    );
  }
}
