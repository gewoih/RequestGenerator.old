object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 408
  ClientWidth = 630
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ValueListEditor1: TValueListEditor
    Left = 0
    Top = 0
    Width = 630
    Height = 408
    Align = alClient
    DefaultColWidth = 180
    Strings.Strings = (
      'FSRAR ID='
      'CLIENT ID='
      #1053#1086#1084#1077#1088' '#1079#1072#1087#1088#1086#1089#1072'='
      #1044#1072#1090#1072' '#1079#1072#1087#1088#1086#1089#1072'='
      #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100'='
      #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072'='
      #1042#1080#1076' '#1040#1055'='
      #1050#1086#1076' '#1089#1090#1088#1072#1085#1099'='
      #1055#1086#1083#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077'='
      #1050#1088#1072#1090#1082#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077'='
      #1060#1072#1089#1086#1074#1072#1085#1085#1099#1081'/'#1053#1077' '#1092#1072#1089#1086#1074#1072#1085#1085#1099#1081'='
      #1054#1073#1098#1077#1084'='
      #1055#1088#1086#1094#1077#1085#1090'='
      #1055#1088#1086#1094#1077#1085#1090' '#1084#1080#1085'.='
      #1055#1088#1086#1094#1077#1085#1090' '#1084#1072#1082#1089'.='
      'FRAP ID='
      #1041#1088#1077#1085#1076'='
      #1058#1080#1087' '#1091#1087#1072#1082#1086#1074#1082#1080'=')
    TabOrder = 0
    TitleCaptions.Strings = (
      #1055#1086#1083#1077
      #1047#1085#1072#1095#1077#1085#1080#1077)
    ExplicitLeft = 3
    ExplicitTop = 3
    ExplicitWidth = 624
    ExplicitHeight = 402
    ColWidths = (
      180
      444)
  end
  object Button1: TButton
    Left = 352
    Top = 368
    Width = 129
    Height = 32
    Caption = #1055#1088#1086#1089#1084#1086#1090#1088' XML'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 487
    Top = 368
    Width = 129
    Height = 32
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 2
    OnClick = Button2Click
  end
  object StringContainer1: TStringContainer
    Items.Strings = (
      '<?xml version="1.0" encoding="UTF-8"?>'
      
        '<ns:Documents Version="1.0" xmlns:xsi="http://www.w3.org/2001/XM' +
        'LSchema-instance" xmlns:ns= "http://fsrar.ru/WEGAIS/WB_DOC_SINGL' +
        'E_01" xmlns:rap="http://fsrar.ru/WEGAIS/RequestAddProducts">'
      #9'<ns:Owner>'
      #9#9'<ns:FSRAR_ID>%s</ns:FSRAR_ID>'
      #9'</ns:Owner>'
      #9'<ns:Document>'
      #9#9'<ns:RequestAddProducts>'
      #9#9#9'<rap:ClientId>%s</rap:ClientId>'
      #9#9#9'<rap:RequestNumber>%s</rap:RequestNumber>'
      #9#9#9'<rap:RequestDate>%s</rap:RequestDate>'
      #9#9#9'<rap:Content>'
      #9#9#9#9'<rap:Producer>%s</rap:Producer>'
      #9#9#9#9'<rap:Type>%s</rap:Type>'
      #9#9#9#9'<rap:VidCode>%s</rap:VidCode>'
      #9#9#9#9'<rap:CountryCode>%s</rap:CountryCode>'
      #9#9#9#9'<rap:FullName>%s</rap:FullName>'
      #9#9#9#9'<rap:ShortName>%s</rap:ShortName>'
      #9#9#9#9'<rap:Unpacked_Flag>%s</rap:Unpacked_Flag>'
      #9#9#9#9'<rap:Capacity>%s</rap:Capacity>'
      #9#9#9#9'<rap:PERCENT_ALC>%s</rap:PERCENT_ALC>'
      #9#9#9#9'<rap:PERCENT_ALC_min>%s</rap:PERCENT_ALC_min>'
      #9#9#9#9'<rap:PERCENT_ALC_max>%s</rap:PERCENT_ALC_max>'
      #9#9#9#9'<rap:FRAPID>%s</rap:FRAPID>'
      #9#9#9#9'<rap:Brand>%s</rap:Brand>'
      #9#9#9#9'<rap:PackageType>%s</rap:PackageType>'
      #9#9#9'</rap:Content>'
      #9#9'</ns:RequestAddProducts>'
      #9'</ns:Document>'
      '</ns:Documents>')
    Left = 40
    Top = 364
  end
end
