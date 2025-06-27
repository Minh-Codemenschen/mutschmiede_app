// ignore_for_file: file_names, constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';

class AppConstants {
  static const txt_incorporationwith = "in Kooperation mit";
  static const txt_entercode = "Enter Code";
  static const txt_bestatigen = "Passwort bestätigen";
  static const txt_Passwort = "Passwort";
  static const txt_Email = "Email";
  static const txt_Nachname = "Nachname";
  static const txt_Vorname = "Vorname";
  static const txt_infotitle =
      "Stichwort:\nCommerzbankHilft DE53 600 500 400 600 400 500";
  static const txt_login = "LOGIN";
  static const txt_QrCode = "Melden Sie sich mit QR Code an";
  static const font_family = "Raleway";
  static const font_Montag = " Montag, 28.02.2022, 14:00\n Call Ringana";
  static const font_Donnerstag = "Donnerstag, 03.03.2022, 14:00 Nina Irgendwas";
  static const font_Cheeseburger =
      "Montag, 28.02.2022 Kürbiscremesuppe Chilli sin Carne Cheeseburger mit Pommes";
  static const txt_log_in = "Log In";
  static const txt_Registrieren = "Registrieren";
  static const txt_userpro = "\nweiblich";
  static const txt_userpro1 = "\nMarketing";
  static const txt_userpro2 = "\nGraz";
  static const txt_reg =
      "Ich stimme den Datenschutzbestimmungen dieser\nApp zu - nochmal abklären was da genau stehen muss";
  static const txt_infosub =
      "Der Spendenaufruf ist weiterhin aktuelle und wir freuen\nuns weiterhin für Ihre Unterstützung:";
  static const txt_info =
      "Im Rahmen unserer firmeninternen als auch -externen Spendenaktion konnten wir eine stolze Summe von 750.000 Euro sammeln. Wir freuen uns sehr die Humanitäre Hilfe in der Ukraine mit finanziellen Mitteln zu unterstützen und möchten uns Herzlich bei allen BIm Rahmen unserer firmeninternen als auch -externen Beteiligten bedanken.";
  static const txt_Marketingteam =
      "Ich bin Lena und arbeite seit Mai 2016 im Marketingteam. In meiner Freizeit gehe ich gerne laufen und schwimmen.";
  static const txtAusgabe =
      "„Sei eine erstklassige Ausgabe Deiner selbst - keine zweitklassige von jemandem anderen.“ Judy Garland\n\n„Große Veränderungen in unserem Leben können eine zweite Chance sein.“ Harrison Ford\nn„Die Qualität unserer Ziele bestimmt die Qualität unserer Zukunft.“  Unbekannt\n\n „Unsere Wünsche sind die Vorboten der Fähigkeiten, die in uns liegen.“ Goethe\n\n Sie Du selbst, alle anderen gibt es schon.";
  static const txtMeinesub =
      "• Selbstmanagement\n• Frauen in der Führungsrolle\n• Vertriebstraining (Einzeln und Gruppe)\n• wertschätzende,zielgerichtete\n  Kommunikation\n• Zeitmanagement\n• Persönlichkeitsentwicklung\n• Veranderungsmanagement\n• Teamentwicklung";
  static const txtMeine = "Meine Schwerpunkte:";
  static const txtWillkommen = "Willkommen bei der Mutschmiede!";
  static const txtWillkommensub =
      "Als Coach bin ich überzeugt, dass Sie alles, was Sie für das Erreichen Ihrer Ziele benötigen bereits in sich tragen. Deshalb sehe ich es als meine Aufgabe, Sie bei Ihrer Weiterentwicklung zu begleiten und mit Ihnen gemeinsam Ihre Träume - Wünsche und Visionen als erreichbare Ziele zu gestalten. In meinen Coachings konzentrieren wir uns auf Ihre Stärken und Fähigkeiten - wir entwickeln gemeinsam Ihre neuen Sicht- und Handlungsweisen. Mit mir gemeinsam stärken Sie Ihr Selbstbild und räumen damit Hindernisse aus Ihrem Weg. Damit finden Sie Klarheit und daraus resultiert Ihr Erfolg und Ihr neues Lebensgefühl.\nIch arbeite mit Ihnen lösungsorientiert, methodenübergreifend, individuell und persönlichkeitsbezogen";
  static const txt_uber =
      "Über 10 Jahre Erfahrung im Bereich Kommunikation und Persönlichkeit in den Bereichen Health-Care, im Finanzsektor mit Schwerpunkt Vertrieb sowie im Business Development im Bereich Manufacturing.";
  static const txt_zuruck =
      "Es steht mal wieder unser monatlicher Call an. Bitte Entsprechende Unterlagen vorbereiten. Anbei schon Mal die Termineinladung. Teams Link folgt! LG Daniel";
  static const txt_nointernet = "Internet Connection not Available!";
  static const txt_somethingwrong =
      "Es ist ein Fehler aufgetreten. Bitte versuchen Sie es später noch einmal!";
  static const txt_plzentercode = "Please enter Code";
  static const txt_Nocoach = "Kein Bus verfügbar!";
  static const txt_NoPartners = "Keine Kooperationspartner verfügbar!!";
  static const txt_Noevents = "Keine Veranstaltungen verfügbar!";
  static const IS_LOGGED_IN = "is_logged_in";
  static const VOUCHER_NUMBER = "voucher_no";
  static const Phone_Number = "Not add User Mobile Number";
  static const LOGO_URL = "logo_url";
  static const COMPANY_NAME = "company_name";
  static const LABEL_CALL = "TERMINEINLADUNG";
  static const LABEL_FACE2FACE_CALL = "FACE-2-FACE COACHING";
  static const LABEL_MENU = "Mittagsmenü";
  static const LABEL_MENU1 = "Mittagsmenu";
  static const LABEL_CANCEL = "ABSAGEN";
  static const LABEL_ACCEPT = "ZUSAGEN";
  static const LABEL_ATTENDEES = "Teilnehmer";
  static const LABEL_LOCATION = "Ort";
  static const LABEL_MESSAGE = "Persönliche Nachricht:";
  static const LABEL_CONTINUE_MESSAGE =
      "Sind Sie sicher, dass Sie weitermachen wollen?";
  static const LABEL_LOGOUT_MESSAGE = "Möchten Sie sich wirklich abmelden?";
  static const LABEL_LOGOUT = "Ausloggen";
  static const LABEL_YES = "Ja";
  static const LABEL_NO = "Nein";
  static const mailTo = "office@mutschmiede.com";
  static const subject = "Anfrage von der mutschmiede-App!";
  static const nachricht = 'Nachricht';
  static const sprachprobe = 'Sprachprobe';
  static const meine = "Meine Schwerpunkte:";
  static Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
//
// class AppFonts {
//   static const primaryFont = "Montserrat";
// }

var mainGrd = [AppColors.primaryColor, AppColors.secondaryColor];

class AppColors {
  static var primaryColor = fromHex("#fbc7b2");
  static var secondaryColor = fromHex("#116FB9");
  static var iconColor = fromHex("#d0d0d0");
  static var appColors = fromHex("#fbc7b2");
  static var bgColor = fromHex("#efefef");
  static var btncolor = fromHex("#a6bea5");
}

Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

class AppImages {
  static const icn_NameLogo = "assets/logomain.png";
  static const icn_Logo = "assets/nameLogo.png";
  static const icn_loudspeaker = "assets/loudspeaker.png.png";
  static const icn_branddummy = "assets/brandingicondummy.png";
  static const icn_iconuserhome = "assets/userdashboard.png";
  static const icn_remember = "assets/remembar.png";
  static const icn_iconplushome = "assets/plusdashboard.png";
  static const icn_michaeldammEZ = "assets/michaeldammEZ.png";
  static const icn_benparkerym = "assets/benparkerym.png";
  static const icn_juricakoletic = "assets/juricakoletic.png";
  static const icn_icons = "assets/icons.png";
  static const icn_icon = "assets/icon2.png";
  static const icn_stroop = "assets/stroop.png";
  static const icn_icon1 = "assets/icon.png";
  static const icn_jake = "assets/jake.png";
  static const icn_man = "assets/man.png";
  static const icn_man1 = "assets/man1.png";
  static const icn_mustrfirma = "assets/mustrfirma.png";
  static const icn_mustrfirma1 = "assets/mustrfirma1.png";
  static const icn_cale = "assets/cale.png";
  static const icn_info = "assets/info.png";
  static const icn_imageicon = "assets/imageicon.png";
  static const icn_stress = "assets/stress.png";
  static const icn_stress1 = "assets/stress1.png";
  static const icn_covid = "assets/covid.png";
  static const icn_imagebg = "assets/imagebg.png";
  static const icn_termine = "assets/termine.png";
  static const icn_burger = "assets/burger.png";
  static const icn_burger1 = "assets/burger1.png";
  static const icn_face = "assets/face.png";
  static const icn_mind = "assets/mind.png";
  static const icn_donnerstag = "assets/donnerstag.png";
  static const icn_dilogbg = "assets/dilogbg.png";
  static const icn_iconremove = "assets/iconremove.png";
  static const icn_nachricht = "assets/nachricht.png";
  static const icn_teiline = "assets/teiline.png";
  static const icn_remove = "assets/remove.png";
  static const icn_roman = "assets/roman.png";
  static const icn_marketing = "assets/marketing.png";
  static const icn_familie = "assets/familie.png";
  static const icn_beziehung = "assets/beziehung.png";
  static const icn_konflikt = "assets/konflikt.png";
  static const icn_personlichkeit = "assets/persönlichkeit.png";
  static const icn_angst = "assets/angst.png";
  static const icn_unterstutzung = "assets/unterstützung.png";
  static const icn_sucht = "assets/sucht.png";
  static const icn_geldsorgen = "assets/geldsorgen.png";
  static const icn_trauer = "assets/trauer.png";
  static const icn_mobbing = "assets/mobbing.png";
  static const icn_trennung = "assets/trennung.png";
  static const icn_sexualitat = "assets/sexualität.png";
  static const icn_schule = "assets/schule.png";
  static const icn_unternehmensberatung = "assets/unternehmensberatung.png";
  static const icn_covid19 = "assets/covid-19.png";
  static const icn_pflege = "assets/pflege.png";
  static const icn_editicon = "assets/editicon.png";
  static const icn_cal = "assets/cal.png";
  static const icn_main = "assets/mainprofile.png";
  static const icn_bginfo = "assets/bginfo.png";
  static const icn_call = "assets/call.png";
  static const icn_infoicon = "assets/infoicon.png";
  static const icn_info1 = "assets/info1.png";
  static const icn_hr = "assets/hr.png";
  static const icn_one = "assets/one.png";
  static const icn_empfang = "assets/empfangicn.png";
  static const icn_hrinfo = "assets/hricn.png";
  static const icn_kantine = "assets/kantineicn.png";
  static const icn_facility = "assets/facilityicn.png";
  static const icn_play = "assets/play.png";
  static const icn_pause = "assets/pause.png";
  static const icn_disable = "assets/disable.png";
  static const icn_undo = "assets/undo.png";
  static const icn_error = "assets/img.png";
  static const icn_mail = "assets/mail.png";
  static const icn_mail1 = "assets/mail1.png";
}

class AppLinks {}
