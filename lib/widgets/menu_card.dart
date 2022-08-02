import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({Key? key, this.index}) : super(key: key);

  final index;

  @override
  Widget build(BuildContext context) {
    var url = 'imgs/header/userdefault.png';

    return Padding(
      padding: index == 0
          ? EdgeInsets.symmetric(horizontal: .1.sw)
          : EdgeInsets.only(right: .1.sw),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: AspectRatio(
          aspectRatio: 1.7,
          child: Stack(
            children: [
              SizedBox(
                width: 1.sw,
                child: Image.asset("assets/img/carro-azul.png"),
              ),
              Container(
                height: 1.sh,
                width: 1.sw,
                decoration: const BoxDecoration(
                  color: Colors.black54,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: .02.sh,
                  horizontal: .05.sw,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Testando",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    const Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: SizedBox(
                    height: 1.sh,
                    width: 1.sw,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
