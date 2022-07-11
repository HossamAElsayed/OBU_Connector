import 'package:flutter/material.dart';
import 'package:obu_connector/shared/constants.dart';
import 'connection_screen.dart';

class SelectOBU extends StatefulWidget {
  const SelectOBU({Key? key}) : super(key: key);

  @override
  State<SelectOBU> createState() => _SelectOBUState();
}

class _SelectOBUState extends State<SelectOBU> {
  bool isSearching = true;
  int selectedDevice = -1;
  RangeValues _currentRangeValues = const RangeValues(20, 60);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StatefulBuilder(builder: (context, StateSetter setState) {
      return SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height * 0.4,
          child: isSearching
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 30),
                      child: Row(
                        children: [
                          const SizedBox(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            'searching ...',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade800),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      child: SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: availableDevices.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  setState(() {
                                    if (selectedDevice == index) {
                                      selectedDevice = -1;
                                    } else {
                                      selectedDevice = index;
                                    }
                                  });
                                });
                              },
                              child: Container(
                                width: 110,
                                decoration: BoxDecoration(
                                  color: selectedDevice == index
                                      ? Colors.blue.shade400
                                      : Colors.transparent,
                                  border: Border.all(
                                      width: 1.3, color: Colors.lightBlue),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                ),
                                margin: const EdgeInsets.only(right: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      availableDevices[index][0],
                                      height: 40,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      availableDevices[index][1],
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: selectedDevice == index
                                              ? Colors.white
                                              : Colors.grey.shade800),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    // Text(
                                    //   "+${_availableDevices[index][1]}\$",
                                    //   style: TextStyle(color: Colors.black),
                                    // )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    InkWell(
                      onTap: () {
                        selectedDevice >= 0
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PairingScreen('Device 1')))
                            : Navigator.pop(context);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color(0xFF272727),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        height: size.height * 0.07,
                        width: size.width * 0.4,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                              child: Text(
                                  selectedDevice >= 0
                                      ? 'Connect'
                                      : 'Cancel search',
                                  style: const TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white))),
                        ),
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 50.0,
                          height: 5.0,
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: Color(0xFF272727),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      const Text('Category',
                          style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF272727))),
                      const SizedBox(height: 15.0),
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                color: Color(0xFF272727),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            width: 80,
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                child: Text('iOS',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white)),
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: Color(0xFF272727),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            width: 90,
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                child: Text('Android',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white)),
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: Color(0xFFF0F2F5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            width: 100,
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                child: Text('Frontend',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF272727))),
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: Color(0xFFF0F2F5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            width: 100,
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                child: Text('Backend',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF272727))),
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: Color(0xFFF0F2F5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            width: 100,
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                child: Text('Network',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF272727))),
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: Color(0xFFF0F2F5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            width: 80,
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                child: Text('UI/UX',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF272727))),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 35.0),
                      const Text('Salary Range',
                          style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF272727))),
                      const SizedBox(height: 15.0),
                      RangeSlider(
                        values: _currentRangeValues,
                        max: 100,
                        divisions: 5,
                        labels: RangeLabels(
                          _currentRangeValues.start.round().toString(),
                          _currentRangeValues.end.round().toString(),
                        ),
                        activeColor: const Color(0xFF272727),
                        inactiveColor: const Color(0xFFF0F2F5),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _currentRangeValues = values;
                          });
                        },
                      ),
                      const SizedBox(height: 35.0),
                      const Text('Level',
                          style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF272727))),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: 0,
                                groupValue: 0,
                                activeColor: const Color(0xFF272727),
                                onChanged: (value) {},
                              ),
                              const Text('Entry')
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 1,
                                groupValue: 0,
                                onChanged: (value) {},
                              ),
                              const Text('Mid')
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 2,
                                groupValue: 0,
                                onChanged: (value) {},
                              ),
                              const Text('Staff')
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: 3,
                                groupValue: 0,
                                onChanged: (value) {},
                              ),
                              const Text('Senior')
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 4,
                                groupValue: 0,
                                onChanged: (value) {},
                              ),
                              const Text('Manager')
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      );
    });
  }
}
