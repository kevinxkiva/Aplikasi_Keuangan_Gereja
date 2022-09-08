// ignore_for_file: todo
import 'package:aplikasi_keuangan_gereja/themes/colors.dart';
import 'package:aplikasi_keuangan_gereja/services/apiservices.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../globals.dart';
import '../../../widgets/responsivetext.dart';

class AdminDashboardControllerPage extends StatefulWidget {
  const AdminDashboardControllerPage({Key? key}) : super(key: key);

  @override
  State<AdminDashboardControllerPage> createState() =>
      _AdminDashboardControllerPageState();
}

class _AdminDashboardControllerPageState
    extends State<AdminDashboardControllerPage> {
  final _controllerDashboardPage = PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerDashboardPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controllerDashboardPage,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        AdminDashboardPage(
          controllerDashboardPage: _controllerDashboardPage,
        ),
        AdminBuatBeritaPage(
          controllerDashboardPage: _controllerDashboardPage,
        )
      ],
    );
  }
}

class AdminDashboardPage extends StatefulWidget {
  final PageController controllerDashboardPage;
  const AdminDashboardPage({Key? key, required this.controllerDashboardPage})
      : super(key: key);

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  ServicesUser servicesUser = ServicesUser();
  String nama = "";

  @override
  void initState() {
    getUserName(kodeUser);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  cardSaldo(judul, jumlah) {
    return SizedBox(
      width: 200,
      child: Card(
        color: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: navButtonPrimary.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              responsiveText(judul, 16, FontWeight.w700, darkText),
              Divider(
                color: navButtonPrimary.withOpacity(0.5),
                thickness: 1,
                height: 10,
              ),
              responsiveText(jumlah, 16, FontWeight.w700, darkText),
            ],
          ),
        ),
      ),
    );
  }

  cardNews(judul, isi) {
    return Card(
      color: scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: navButtonPrimary.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 350,
            decoration: BoxDecoration(
              color: primaryColor,
              border: Border.all(
                color: navButtonPrimary.withOpacity(0.5),
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.all(10),
            child: Text(
              "$judul",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Container(
            width: 350,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              border: Border.all(
                color: navButtonPrimary.withOpacity(0.5),
              ),
            ),
            child: Text("$isi"),
          )
        ],
      ),
    );
  }

  Future getUserName(userStatus) async {
    var response = await servicesUser.getSingleUser(userStatus);
    nama = response[1]['nama_lengkap_user'].toString();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    List<LineChartBarData> lineChartBarData = [
      LineChartBarData(
        isCurved: true,
        spots: [
          const FlSpot(1, 0),
          const FlSpot(2, 12),
          const FlSpot(3, 10),
          const FlSpot(4, 7),
          const FlSpot(5, 8),
          const FlSpot(6, 10),
        ],
        color: primaryColor,
        barWidth: 3,
      )
    ];
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Datang, ',
                        style: GoogleFonts.nunito(
                          color: darkText,
                          fontWeight: FontWeight.w900,
                          fontSize: 36,
                        ),
                      ),
                      Text(
                        nama,
                        style: GoogleFonts.nunito(
                          color: primaryColorVariant,
                          fontWeight: FontWeight.w800,
                          fontSize: 36,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: buttonColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        textStyle: GoogleFonts.nunito(
                            color: lightText,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            letterSpacing: 0.125),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        widget.controllerDashboardPage.animateToPage(1,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.ease);
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.add),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Buat"),
                              Text("Berita"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 56,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  controller: ScrollController(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        controller: ScrollController(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 350,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  cardNews('judul news',
                                      'Telah diterima donasi sebesar 3.000.000 dari Gereja ABCDE, Tuhan Yesus memberkati.'),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  cardNews('judul news',
                                      'Telah diterima donasi sebesar 3.000.000 dari Gereja ABCDE, Tuhan Yesus memberkati.'),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  cardNews('judul news',
                                      'Telah diterima donasi sebesar 3.000.000 dari Gereja ABCDE, Tuhan Yesus memberkati.'),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    cardSaldo('Saldo', '20000'),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    cardSaldo('Pemasukan', '20000'),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    cardSaldo('Pengeluaran', '20000'),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  width: 800,
                                  height: 500,
                                  child: LineChart(
                                    LineChartData(
                                      minX: 1,
                                      minY: 0,
                                      maxX: 6,
                                      maxY: 15,
                                      lineBarsData: lineChartBarData,
                                      gridData: FlGridData(show: false),
                                      borderData: FlBorderData(show: false),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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

class AdminBuatBeritaPage extends StatefulWidget {
  final PageController controllerDashboardPage;
  const AdminBuatBeritaPage({Key? key, required this.controllerDashboardPage})
      : super(key: key);

  @override
  State<AdminBuatBeritaPage> createState() => _AdminBuatBeritaPageState();
}

class _AdminBuatBeritaPageState extends State<AdminBuatBeritaPage> {
  final _controllerTemaBerita = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String formattedDate = "";
  String formattedTime = "";
  String time = "Time";
  String date = "Date";

  @override
  void initState() {
    // TODO: implement initState
    formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
    date = formattedDate;

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final localizations = MaterialLocalizations.of(context);
        formattedTime = localizations.formatTimeOfDay(selectedTime);
        time = formattedTime.toString();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  responsiveTextField(deviceWidth, deviceHeight, controllerText) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controllerText,
        autofocus: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: surfaceColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> selectDate(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.amber, // header background color
                onPrimary: Colors.black, // header text color
                onSurface: Colors.black, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: primaryColorVariant, // button text color
                ),
              ),
            ),
            child: child!);
      },
    );
    if (picked != null && picked != selectedDate) {
      if (mounted) {
        selectedDate = picked;
        formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
        date = formattedDate;
        debugPrint("Selected Date From $selectedDate");

        setState(() {});
      }
    }
  }

  Future<void> selectTime(context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.amber, // header background color
                onPrimary: Colors.black, // header text color
                onSurface: Colors.black, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: primaryColorVariant, // button text color
                ),
              ),
            ),
            child: child!);
      },
    );
    if (picked != null && picked != selectedTime) {
      if (mounted) {
        selectedTime = picked;
        final localizations = MaterialLocalizations.of(context);
        formattedTime = localizations.formatTimeOfDay(selectedTime);
        time = formattedTime.toString();
        debugPrint("Selected Date From $time");

        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    widget.controllerDashboardPage.animateToPage(0,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.ease);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
                const SizedBox(
                  width: 25,
                ),
                responsiveText("Buat Berita", 26, FontWeight.w900, darkText),
              ],
            ),
            const Divider(
              height: 56,
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                responsiveText(
                                    "Tema", 16, FontWeight.w700, darkText),
                                const SizedBox(
                                  height: 10,
                                ),
                                responsiveTextField(deviceWidth, deviceHeight,
                                    _controllerTemaBerita),
                                const SizedBox(
                                  height: 15,
                                ),
                                responsiveText(
                                    "Tanggal", 16, FontWeight.w700, darkText),
                                const SizedBox(
                                  height: 10,
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(date),
                                        IconButton(
                                          onPressed: () {
                                            selectDate(context).then(
                                              (value) => setState(() {}),
                                            );
                                          },
                                          icon:
                                              const Icon(Icons.calendar_month),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                responsiveText(
                                    "Jam", 16, FontWeight.w700, darkText),
                                const SizedBox(
                                  height: 10,
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(time),
                                        IconButton(
                                          onPressed: () {
                                            selectTime(context).then(
                                              (value) => setState(() {}),
                                            );
                                          },
                                          icon: const Icon(Icons.alarm),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 56,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: buttonColor,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 16),
                                    textStyle: GoogleFonts.nunito(
                                        color: lightText,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 14,
                                        letterSpacing: 0.125),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text("Simpan"),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                responsiveText("Gambar Berita", 16,
                                    FontWeight.w700, darkText),
                                const SizedBox(
                                  height: 15,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: buttonColor,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 16),
                                    textStyle: GoogleFonts.nunito(
                                        color: lightText,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 14,
                                        letterSpacing: 0.125),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text("Unggah Gambar"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
