
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  double billAmount = 0;
  int numberOfperson = 1;
  int tipPercentage = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            getTopContainer(size),
            getBottomContainer(size)
          ],
        ),
      ),
    );
  }

  Center getTopContainer(Size size){
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: size.height * 0.1),
        width: size.width * 0.8,
        height: size.height * 0.2,
        decoration: BoxDecoration(
          color: Colors.deepPurple.withOpacity(0.3),
          borderRadius: const BorderRadius.all(Radius.circular(20))
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Text("Total Per Person", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              Text("\$ ${calculatePerPersonCoast().toString()}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),)
            ],
          ),
        ),
      ),
    );
  }


  Container getBottomContainer(Size size){

    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      margin: const EdgeInsets.only(top: 30),
      child: Center(
        child: Container(
          width: size.width * .8,
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.blueGrey.shade100, style: BorderStyle.solid),
              borderRadius: const BorderRadius.all(Radius.circular(20))
          ),
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(color: Colors.purple, fontSize: 15 ),
                  decoration: const InputDecoration(hintText: "Enter Your Bill Amount", prefixIcon: Icon(Icons.attach_money, size: 20,)),
                  onChanged:(String value){
                    setState(() {
                      try {
                        billAmount = double.parse(value);
                      }catch(exception){
                        billAmount = 0.0;
                      }
                    });
                  },
                ),

                const SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Split", style: TextStyle(color: Colors.grey.shade700),),

                    Row(
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              if(numberOfperson > 1){
                                numberOfperson--;
                              }
                            });
                          },
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: Colors.purple.withOpacity(0.1)),
                            child: const Center(
                              child: Text("-",
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0),
                              ),
                            ),
                          ),
                        ),

                         Text(
                          numberOfperson.toString(),
                          style: const TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0),
                        ),

                        InkWell(
                          onTap: (){
                            setState(() {
                              numberOfperson++;
                            });
                          },
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            margin: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: Colors.purple.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(7.0)),
                            child: Center(
                              child: Text(
                                "+",
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 10,),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tip",
                      style: TextStyle(color: Colors.grey.shade700),
                    ),

                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child:  Text(get_tipCalculator().toString(),
                        style: const TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     Text("${tipPercentage.toString()}%",
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                    ),

                    Slider(
                        value: tipPercentage.toDouble(),
                        onChanged: (double newValue){
                          setState(() {
                            tipPercentage = newValue.round();
                          });
                        },
                      min: 0,
                      max: 100,
                      divisions: 20,
                      activeColor: Colors.purple,
                      inactiveColor: Colors.grey,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  get_tipCalculator(){
    double totalTip = 0;
    if(billAmount < 0 || billAmount == null || billAmount.toString().isEmpty ){

    }else{
      totalTip = ( billAmount * tipPercentage ) / 100;
    }
    return totalTip;
  }


  calculatePerPersonCoast(){
    double totalExpense = 0.0;
    double totalTip = get_tipCalculator();
    if(billAmount > 0 || billAmount.toString().isNotEmpty){
      totalExpense = totalTip + billAmount;
      totalExpense = totalExpense / numberOfperson;
    }

    return totalExpense;
  }
}
