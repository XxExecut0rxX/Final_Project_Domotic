import 'package:flutter/material.dart';
import 'package:pro_final/home/data_slides.dart';

class MainHome extends StatelessWidget {
  MainHome({ Key? key }) : super(key: key);

  final titleHome = Container(
    padding: const EdgeInsets.symmetric(horizontal: 5.0),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.only(
            right: 20,
          ),
          child: RichText(
            text: const TextSpan(
              children : [
              TextSpan(
                text: "Smart ",
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w900,
                ),
              ),
              TextSpan(
              text: "Institution",
              style: TextStyle(
                color: Color(0xff33e1ec),
                decoration: TextDecoration.underline,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w900,
              ),
            ),],
            style: TextStyle(
              fontSize : 18,
            ),
          ),
        ),
      ),
      Expanded(
        child:Container(), 
      ),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xff33e1ec),
          ),
          padding: const EdgeInsets.all(6),
          child: const Center(
            child: Icon(
              Icons.person,
            ),
          ),
        ),
      )]
    )
  );

  final general = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5.0),
    child: Row(
      children : [
        const Text(
          "General ",
          style: TextStyle(
            fontSize: 28,
            color: Colors.black87,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w900,
          ),
        ),
        Expanded(child: Container()),

        ElevatedButton.icon(
          onPressed: (){}, 
          icon: const Icon(Icons.add), 
          label: const Text(
            "Add"
          ),
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0.0),
            foregroundColor: MaterialStateProperty.all(const Color(0xff56c2cd)),
            backgroundColor: MaterialStateProperty.all(const Color(0xffe3fcff)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                //side: const BorderSide(color: Colors.white),
              ),
            ),
          )
        ),
      ]
    ),
  );

  final slidesD = Container(
    padding: const EdgeInsetsDirectional.all(1.0),
    child: Center(child: DataSlides()),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          
          children: [
            titleHome,
            const SizedBox(height: 14.0,),
            general,
            const SizedBox(
              height: 14.0,
            ),
            slidesD,
          ],
        ),
      ),
    ); 
  }
}