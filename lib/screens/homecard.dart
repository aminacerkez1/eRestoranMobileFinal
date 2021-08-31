import 'package:flutter/material.dart';
import 'package:flutter_stripe_payments/services/payment.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../global_url.dart';

class HomeCard extends StatefulWidget {
  HomeCard({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomeCard> {
  onItemPress(BuildContext context, int index) async {
    switch (index) {
      case 0:
        payViaNewCard(context);
        break;
    }
  }

  payViaNewCard(BuildContext context) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(message: 'Molimo sačekajte...');
    await dialog.show();
    int broj=0;
    broj=konacnaPrikaz.toInt();
    var response =
        await StripeService.payWithNewCard(amount: broj.toString()+'00', currency: 'USD');
    await dialog.hide();
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(response.message),
      duration:
          new Duration(milliseconds: response.success == true ? 1200 : 4000),
    ));
  }

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => Navigator.of(context).pop(),
  ), 
        backgroundColor: Color.fromRGBO(139, 0, 0, 1),
        title: Text('Plaćanje karticom'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.separated(
            itemBuilder: (context, index) {
              Icon icon;
              Text text;
              switch (index) {
                case 0:
                  icon = Icon(
                    Icons.add_circle,
                    color: Color.fromRGBO(139, 0, 0, 1),
                  );
                  text = Text('Plati novom karticom');
                  break;
              }

              return InkWell(
                onTap: () {
                  onItemPress(context, index);
                },
                child: ListTile(
                  title: text,
                  leading: icon,
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
                  color: Color.fromRGBO(139, 0, 0, 1),
                ),
            itemCount: 2),
      ),
    );
  }
}
