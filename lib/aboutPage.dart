import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/universalWidgets.dart';


///
/// Class: AboutPage
///
/// Displays information about Grassland Agro and the GrassVESS application.
///
/// Returns: [Widget] of the about page.
///
class AboutPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget('Grassland Agro & GrassVESS'),
        body: Center(
            child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Image.asset('images/grassland_logo_transparent_new.png')
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                            '\nGRASSLAND AGRO WAS FORMED ON THE 1ST FEBRUARY 2013.\n\nIt was created from the coming together of Freshgrass Group’s – Grassland Fertilizers business and Groupe Roullier’s Timac Agro Ireland business. It is now a 50/50 Joint Venture Company between The Freshgrass Group and Groupe Roullier.\n\nGrassland Agro has three industrial fertilizer plants in Limerick, Cork and Slane with the head office based in Ballymount in Dublin. Grassland Agro sources, produces and sell the complete range of conventional commodity fertilizers as well as the most comphrensive range of speciality fertilizer and soil conditioning products. In addition Grassland Agro sells a full range of animal mineral blocks as well as biostimulants.\n\nGrassland Agro also has seven on the dairy hygiene team and they work in conjunction with all the many agri merchants in representing and selling Groupe Roullier’s renowned “Hypred” dairy hygiene and medicated animal bedding products. With the exception of the conventional fertilizer products most of the speciality product range is patented.\n\nGrassland Agro has full access to the continuous Research and Development work of Groupe Roullier’s dedicated 350 professional Engineers and Researchers in addition to that of many University and Independent Agricultural Research Institutions with whom they collaborate.\n\nWhile all Grassland Agro products are directly distributed by the Agri Merchants and Co-ops across Ireland, Grassland Agro has over thirty Agronomy Sales Specialists visiting farmers across Ireland everyday explaining the merits of Grassland Agro speciality products and evaluating which products would distinctly add value to each farmers business. All Grassland Agro Conventional Commodity products are sold to the Co-op and Merchant trade by five Regional Sales Managers.',
                              style: TextStyle(fontSize: 20.0),),
                          )
                      )
                    ])
            ))
    );
  }
}
