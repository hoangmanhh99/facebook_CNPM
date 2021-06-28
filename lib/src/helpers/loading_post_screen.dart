import 'package:Facebook_cnpm/src/helpers/colors_constant.dart';
import "package:flutter/material.dart";

class LoadingPost extends StatefulWidget {
  @override
  _LoadingPostState createState() => _LoadingPostState();
}

class _LoadingPostState extends State<LoadingPost>
    with TickerProviderStateMixin {
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1.5).animate(animation);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animation.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animation.forward();
      }
    });
    animation.forward();
  }

  void dispose() {
    // TODO: implement dispose
    animation.dispose();
    super.dispose();
  }

  Widget loadingComponent(double _height, double _weight) {
    return FadeTransition(
      opacity: _fadeInFadeOut,
      child: Container(
          height: _height,
          width: _weight,
          child: new Container(
            decoration: new BoxDecoration(
              color: Colors.grey[300],
              borderRadius: new BorderRadius.circular(45),
            ),
          )),
    );
  }

  Widget loadingBody() {
    var loading1 = Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(15),
      color: kColorWhite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              loadingComponent(50, 50),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  loadingComponent(20, 100),
                  loadingComponent(20, 50),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          loadingComponent(15, MediaQuery.of(context).size.width),
          SizedBox(
            height: 5,
          ),
          loadingComponent(15, MediaQuery.of(context).size.width),
          SizedBox(
            height: 5,
          ),
          loadingComponent(15, MediaQuery.of(context).size.width / 2),
          SizedBox(
            height: 5,
          ),
        ],
        //color: Colors.grey[300],
      ),
    );

    var loading2 = Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(15),
      color: kColorWhite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              loadingComponent(50, 50),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  loadingComponent(20, 100),
                  loadingComponent(20, 50),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          loadingComponent(15, MediaQuery.of(context).size.width),
          SizedBox(
            height: 5,
          ),
          loadingComponent(15, MediaQuery.of(context).size.width),
          SizedBox(
            height: 5,
          ),
          loadingComponent(15, MediaQuery.of(context).size.width / 2),
          SizedBox(
            height: 5,
          ),
          loadingComponent(400, MediaQuery.of(context).size.width),
        ],
        //color: Colors.grey[300],
      ),
    );

    return ListView(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 0),
      children: [
        loading1,
        loading2,
        Center(
          child: Container(
              height: 15,
              width: 15,
              decoration: new BoxDecoration(
                color: kColorWhite,
                borderRadius: new BorderRadius.circular(45),
              ),
              margin: EdgeInsets.only(top: 10),
              child: Center(
                child: SizedBox(
                    width: 5,
                    height: 5,
                    child: CircularProgressIndicator(
                      //value: 1,
                      strokeWidth: 0.8,
                      valueColor:
                      new AlwaysStoppedAnimation<Color>(Colors.grey[400] as Color),
                    )),
              )),
        ),
        Container(
            height: 5,
            width: 5,
            margin: EdgeInsets.only(top: 10),
            child: Center(
              child: SizedBox(
                  width: 5,
                  height: 5,
                  child: CircularProgressIndicator(
                    valueColor:
                    new AlwaysStoppedAnimation<Color>(Colors.grey[400] as Color),
                  )),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return loadingBody();
  }
}
