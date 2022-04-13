import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_shortner/provider.dart';

class HomePage extends StatelessWidget {
  TextEditingController uri_to_convertFrom = TextEditingController();
  TextEditingController uri_converted = TextEditingController();


  HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<UrlShortenerState>(context);

    Future<void> _copyToClipboard() async {
      await Clipboard.setData(ClipboardData(text: uri_converted.text));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Copied to clipboard'),
      ));
    }
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        title: Center(
                  child: Text(' URL SHORTENER'),)
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Enter Your Url Here'),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                  width: 300,
                  height: 100,
                  padding: EdgeInsets.all(2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blueGrey, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child:
                  TextFormField(
                    // decoration: InputDecoration(
                    //   border: InputBorder,
                    // ),
                    controller: uri_to_convertFrom,
                    maxLines: 4,
                    style: TextStyle(fontSize: 15, color: Colors.black),
                    textAlign: TextAlign.center,
                  )
              ),
            ),

            (prov.isLoading !=false)?
            CircularProgressIndicator():
            MaterialButton(
            color: Theme.of(context).colorScheme.secondary,
            child: Text(
              "Shorten Url",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              //
              //IF TEXTINPUT IS EMPTY, DO SOMETHING ELSE GENERATE URL
              prov.setisLoading();
              prov.getShortLink(uri_to_convertFrom.text);
              uri_converted.text= '${prov.resultConvertedUrl}';
            },
          ),


SizedBox(
  height: 70,
),

Text('Copy Your Short Url Here '),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 300,
                height: 100,
                padding: EdgeInsets.all(12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blueGrey, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child:
                  Text('${prov.resultConvertedUrl}',
                  style: TextStyle(fontSize: 20, color: Colors.black),
              textAlign: TextAlign.center,
            )
              ),
            ),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children:[
             MaterialButton(
               color: Theme.of(context).colorScheme.secondary,
               child: Text(
                 "Copy Url",
                 style: TextStyle(color: Colors.white),
               ),
               onPressed: () {
                 Clipboard.setData(ClipboardData(text: prov.resultConvertedUrl));
                 ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                       content: Text('Url Copied'),
                     )
                 );
                 //prov.getShortLink(uri_to_convertFrom.text);
               },
             ),
               MaterialButton(
                 color: Theme.of(context).colorScheme.secondary,
                 child: Text(
                   "Clear All",
                   style: TextStyle(color: Colors.white),
                 ),
                 onPressed: () {
                   uri_to_convertFrom.clear();
                   _copyToClipboard;
                   prov.setClear();                 },
               ),
    ]

           ),

           //  SelectableText(
           //    '${prov.resultConvertedUrl}',
           //    maxLines: 5,
           //        ),

                     ],
        ),
      ),
    );
  }

}
