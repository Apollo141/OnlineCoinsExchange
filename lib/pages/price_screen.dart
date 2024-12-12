 import 'dart:io';

import 'package:bitcoin_ticker/models/coin_data.dart';
import 'package:bitcoin_ticker/services/crypto_currencyAPI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedItem = currenciesList.first;
  List<num> cryptoValues = [];
  var BTC = '0';
  var ETH = '0';
  var LTC = '0';

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    getCurrencyRate();
   }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            children: [
              contaierCurr('BTC', selectedItem, BTC),
              contaierCurr('ETH', selectedItem, ETH),
              contaierCurr('LTC', selectedItem, LTC)
            ],
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: environmentSpecifiedWidget()),
        ],
      ),
    );
  }

  Widget environmentSpecifiedWidget() {
    if (Platform.isAndroid) {
      return dropDownWidget();
    } else {
      return cupertinoPicker();
    }
  }

  Widget dropDownWidget() {
    return DropdownButton<String>(
      value: selectedItem,
      items: currenciesList.map((var e) {
        return DropdownMenuItem<String>(child: Text(e), value: e);
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          selectedItem = value ?? '';
          getCurrencyRate();
         });
      },
    );
  }

  Widget cupertinoPicker() {
    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 32,
        onSelectedItemChanged: (selected) {
          setState(() {
            print(selected);
          });
        },
        children: List<Widget>.generate(currenciesList.length, (index) {
          return Text(currenciesList[index]);
        }));
  }

  Widget contaierCurr(String baseCurr, String curr, String finalVal) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $baseCurr = ${finalVal} $curr',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getCurrencyRate() async {
           CryptoCurAPI cryptoCurAPI =await

    CryptoCurAPI(curr: selectedItem, baseCurr: cryptoList);
    var currResponse = await cryptoCurAPI.getAllCurData();
    print(currResponse);
    if (currResponse == null) {
      print('an issue occurred');

    } else {
       mapResponseData(currResponse);
    }
    

  }

  Future<void> mapResponseData(dynamic response) async {

      if (response.isEmpty) {
       print('an issue has occurred');
    }
    else {

setState(() {

  BTC = response[0]['rate'].toStringAsFixed(7);
  ETH = response[1]['rate'].toStringAsFixed(7);
  LTC = response[2]['rate'].toStringAsFixed(7);
});

      cryptoValues.clear();
    }
  }
}
