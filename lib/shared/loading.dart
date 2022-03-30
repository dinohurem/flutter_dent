import 'package:flutter/material.dart';
import 'package:flutter_provider/shared/size_config.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitWave(
          color: Colors.blue,
          size: SizeConfig.safeBlockVertical! * 5,
        ),
      ),
    );
  }
}
