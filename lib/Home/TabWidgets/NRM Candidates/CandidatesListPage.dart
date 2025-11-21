import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CandidatesListPage extends StatefulWidget{

  var district;
  CandidatesListPage({super.key, this.district});

  @override
  State<CandidatesListPage> createState() {
    return _CandidatesListPage();
  }

}

class _CandidatesListPage extends State<CandidatesListPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.district} Candidate(s)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFD401),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/drawable/ic_nrm_app_icon.png',
            width: 80,
            height: 80,
          ),
          const SizedBox(height: 20),
          Center(
              child: Text("No candidates available yet.",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ),
        ],
      ),
    );
  }
}