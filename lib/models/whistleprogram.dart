class WhistleProgram {
  String? introHeader;
  String? introTitle;
  String? introText;
  String? introTextBottom;
  String? introPhonenumber;
  String? introTextOnFormBottom;
  String? whistleblowerUrl;
  String? introPhoneTextButton;

  WhistleProgram(
      {this.introHeader,
      this.introTitle,
      this.introText,
      this.introTextBottom,
      this.introPhonenumber,
      this.introTextOnFormBottom,
      this.whistleblowerUrl,
      this.introPhoneTextButton});

  WhistleProgram.fromJson(Map<String, dynamic> json) {
    introHeader = json['intro_header'];
    introTitle = json['intro_title'];
    introText = json['intro_text'];
    introTextBottom = json['intro_text_bottom'];
    introPhonenumber = json['intro_phonenumber'];
    introTextOnFormBottom = json['intro_text_on_form_bottom'];
    whistleblowerUrl = json['whistleblower_url'];
    introPhoneTextButton = json['intro_phone_text_button'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intro_header'] = this.introHeader;
    data['intro_title'] = this.introTitle;
    data['intro_text'] = this.introText;
    data['intro_text_bottom'] = this.introTextBottom;
    data['intro_phonenumber'] = this.introPhonenumber;
    data['intro_text_on_form_bottom'] = this.introTextOnFormBottom;
    data['whistleblower_url'] = this.whistleblowerUrl;
    data['intro_phone_text_button'] = this.introPhoneTextButton;
    return data;
  }
}
