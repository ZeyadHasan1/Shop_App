import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Modules/Login/loginscreen.dart';
import 'package:shop_app/Shared/Components/components.dart';
import 'package:shop_app/Shared/cashhelper.dart';

class Onboardmodel {
  final String img;
  final String title;
  final String body;
  final double indicator;

  Onboardmodel({
    required this.img,
    required this.title,
    required this.body,
    required this.indicator,
  });
}

class OnBoard extends StatefulWidget {
  OnBoard({Key? key}) : super(key: key);

  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {

    void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value)
    {
      if (value) {
        navigateAndFinish(
          context,
          LoginScreen(),
        );
      }
    });
  }


  bool isLast = false;
  var onboardcontroller = PageController();
  List<Onboardmodel> onBoarding = [
    Onboardmodel(
      img: 'assets/images/one.png',
      title: 'OnBoarding title 1',
      body: 'OnBoarding body 1',
      indicator: 0.0,
    ),
    Onboardmodel(
        img: 'assets/images/2.png',
        title: 'OnBoarding title 2',
        body: 'OnBoarding body 2',
        indicator: 1.0),
    Onboardmodel(
      img: 'assets/images/3.png',
      title: 'OnBoarding title 3',
      body: 'OnBoarding body 3',
      indicator: 2.0,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: Text(
              'Skip',
              style: TextStyle(fontSize: 17),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: PageView.builder(
        onPageChanged: (index) {
          setState(() {
            if (index == onBoarding.length - 1) {
              isLast = true;
            } else {
              isLast = false;
            }
          });
        },
        controller: onboardcontroller,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) =>
            onboard(onBoarding[index]),
        itemCount: onBoarding.length,
      ),
    );
  }

  Widget onboard(Onboardmodel on) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${on.img}'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '${on.title}',
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text('${on.body}'),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DotsIndicator(
                dotsCount: onBoarding.length,
                position: on.indicator,
              ),
              Spacer(),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    if (isLast) {
                      submit();
                    } else {
                      onboardcontroller.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  });
                },
                child: Icon(Icons.arrow_forward_ios_outlined),
                mini: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}


//splash screen

class SplshScreen extends StatefulWidget {
  const SplshScreen({ Key? key }) : super(key: key);

  @override
  _SplshScreenState createState() => _SplshScreenState();
}

class _SplshScreenState extends State<SplshScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(seconds: 10),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return OnBoard();
                },
              ),
            ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(image: AssetImage('assets/images/shopping-bag.png',)
        ,width: 150,height: 150,),
      ),
    );
  }
}