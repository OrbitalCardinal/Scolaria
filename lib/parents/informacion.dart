import 'package:Scolaria/parents/models/Group_Model.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  static List<GroupStudentModel> tempLoans = [];

  List<String> _items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Informacion"))
    );
  }
  Widget _buildItem(String item, Animation animation, int index){
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        elevation: 2,
        child: ListTile(
          title: Text(
            item,
            style: TextStyle(
              fontWeight: FontWeight.w600
            ),
          ),
          subtitle: Text('Una prueba...'),
          leading: CircleAvatar(backgroundColor: Colors.blueGrey,),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.grey[30],),
            onPressed: (){
              _removeItem(index);
                          },
                        ),
                      ),
                    ),
                  );
              
              }
              
                void _removeItem(int i) {
                  String removedItem = _items.removeAt(i);
                  AnimatedListRemovedItemBuilder builder = (context, animation){
                    return _buildItem(removedItem, animation, i);
                    };
                    _key.currentState.removeItem(i, builder);
                }
                //}

                void _addItem(){
                  int i = _items.length > 0 ? _items.length : 0;
                  _items.insert(i, 'Item ${_items.length+1}');
                  _key.currentState.insertItem(i);
                }
}
