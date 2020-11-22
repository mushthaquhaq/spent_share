import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spent_share/models/expense_type.dart';
import 'package:spent_share/models/global.dart';

class DatabaseService {
  // Collection reference
  final CollectionReference expenseTypeCollection = FirebaseFirestore.instance.collection('expenseTypes');

  Future updateExpenseType (String typeID, String typeName, String typeDescription) async {
    if((typeID ?? '') == '')
    {
      typeID = DocumentIDs().getNewDocumentID();
    }

    return await expenseTypeCollection.doc(typeID).set({
      'id' : typeID,
      'name' : typeName,
      'description' : typeDescription
    });
  }

  //expense types from snapshopt
  List<ExpenseType> _expenseTypesFromSnapShot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return ExpenseType(
        id: doc.data()['id'] ?? '',
        name: doc.data()['name'] ?? '',
        description: doc.data()['description'] ?? ''
        );
    }).toList();
  }
  //get expense types stream
  Stream<List<ExpenseType>> get expenseTypes{
    return expenseTypeCollection.snapshots()
      .map(_expenseTypesFromSnapShot);
  }

  //Expnse Type date from snapshot
  ExpenseType _expenseTypeDataFromSnapshot(DocumentSnapshot snapshot){
    return ExpenseType(
      id: snapshot.data()['id'], 
      name: snapshot.data()['name'], 
      description: snapshot.data()['description']
      );
  }

  Stream<ExpenseType> getExpenseType(typeID) {
    return expenseTypeCollection.doc(typeID).snapshots()
    .map(_expenseTypeDataFromSnapshot);
  }

}