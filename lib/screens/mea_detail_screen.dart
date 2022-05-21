import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/data/dummy_data.dart';
import 'package:flutter_complete_guide/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal =
        DUMMY_MEALS.firstWhere((element) => element.id == mealId);
    return Scaffold(
        appBar: AppBar(title: Text(selectedMeal.title)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(selectedMeal.imageUrl, fit: BoxFit.cover),
              ),
              buildSectionTitle(context, 'Ingredients'),
              buildContainer(
                  context,
                  ListView.builder(
                      itemBuilder: (ctx, index) => Card(
                          color: Theme.of(context).accentColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(selectedMeal.ingredients[index]),
                          )),
                      itemCount: selectedMeal.ingredients.length)),
              buildSectionTitle(context, 'Steps'),
              buildContainer(
                  context,
                  ListView.builder(
                      itemBuilder: (ctx, index) => Column(
                        children: [
                          ListTile(
                                leading: CircleAvatar(child: Text('# ${index + 1}')),
                                title: Text(selectedMeal.steps[index]),
                              ),
                          Divider(),
                        ],
                      ),
                      itemCount: selectedMeal.steps.length)),
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.delete),onPressed: (){
        Navigator.of(context).pop(mealId);

      },),
    );
  }

  Container buildContainer(BuildContext context, Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 200,
      width: 300,
      child: child,
    );
  }

  Container buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
