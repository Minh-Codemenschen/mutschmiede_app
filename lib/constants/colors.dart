// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'AppConstants.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: AppColor.textColorGrey,
  scaffoldBackgroundColor: AppColor.black87Color,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    background: AppColor.textColorBlack,
  ),
  textSelectionTheme: TextSelectionThemeData(cursorColor: AppColors.appColors),
);

class AppColor {
  AppColor._();

  static const Color black87Color = Colors.black87;
  static const Color blackColor = Colors.black;
  static const Color textColorWhite = Colors.white;
  static const Color textColorGrey = Colors.grey;
  static const Color textColorBlack = Colors.white;
  static const Color transparentColor = Colors.transparent;
  static const Color nearlyWhite = Color(0xFFFAFAFA);
}

List<String> DialogTextTilte = [
  "Montag, 28.02.2022",
  "Dienstag, 01.03.2022",
  "Mittwoch, 02.03.2022",
  "Donnerstag, 03.03.2022",
  "Freitag, 03.03.2022",
];
List<String> DialogTextSub = [
  "Kürbiscremesuppe € 2,90\nChilli sin Carne € 8,90\nCheeseburger mit Pommes €11,00 ",
  "Erbsen-Brokkoli-Suppe € 2,90\nChilli sin Carne € 8,90\nCheeseburger mit Pommes €11,00",
  "Erbsen-Brokkoli-Suppe € 2,90\nChilli sin Carne € 8,90\nCheeseburger mit Pommes €11,00",
  "Erbsen-Brokkoli-Suppe € 2,90\nChilli sin Carne € 8,90\nCheeseburger mit Pommes €11,00",
  "Erbsen-Brokkoli-Suppe € 2,90\nChilli sin Carne € 8,90\nCheeseburger mit Pommes €11,00",
];
List<String> Images = [
  AppImages.icn_michaeldammEZ,
  AppImages.icn_juricakoletic,
  AppImages.icn_benparkerym,
  AppImages.icn_michaeldammEZ,
  AppImages.icn_juricakoletic,
  AppImages.icn_benparkerym,
];
List<String> Data = [AppConstants.font_Montag, AppConstants.font_Donnerstag];
List<String> AssetName = [AppImages.icn_termine, AppImages.icn_donnerstag];
List<String> Time = [
  "Montag, 28.02.2022, 14:00-15:00\nCall Ringana",
  "Montag, 28.02.2022, 14:00-15:00\nEinladung von: Brigitte Neuhauser"
];
List DialogText = [
  "Teilnehmer:\nPeter Poschl, Christian Stolz, Alyssa Andritz,\nChristina Henrich, Sophie Ortmeier",
  "Ort:\nStubenberggasse 8, 8020 Graz"
];
List DialogText1 = [
  "Ort:\nStubenberggasse 8, 8020 Graz",
  "Personliche Nachricht:\nLiebe Frau Hacker, ich freue mich sehr auf unseren\nTermin. VG Brigitte Neuhauser"
];
List TeilineText = ["Raimund \n Bruger", "   Lisa \nMüller", "  Nora \n Weber"];
List TeilineTextlist = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"];

List Teilinesublist = [
  "Andreas West",
  "Brigitte Osten",
  "Clara West",
  "Dana Meier"
];
List Teilinesublist1 = ["Anna Weber", "", "Christian Weber", "Daniel Martin"];
List Teilinetitlelist = [
  "Junior-Marketing\n Managerin",
  "Junior-Marketing\nManagerin",
  "Junior-Marketing\n Managerin",
  " Junior-Marketing\n Managerin"
];
List Teilinetitlelist1 = [
  "Senior-Marketing\n Manager",
  '',
  "Senior-Marketing\nManager",
  "Senior-Marketing\n Manager"
];
List<String> CoanchImages = [
  AppImages.icn_juricakoletic,
  AppImages.icn_jake,
  AppImages.icn_man1,
  AppImages.icn_michaeldammEZ,
  AppImages.icn_man,
];
List CoanchTitle = [
  "Daniel Pöttinger ",
  "Brigitte Neuhauser",
  "Raimund Bruger",
  "Lisa Müller",
  "Alex Bannes"
];
List CoanchSub = [
  "Experte für\nLong-Covid ",
  "Experte für\nLong-Covid",
  "Experte für\nGeldsorgen",
  "Experte für\nTrennungen",
  "Experte für\nMobbing"
];
List<String> ProblemImages = [
  AppImages.icn_stress1,
  AppImages.icn_familie,
  AppImages.icn_beziehung,
  AppImages.icn_konflikt,
  AppImages.icn_personlichkeit,
  AppImages.icn_angst,
  AppImages.icn_unterstutzung,
  AppImages.icn_sucht,
  AppImages.icn_geldsorgen,
  AppImages.icn_trennung,
  AppImages.icn_mobbing,
  AppImages.icn_trauer,
  AppImages.icn_sexualitat,
  AppImages.icn_schule,
  AppImages.icn_unternehmensberatung,
  AppImages.icn_covid19,
  AppImages.icn_pflege,
];
List ProblemText = [
  " Stress",
  "Familie",
  "Beziehung",
  "Konflikt",
  "Persönlichkeit",
  "Angst",
  "Unterstützung",
  "Sucht",
  "Geldsorgen",
  "Trennung",
  "Mobbing",
  "Trauer",
  "Sexualität",
  "Schule & Studium",
  "Unternehmens-beratung",
  "Covid-19",
  "Pflege",
];
final List<String> InboxImages = <String>[
  AppImages.icn_cal,
  AppImages.icn_jake,
  AppImages.icn_man1,
  AppImages.icn_burger1,
  AppImages.icn_cal,
  AppImages.icn_face,
  AppImages.icn_man1,
  AppImages.icn_cal,
  AppImages.icn_face,
];
List<String> InboxText = [
  "14:58",
  '11:25',
  '08:22',
  'Gestern',
  'Gestern',
  'Gestern',
  'Gestern',
  'Gestern',
  'Gestern',
  'Vorgestern',
];
List<String> InboxTitle = [
  "CALL RINGANA",
  'FACE-2-FACE-COACHING',
  'FACE-2-FACE-COACHING',
  'MIITAGSMENÜ',
  'CALL MARKETING',
  'FACE-2-FACE-COACHING',
  'FACE-2-FACE-COACHING',
  'CALL MARKETING',
  'FACE-2-FACE-COACHING',
  'CALL MARKETING',
];

List<String> Inboxsub = [
  "Daniel Pöttinger\nHallo zusammen, wie besprochen hier die Einladung für den Call …",
  "Lisa Müller\nLiebe Frau Hacker,Ich freue mich schon sehr auf …",
  'Raimund Bruger\nLiebe Frau Hacker,Vielen Dank für Ihre Nachricht …',
  "Kantine Schmack\nUnser Mittagsmenü für diese Woche (28.02.-04.03.2022) …",
  "Daniel Pöttinger\nHallo zusammen, wir sollten das mal alle gemeinsam besprechen …",
  'Daniel Pöttinger\nHallo zusammen, wir sollten das mal alle gemeinsam besprechen …',
  'Raimund Bruger\nLiebe Frau Hacker,Vielen Dank für Ihre Nachricht …',
  'Daniel Pöttinger\nHallo zusammen, wir sollten das mal alle gemeinsam besprechen …',
  'Daniel Pöttinger\nHallo zusammen, wir sollten das mal alle gemeinsam besprechen …',
  'Daniel Pöttinger\nHallo zusammen, wir sollten das mal alle gemeinsam besprechen …'
];
List<String> CallTitle = [
  "17.03.2022 | 11:30 - 12:30",
  'Teilnehmer:',
  'Ort:',
  '17.03.2022 | 11:30 - 12:30',
  'Ort:',
];
List<String> CallSub = [
  "Peter Pöschl, Christian Stolz, Alyssa Andritz,Christina Henrich, Sophie Ortmeier",
  'Peter Pöschl, Christian Stolz, Alyssa Andritz,Christina Henrich, Sophie Ortmeier',
  'Peter Pöschl, Christian Stolz, Alyssa Andritz,Christina Henrich, Sophie Ortmeier',
  'Peter Pöschl, Christian Stolz, Alyssa Andritz,Christina Henrich, Sophie Ortmeier',
  'Stubenberggasse 8, 8020 Graz',
];
final List<String> InfoImages = <String>[
  AppImages.icn_empfang,
  AppImages.icn_facility,
  AppImages.icn_hrinfo,
  AppImages.icn_kantine,
];
final List<String> Infoaktu = <String>[
  AppImages.icn_info1,
  AppImages.icn_info1,
  AppImages.icn_burger,
];
final List<String> Infoaktutitle = <String>[
  "Commerzbank Hilft Ukrainie",
  "Neue Corona Schutzmaßnahmen",
  "Mittagsmenü"
];
final List<String> Infoaktusub = <String>[
  "Im Rahmen unserer firmeninternen als auch-externen Spendenaktion …",
  "Die Sicherheit unserer Mitarbeiter*innen liegt uns besonders am Herzen …",
  "Montag, 28.02.2022 Kürbiscremesuppe Chilli sin Carne Cheeseburger mit Pommes"
];
List<String> InfoTitle = [
  "Empfang",
  'Facility Management',
  'HR',
  'Kantine',
];

List<String> Infosub = [
  "0123 456789",
  '0123 456789',
  '0123 456789',
  '0123 456789',
];
List Unser = ["1", "2", "3", "4", "5", "6", "7", "8"];
List Unsertitle = [
  "Haupteingang",
  "Empfangsgebäude",
  "Markenting und PR",
  "Vorstand und\nGeschäftsleitung",
  "Kantine und Café",
  "Coworking",
  "Firmenparkplatz",
  "Park und Café"
];
