//ignore_for_file: todo

import 'package:aplikasi_keuangan_gereja/globals.dart';
import 'package:aplikasi_keuangan_gereja/themes/colors.dart';
import 'package:aplikasi_keuangan_gereja/widgets/responsivetext.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../services/apiservices.dart';
import '../../../widgets/loadingindicator.dart';

String _kodeRole = "";
String _kodeUser = "";
String _namaUser = "";

class AdminAnggotaController extends StatefulWidget {
  const AdminAnggotaController({Key? key}) : super(key: key);

  @override
  State<AdminAnggotaController> createState() => _AdminAnggotaControllerState();
}

class _AdminAnggotaControllerState extends State<AdminAnggotaController> {
  final _controllerPageAnggota = PageController();
  final _controllerPageRole = PageController();
  final _controllerPageBeriRole = PageController();
  final _controllerPageBuatRole = PageController();
  final _controllerPageEditRole = PageController();
  final _controllerPageDetailRole = PageController();
  final _controllerPageAbsensi = PageController();
  final _controllerPageDetailAbsensi = PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerPageAnggota.dispose();
    _controllerPageRole.dispose();
    _controllerPageBeriRole.dispose();
    _controllerPageBuatRole.dispose();
    _controllerPageEditRole.dispose();
    _controllerPageDetailRole.dispose();
    _controllerPageAbsensi.dispose();
    _controllerPageDetailAbsensi.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controllerPageAnggota,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        PageView(
          controller: _controllerPageBeriRole,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            PageView(
              controller: _controllerPageRole,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                AdminAnggotaPage(
                  controllerPageAnggota: _controllerPageAnggota,
                  controllerPageRole: _controllerPageRole,
                  controllerPageBeriRole: _controllerPageBeriRole,
                ),
                PageView(
                  controller: _controllerPageBuatRole,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    PageView(
                      controller: _controllerPageEditRole,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        PageView(
                          controller: _controllerPageDetailRole,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            AdminRolePage(
                              controllerPageRole: _controllerPageRole,
                              controllerPageBuatRole: _controllerPageBuatRole,
                              controllerPageEditRole: _controllerPageEditRole,
                              controllerPageDetailRole:
                                  _controllerPageDetailRole,
                            ),
                            AdminDetailRole(
                                controllerPageDetailRole:
                                    _controllerPageDetailRole)
                          ],
                        ),
                        AdminEditRole(
                            controllerPageEditRole: _controllerPageEditRole)
                      ],
                    ),
                    AdminBuatRole(
                        controllerPageBuatRole: _controllerPageBuatRole)
                  ],
                ),
              ],
            ),
            AdminBeriRole(controllerPageBeriRole: _controllerPageBeriRole),
          ],
        ),
        PageView(
          controller: _controllerPageDetailAbsensi,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            AdminAbsensiPage(
              controllerPageAnggota: _controllerPageAnggota,
              controllerPageDetailAbsen: _controllerPageDetailAbsensi,
            ),
            AdminDetailAbsen(
                controllerPageDetailAbsen: _controllerPageDetailAbsensi)
          ],
        ),
      ],
    );
  }
}

class AdminAnggotaPage extends StatefulWidget {
  final PageController controllerPageAnggota;
  final PageController controllerPageRole;
  final PageController controllerPageBeriRole;
  const AdminAnggotaPage(
      {Key? key,
      required this.controllerPageAnggota,
      required this.controllerPageRole,
      required this.controllerPageBeriRole})
      : super(key: key);

  @override
  State<AdminAnggotaPage> createState() => _AdminAnggotaPageState();
}

class _AdminAnggotaPageState extends State<AdminAnggotaPage> {
  ServicesUser servicesUser = ServicesUser();

  late Future listUser;

  final _controllerSearch = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    listUser = servicesUser.getAllUser(kodeGereja);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerSearch.dispose();
    super.dispose();
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
            Container(
              padding: const EdgeInsets.all(0),
              width: deviceWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  responsiveText("Anggota", 26, FontWeight.w900, darkText),
                  const Divider(
                    height: 56,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: deviceWidth * 0.4,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            controller: _controllerSearch,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: surfaceColor,
                              labelText: 'Cari nama anggota',
                              labelStyle: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                              ),
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                color: navButtonPrimary.withOpacity(0.5),
                              ),
                              suffix: IconButton(
                                onPressed: () {
                                  _controllerSearch.clear();
                                },
                                icon: Icon(
                                  Icons.clear,
                                  color: navButtonPrimary.withOpacity(0.5),
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 25),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: navButtonPrimary.withOpacity(0.5),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: navButtonPrimary.withOpacity(0.5),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: navButtonPrimary.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                        ),
                        onPressed: () {
                          widget.controllerPageRole.animateToPage(1,
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.ease);
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.add),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Role"),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                        ),
                        onPressed: () {
                          widget.controllerPageAnggota.animateToPage(1,
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.ease);
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.add),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Absensi"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
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
                  child: SafeArea(
                    child: FutureBuilder(
                      future: listUser,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List snapData = snapshot.data! as List;
                          if (snapData[0] != 404) {
                            return ScrollConfiguration(
                              behavior:
                                  ScrollConfiguration.of(context).copyWith(
                                dragDevices: {
                                  PointerDeviceKind.touch,
                                  PointerDeviceKind.mouse,
                                },
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                controller: ScrollController(),
                                physics: const ClampingScrollPhysics(),
                                itemCount: snapData[1].length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color:
                                            navButtonPrimary.withOpacity(0.5),
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: ListTile(
                                      leading: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(360),
                                        child: const CircleAvatar(
                                          foregroundImage: AssetImage(
                                              "lib/assets/images/defaultprofilepicture.png"),
                                        ),
                                      ),
                                      title: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapData[1][index]
                                                    ['nama_lengkap_user'],
                                                style: GoogleFonts.nunito(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                  color: darkText,
                                                ),
                                              ),
                                              Text(
                                                "Role: ${snapData[1][index]['kode_role']}",
                                                style: GoogleFonts.nunito(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color:
                                                      darkText.withOpacity(0.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          TextButton(
                                            onPressed: () {
                                              _kodeUser = snapData[1][index]
                                                  ['kode_user'];
                                              _namaUser = snapData[1][index]
                                                  ['nama_lengkap_user'];
                                              widget.controllerPageBeriRole
                                                  .animateToPage(1,
                                                      duration: const Duration(
                                                          milliseconds: 250),
                                                      curve: Curves.ease);
                                              debugPrint(
                                                "$_kodeUser, $_namaUser",
                                              );
                                            },
                                            child: Text(
                                              "Beri Role",
                                              style: GoogleFonts.nunito(
                                                color: primaryColorVariant,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 25,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              debugPrint(
                                                index.toString(),
                                              );
                                            },
                                            icon: const Icon(
                                                Icons.delete_rounded),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        }
                        return loadingIndicator(primaryColorVariant);
                      },
                    ),
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

class AdminBeriRole extends StatefulWidget {
  final PageController controllerPageBeriRole;
  const AdminBeriRole({Key? key, required this.controllerPageBeriRole})
      : super(key: key);

  @override
  State<AdminBeriRole> createState() => _AdminBeriRoleState();
}

class _AdminBeriRoleState extends State<AdminBeriRole> {
  ServicesUser servicesUser = ServicesUser();
  late Future role;
  List<String> roleList = List.empty(growable: true);
  List<String> KodeRoleList = List.empty(growable: true);
  @override
  void initState() {
    // TODO: implement initState
    role = servicesUser.getRole(kodeGereja);
    getRole(kodeGereja);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future getRole(kodeGereja) async {
    var response = await servicesUser.getRole(kodeGereja);
    if (response[0] != 404) {
      for (var element in response[1]) {
        roleList.add(element['nama_role']);
        KodeRoleList.add(element['kode_role']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Image(
              width: deviceWidth < 800
                  ? (deviceHeight * 0.6)
                  : (deviceWidth * 0.4),
              image: const AssetImage("lib/assets/images/role.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        widget.controllerPageBeriRole.animateToPage(0,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.ease);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    responsiveText("Beri Role", 26, FontWeight.w900, darkText),
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
                      child: SizedBox(
                        width: deviceWidth * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            responsiveText(
                                _namaUser, 22, FontWeight.w700, darkText),
                            const SizedBox(height: 25),
                            Card(
                              child: DropdownSearch(
                                items: roleList,
                                onChanged: (val) {
                                  for (int i = 0; i < roleList.length; i++) {
                                    if (roleList[i] == val) {
                                      debugPrint(KodeRoleList[i].toString());
                                    }
                                  }
                                },
                                selectedItem: "Pilih Role",
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text("Simpan"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//TODO: Role Page
class AdminRolePage extends StatefulWidget {
  final PageController controllerPageRole;
  final PageController controllerPageBuatRole;
  final PageController controllerPageEditRole;
  final PageController controllerPageDetailRole;
  const AdminRolePage(
      {Key? key,
      required this.controllerPageRole,
      required this.controllerPageBuatRole,
      required this.controllerPageEditRole,
      required this.controllerPageDetailRole})
      : super(key: key);

  @override
  State<AdminRolePage> createState() => _AdminRolePageState();
}

class _AdminRolePageState extends State<AdminRolePage> {
  ServicesUser servicesUser = ServicesUser();
  late Future role;
  @override
  void initState() {
    // TODO: implement initState
    role = servicesUser.getRole(kodeGereja);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Image(
              width: deviceWidth < 800
                  ? (deviceHeight * 0.6)
                  : (deviceWidth * 0.4),
              image: const AssetImage("lib/assets/images/role.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        widget.controllerPageRole.animateToPage(0,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.ease);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    responsiveText("Buat Role", 26, FontWeight.w900, darkText),
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
                      child: SizedBox(
                        width: deviceWidth * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    widget.controllerPageBuatRole.animateToPage(
                                        1,
                                        duration:
                                            const Duration(milliseconds: 250),
                                        curve: Curves.ease);
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(Icons.add),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Buat Role"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            responsiveText(
                                "Privilege", 16, FontWeight.w700, darkText),
                            const SizedBox(
                              height: 25,
                            ),
                            FutureBuilder(
                              future: role,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List snapData = snapshot.data! as List;
                                  if (snapData[0] != 404) {
                                    return ScrollConfiguration(
                                      behavior: ScrollConfiguration.of(context)
                                          .copyWith(
                                        dragDevices: {
                                          PointerDeviceKind.touch,
                                          PointerDeviceKind.mouse,
                                        },
                                      ),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        controller: ScrollController(),
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: snapData[1].length,
                                        itemBuilder: (context, index) {
                                          return SizedBox(
                                            width: deviceWidth * 0.7,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: navButtonPrimary
                                                      .withOpacity(0.5),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: ListTile(
                                                title: Row(
                                                  children: [
                                                    Text(
                                                      snapData[1][index]
                                                          ['nama_role'],
                                                      style: GoogleFonts.nunito(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16,
                                                        color: darkText,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    IconButton(
                                                      onPressed: () {
                                                        _kodeRole = snapData[1]
                                                                    [index]
                                                                ['kode_role']
                                                            .toString();
                                                        widget
                                                            .controllerPageEditRole
                                                            .animateToPage(1,
                                                                duration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            250),
                                                                curve: Curves
                                                                    .ease);
                                                        debugPrint(
                                                          _kodeRole.toString(),
                                                        );
                                                      },
                                                      icon: const Icon(
                                                          Icons.edit),
                                                    ),
                                                    const SizedBox(
                                                      width: 25,
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        debugPrint(
                                                          index.toString(),
                                                        );
                                                      },
                                                      icon: const Icon(
                                                          Icons.delete_rounded),
                                                    ),
                                                    const SizedBox(
                                                      width: 25,
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12),
                                                        shape:
                                                            const CircleBorder(),
                                                      ),
                                                      onPressed: () {
                                                        _kodeRole = snapData[1]
                                                                    [index]
                                                                ['kode_role']
                                                            .toString();
                                                        widget
                                                            .controllerPageDetailRole
                                                            .animateToPage(1,
                                                                duration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            250),
                                                                curve: Curves
                                                                    .ease);
                                                        debugPrint(
                                                          _kodeRole.toString(),
                                                        );
                                                      },
                                                      child: const Icon(Icons
                                                          .arrow_forward_rounded),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                }
                                return loadingIndicator(primaryColorVariant);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//TODO: Role Page
class AdminBuatRole extends StatefulWidget {
  final PageController controllerPageBuatRole;
  const AdminBuatRole({Key? key, required this.controllerPageBuatRole})
      : super(key: key);

  @override
  State<AdminBuatRole> createState() => _AdminBuatRoleState();
}

class _AdminBuatRoleState extends State<AdminBuatRole> {
  ServicesUser servicesUser = ServicesUser();
  final _controllerNamaRole = TextEditingController();
  final List _roleList = [
    ['Baca', false],
    ['Input', false],
    ['Hapus', false],
    ['Sunting', false],
    ['Unduh', false],
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerNamaRole.dispose();
    super.dispose();
  }

  responsiveTextField(deviceWidth, deviceHeight, controllerText) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: navButtonPrimary.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: SizedBox(
        width: deviceWidth < 800 ? deviceWidth : deviceWidth * 0.5,
        child: TextField(
          controller: controllerText,
          autofocus: false,
          decoration: InputDecoration(
            filled: true,
            fillColor: surfaceColor,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Image(
              width: deviceWidth < 800
                  ? (deviceHeight * 0.6)
                  : (deviceWidth * 0.4),
              image: const AssetImage("lib/assets/images/role.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        widget.controllerPageBuatRole.animateToPage(0,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.ease);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    responsiveText("Buat Role", 26, FontWeight.w900, darkText),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          responsiveText("Nama", 16, FontWeight.w700, darkText),
                          const SizedBox(
                            height: 16,
                          ),
                          responsiveTextField(
                              deviceWidth, deviceHeight, _controllerNamaRole),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: deviceWidth < 800
                                ? deviceWidth
                                : deviceWidth * 0.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    responsiveText("Privilege", 16,
                                        FontWeight.w700, darkText),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    SizedBox(
                                      width: deviceWidth < 800
                                          ? deviceWidth * 0.44
                                          : deviceWidth * 0.22,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        controller: ScrollController(),
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: _roleList.length,
                                        itemBuilder: (context, index) {
                                          return CheckboxListTile(
                                            checkboxShape:
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            title: Card(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: navButtonPrimary
                                                      .withOpacity(0.5),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 10),
                                                child: Text(
                                                  _roleList[index][0],
                                                ),
                                              ),
                                            ),
                                            value: _roleList[index][1],
                                            onChanged: (e) {
                                              _roleList[index][1] = e;
                                              setState(() {});
                                              debugPrint(e.toString());
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    responsiveText("Kategori", 16,
                                        FontWeight.w700, darkText),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    SizedBox(
                                      width: deviceWidth < 800
                                          ? deviceWidth * 0.44
                                          : deviceWidth * 0.22,
                                      child: FutureBuilder(
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            List snapData =
                                                snapshot.data! as List;
                                            if (snapData[0] != 404) {
                                              return ScrollConfiguration(
                                                behavior:
                                                    ScrollConfiguration.of(
                                                            context)
                                                        .copyWith(
                                                  dragDevices: {
                                                    PointerDeviceKind.touch,
                                                    PointerDeviceKind.mouse,
                                                  },
                                                ),
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  controller:
                                                      ScrollController(),
                                                  physics:
                                                      const ClampingScrollPhysics(),
                                                  itemCount: _roleList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return CheckboxListTile(
                                                      checkboxShape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      title: Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                            color:
                                                                navButtonPrimary
                                                                    .withOpacity(
                                                                        0.5),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      16,
                                                                  vertical: 10),
                                                          child: Text(
                                                            _roleList[index][0],
                                                          ),
                                                        ),
                                                      ),
                                                      value: _roleList[index]
                                                          [1],
                                                      onChanged: (e) {
                                                        _roleList[index][1] = e;
                                                        setState(() {});
                                                        debugPrint(
                                                            e.toString());
                                                      },
                                                    );
                                                  },
                                                ),
                                              );
                                            }
                                          }
                                          return FittedBox(
                                            child: loadingIndicator(
                                                primaryColorVariant),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text("SIMPAN"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AdminEditRole extends StatefulWidget {
  final PageController controllerPageEditRole;
  const AdminEditRole({Key? key, required this.controllerPageEditRole})
      : super(key: key);

  @override
  State<AdminEditRole> createState() => _AdminEditRoleState();
}

class _AdminEditRoleState extends State<AdminEditRole> {
  ServicesUser servicesUser = ServicesUser();
  final _controllerNamaRole = TextEditingController();
  final List _roleList = [
    ['Baca', false],
    ['Input', false],
    ['Hapus', false],
    ['Sunting', false],
    ['Unduh', false],
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerNamaRole.dispose();
    super.dispose();
  }

  responsiveTextField(deviceWidth, deviceHeight, controllerText) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: navButtonPrimary.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: SizedBox(
        width: deviceWidth < 800 ? deviceWidth : deviceWidth * 0.5,
        child: TextField(
          controller: controllerText,
          autofocus: false,
          decoration: InputDecoration(
            filled: true,
            fillColor: surfaceColor,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Image(
              width: deviceWidth < 800
                  ? (deviceHeight * 0.6)
                  : (deviceWidth * 0.4),
              image: const AssetImage("lib/assets/images/role.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        widget.controllerPageEditRole.animateToPage(0,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.ease);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    responsiveText("Edit Role", 26, FontWeight.w900, darkText),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          responsiveText("Nama", 16, FontWeight.w700, darkText),
                          const SizedBox(
                            height: 16,
                          ),
                          responsiveTextField(
                              deviceWidth, deviceHeight, _controllerNamaRole),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: deviceWidth < 800
                                ? deviceWidth
                                : deviceWidth * 0.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    responsiveText("Privilege", 16,
                                        FontWeight.w700, darkText),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    SizedBox(
                                      width: deviceWidth < 800
                                          ? deviceWidth * 0.44
                                          : deviceWidth * 0.22,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        controller: ScrollController(),
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: _roleList.length,
                                        itemBuilder: (context, index) {
                                          return CheckboxListTile(
                                            checkboxShape:
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            title: Card(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: navButtonPrimary
                                                      .withOpacity(0.5),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 10),
                                                child: Text(
                                                  _roleList[index][0],
                                                ),
                                              ),
                                            ),
                                            value: _roleList[index][1],
                                            onChanged: (e) {
                                              _roleList[index][1] = e;
                                              setState(() {});
                                              debugPrint(e.toString());
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    responsiveText("Kategori", 16,
                                        FontWeight.w700, darkText),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    SizedBox(
                                      width: deviceWidth < 800
                                          ? deviceWidth * 0.44
                                          : deviceWidth * 0.22,
                                      child: FutureBuilder(
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            List snapData =
                                                snapshot.data! as List;
                                            if (snapData[0] != 404) {
                                              return ScrollConfiguration(
                                                behavior:
                                                    ScrollConfiguration.of(
                                                            context)
                                                        .copyWith(
                                                  dragDevices: {
                                                    PointerDeviceKind.touch,
                                                    PointerDeviceKind.mouse,
                                                  },
                                                ),
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  controller:
                                                      ScrollController(),
                                                  physics:
                                                      const ClampingScrollPhysics(),
                                                  itemCount: _roleList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return CheckboxListTile(
                                                      checkboxShape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      title: Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                            color:
                                                                navButtonPrimary
                                                                    .withOpacity(
                                                                        0.5),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      16,
                                                                  vertical: 10),
                                                          child: Text(
                                                            _roleList[index][0],
                                                          ),
                                                        ),
                                                      ),
                                                      value: _roleList[index]
                                                          [1],
                                                      onChanged: (e) {
                                                        _roleList[index][1] = e;
                                                        setState(() {});
                                                        debugPrint(
                                                            e.toString());
                                                      },
                                                    );
                                                  },
                                                ),
                                              );
                                            }
                                          }
                                          return FittedBox(
                                            child: loadingIndicator(
                                                primaryColorVariant),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text("SIMPAN"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AdminDetailRole extends StatefulWidget {
  final PageController controllerPageDetailRole;
  const AdminDetailRole({Key? key, required this.controllerPageDetailRole})
      : super(key: key);

  @override
  State<AdminDetailRole> createState() => _AdminDetailRoleState();
}

class _AdminDetailRoleState extends State<AdminDetailRole> {
  ServicesUser servicesUser = ServicesUser();
  final _controllerNamaRole = TextEditingController();
  final List _roleList = [
    ['Baca', false],
    ['Input', false],
    ['Hapus', false],
    ['Sunting', false],
    ['Unduh', false],
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerNamaRole.dispose();
    super.dispose();
  }

  responsiveTextField(deviceWidth, deviceHeight, controllerText, rOnly) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: navButtonPrimary.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: SizedBox(
        width: deviceWidth < 800 ? deviceWidth : deviceWidth * 0.5,
        child: TextField(
          readOnly: rOnly,
          controller: controllerText,
          autofocus: false,
          decoration: InputDecoration(
            filled: true,
            fillColor: surfaceColor,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Image(
              width: deviceWidth < 800
                  ? (deviceHeight * 0.6)
                  : (deviceWidth * 0.4),
              image: const AssetImage("lib/assets/images/role.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        widget.controllerPageDetailRole.animateToPage(0,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.ease);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    responsiveText(
                        "Detail Role", 26, FontWeight.w900, darkText),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          responsiveText("Nama", 16, FontWeight.w700, darkText),
                          const SizedBox(
                            height: 16,
                          ),
                          responsiveTextField(deviceWidth, deviceHeight,
                              _controllerNamaRole, true),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: deviceWidth < 800
                                ? deviceWidth
                                : deviceWidth * 0.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    responsiveText("Privilege", 16,
                                        FontWeight.w700, darkText),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    SizedBox(
                                      width: deviceWidth < 800
                                          ? deviceWidth * 0.44
                                          : deviceWidth * 0.22,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        controller: ScrollController(),
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: _roleList.length,
                                        itemBuilder: (context, index) {
                                          return CheckboxListTile(
                                            checkboxShape:
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            title: Card(
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: navButtonPrimary
                                                      .withOpacity(0.5),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 10),
                                                child: Text(
                                                  _roleList[index][0],
                                                ),
                                              ),
                                            ),
                                            value: _roleList[index][1],
                                            onChanged: null,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    responsiveText("Kategori", 16,
                                        FontWeight.w700, darkText),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    SizedBox(
                                      width: deviceWidth < 800
                                          ? deviceWidth * 0.44
                                          : deviceWidth * 0.22,
                                      child: FutureBuilder(
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            List snapData =
                                                snapshot.data! as List;
                                            if (snapData[0] != 404) {
                                              return ScrollConfiguration(
                                                behavior:
                                                    ScrollConfiguration.of(
                                                            context)
                                                        .copyWith(
                                                  dragDevices: {
                                                    PointerDeviceKind.touch,
                                                    PointerDeviceKind.mouse,
                                                  },
                                                ),
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  controller:
                                                      ScrollController(),
                                                  physics:
                                                      const ClampingScrollPhysics(),
                                                  itemCount: _roleList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return CheckboxListTile(
                                                      checkboxShape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      title: Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                            color:
                                                                navButtonPrimary
                                                                    .withOpacity(
                                                                        0.5),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      16,
                                                                  vertical: 10),
                                                          child: Text(
                                                            _roleList[index][0],
                                                          ),
                                                        ),
                                                      ),
                                                      value: _roleList[index]
                                                          [1],
                                                      onChanged: null,
                                                    );
                                                  },
                                                ),
                                              );
                                            }
                                          }
                                          return FittedBox(
                                            child: loadingIndicator(
                                                primaryColorVariant),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text("SIMPAN"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//TODO: Absensi Page
class AdminAbsensiPage extends StatefulWidget {
  final PageController controllerPageAnggota;
  final PageController controllerPageDetailAbsen;
  const AdminAbsensiPage(
      {Key? key,
      required this.controllerPageAnggota,
      required this.controllerPageDetailAbsen})
      : super(key: key);

  @override
  State<AdminAbsensiPage> createState() => _AdminAbsensiPageState();
}

class _AdminAbsensiPageState extends State<AdminAbsensiPage> {
  ServicesUser servicesUser = ServicesUser();
  late Future role;

  final _controllerNamaAbsen = TextEditingController();

  var stateOfDisable = true;
  DateTime selectedDate = DateTime.now();
  String formattedDate = "";
  String date = "Date";

  @override
  void initState() {
    // TODO: implement initState
    role = servicesUser.getRole(kodeGereja);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerNamaAbsen.dispose();
    super.dispose();
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
        stateOfDisable = false;
        debugPrint("Selected Date From $selectedDate");

        setState(() {});
      }
    }
  }

  responsiveTextField(deviceWidth, deviceHeight, controllerText) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: navButtonPrimary.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: SizedBox(
        width: deviceWidth,
        child: TextField(
          controller: controllerText,
          autofocus: false,
          decoration: InputDecoration(
            filled: true,
            fillColor: surfaceColor,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showBuatAbsenDialog(dw, dh) {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
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
                  child: SizedBox(
                    width: dw * 0.8,
                    child: Column(
                      children: [
                        Container(
                          width: dw * 0.8,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              responsiveText(
                                  "Buat Absen", 26, FontWeight.w700, darkText),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              responsiveText("Nama Absensi", 16,
                                  FontWeight.w700, darkText),
                              const SizedBox(height: 16),
                              responsiveTextField(dw, dh, _controllerNamaAbsen),
                              const SizedBox(height: 25),
                              responsiveText(
                                  "Tanggal", 16, FontWeight.w700, darkText),
                              const SizedBox(height: 16),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: Colors.black.withOpacity(0.3),
                                  ),
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
                                        icon: const Icon(Icons.calendar_month),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (mounted) {
                                    selectedDate = DateTime.now();
                                    formattedDate = "";
                                    date = "Date";
                                    setState(() {});
                                  }
                                  Navigator.pop(context);
                                },
                                child: const Text("Batal"),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (mounted) {
                                    selectedDate = DateTime.now();
                                    formattedDate = "";
                                    date = "Date";
                                    setState(() {});
                                  }

                                  Navigator.pop(context);
                                },
                                child: const Text("Tambah"),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: Image(
              width: deviceWidth < 800
                  ? (deviceHeight * 0.35)
                  : (deviceWidth * 0.35),
              image: const AssetImage("lib/assets/images/absen.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        widget.controllerPageAnggota.animateToPage(0,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.ease);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    responsiveText(
                        "Buat Absensi", 26, FontWeight.w900, darkText),
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
                      child: SizedBox(
                        width:
                            deviceWidth < 800 ? deviceWidth : deviceWidth * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    _showBuatAbsenDialog(
                                        deviceWidth, deviceHeight);
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(Icons.add),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Buat Absensi"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Colors.black.withOpacity(0.3),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: FutureBuilder(
                                  future: role,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List snapData = snapshot.data! as List;
                                      if (snapData[0] != 404) {
                                        return ScrollConfiguration(
                                          behavior:
                                              ScrollConfiguration.of(context)
                                                  .copyWith(
                                            dragDevices: {
                                              PointerDeviceKind.touch,
                                              PointerDeviceKind.mouse,
                                            },
                                          ),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            controller: ScrollController(),
                                            physics:
                                                const ClampingScrollPhysics(),
                                            itemCount: snapData[1].length,
                                            itemBuilder: (context, index) {
                                              return SizedBox(
                                                width: deviceWidth * 0.7,
                                                child: Card(
                                                  color:
                                                      scaffoldBackgroundColor,
                                                  child: ListTile(
                                                    title: Row(
                                                      children: [
                                                        Text(
                                                          "Tanggal",
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 16,
                                                            color: darkText,
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        responsiveText(
                                                            "Absen ${index + 1}",
                                                            16,
                                                            FontWeight.w700,
                                                            darkText),
                                                        const Spacer(),
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(12),
                                                            shape:
                                                                const CircleBorder(),
                                                          ),
                                                          onPressed: () {
                                                            widget.controllerPageDetailAbsen
                                                                .animateToPage(
                                                                    1,
                                                                    duration: const Duration(
                                                                        milliseconds:
                                                                            250),
                                                                    curve: Curves
                                                                        .ease);
                                                          },
                                                          child: const Icon(Icons
                                                              .arrow_forward_rounded),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      }
                                    }
                                    return loadingIndicator(
                                        primaryColorVariant);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AdminDetailAbsen extends StatefulWidget {
  final PageController controllerPageDetailAbsen;
  const AdminDetailAbsen({Key? key, required this.controllerPageDetailAbsen})
      : super(key: key);

  @override
  State<AdminDetailAbsen> createState() => _AdminDetailAbsenState();
}

class _AdminDetailAbsenState extends State<AdminDetailAbsen> {
  ServicesUser servicesUser = ServicesUser();
  late Future role;

  @override
  void initState() {
    // TODO: implement initState
    role = servicesUser.getRole(kodeGereja);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: Image(
              width: deviceWidth < 800
                  ? (deviceHeight * 0.4)
                  : (deviceWidth * 0.4),
              image: const AssetImage("lib/assets/images/absen.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        widget.controllerPageDetailAbsen.animateToPage(0,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.ease);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    responsiveText(
                        "Detail Absensi", 26, FontWeight.w900, darkText),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          responsiveText(
                              "Absen", 22, FontWeight.w700, darkText),
                          const SizedBox(height: 16),
                          responsiveText(
                              "Tanggal", 16, FontWeight.w700, darkText),
                          const SizedBox(height: 16),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: FutureBuilder(
                                future: role,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List snapData = snapshot.data! as List;
                                    if (snapData[0] != 404) {
                                      return ScrollConfiguration(
                                        behavior:
                                            ScrollConfiguration.of(context)
                                                .copyWith(
                                          dragDevices: {
                                            PointerDeviceKind.touch,
                                            PointerDeviceKind.mouse,
                                          },
                                        ),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          controller: ScrollController(),
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: snapData[1].length,
                                          itemBuilder: (context, index) {
                                            return Card(
                                              color:
                                                  scaffoldBackgroundColor,
                                              child: ListTile(
                                                title: Row(
                                                  children: [
                                                    Text(
                                                      "Nama",
                                                      style: GoogleFonts
                                                          .nunito(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16,
                                                        color: darkText,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    ToggleSwitch(
                                                      minWidth: 40,
                                                      initialLabelIndex: 0,
                                                      cornerRadius: 10,
                                                      activeFgColor:
                                                          Colors.white,
                                                      inactiveBgColor:
                                                          surfaceColor,
                                                      inactiveFgColor:
                                                          Colors.white,
                                                      totalSwitches: 2,
                                                      activeBgColors: [
                                                        [
                                                          Colors.grey
                                                              .withOpacity(
                                                                  0.5)
                                                        ],
                                                        [
                                                          correctColor
                                                              .withOpacity(
                                                                  0.8),
                                                        ],
                                                      ],
                                                      onToggle: (index) {
                                                        debugPrint(
                                                            'switched to: $index');
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  }
                                  return loadingIndicator(
                                      primaryColorVariant);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
