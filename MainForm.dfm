object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 541
  ClientWidth = 1103
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object RequestsTree: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 1103
    Height = 500
    AccessibleName = #1057#1090#1072#1090#1091#1089
    Align = alClient
    Alignment = taCenter
    BorderStyle = bsNone
    Colors.BorderColor = 15987699
    Colors.DisabledColor = clGray
    Colors.DropMarkColor = 15385233
    Colors.DropTargetColor = 15385233
    Colors.DropTargetBorderColor = 15987699
    Colors.FocusedSelectionColor = 15385233
    Colors.FocusedSelectionBorderColor = clWhite
    Colors.GridLineColor = 15987699
    Colors.HeaderHotColor = clBlack
    Colors.HotColor = clBlack
    Colors.SelectionRectangleBlendColor = 15385233
    Colors.SelectionRectangleBorderColor = 15385233
    Colors.SelectionTextColor = clBlack
    Colors.TreeLineColor = 9471874
    Colors.UnfocusedColor = 9694020
    Colors.UnfocusedSelectionColor = 15385233
    Colors.UnfocusedSelectionBorderColor = 15385233
    Colors.HeaderColor = 9694020
    DefaultNodeHeight = 25
    Header.AutoSizeIndex = 9
    Header.DefaultHeight = 25
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -13
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.Height = 26
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
    PopupMenu = PopupMenu1
    TabOrder = 0
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toVariableNodeHeight, toEditOnClick, toEditOnDblClick]
    TreeOptions.PaintOptions = [toHideFocusRect, toHideSelection, toShowDropmark, toShowHorzGridLines, toAlwaysHideSelection]
    OnBeforeCellPaint = RequestsTreeBeforeCellPaint
    OnGetText = RequestsTreeGetText
    ExplicitTop = -6
    ExplicitHeight = 501
    Columns = <
      item
        Alignment = taCenter
        CaptionAlignment = taCenter
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coEditable]
        Position = 0
        Width = 100
        Aggregate = False
        FilterMode = 0
        WideText = #1053#1086#1084#1077#1088
      end
      item
        Alignment = taCenter
        Position = 1
        Tag = 6
        Width = 120
        Aggregate = False
        FilterMode = 0
        WideText = #1053#1086#1084#1077#1088' '#1079#1072#1087#1088#1086#1089#1072
      end
      item
        Alignment = taCenter
        CaptionAlignment = taCenter
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coEditable]
        Position = 2
        Tag = 1
        Width = 160
        Aggregate = False
        FilterMode = 0
        WideText = #1044#1072#1090#1072
      end
      item
        CaptionAlignment = taCenter
        Color = clWindow
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment, coEditable]
        Position = 3
        Tag = 2
        Width = 400
        Aggregate = False
        FilterMode = 0
        WideText = #1053#1072#1079#1074#1072#1085#1080#1077
      end
      item
        Alignment = taCenter
        Position = 4
        Tag = 8
        Width = 80
        Aggregate = False
        FilterMode = 0
        WideText = #1054#1073#1098#1077#1084
      end
      item
        Alignment = taCenter
        Position = 5
        Tag = 9
        Width = 80
        Aggregate = False
        FilterMode = 0
        WideText = #1050#1088#1077#1087#1086#1089#1090#1100
      end
      item
        Alignment = taCenter
        Position = 6
        Tag = 3
        Width = 120
        Aggregate = False
        FilterMode = 0
        WideText = #1057#1090#1072#1090#1091#1089
      end
      item
        Alignment = taCenter
        Position = 7
        Tag = 4
        Width = 85
        Aggregate = False
        FilterMode = 0
        WideText = #1050#1086#1076' '#1040#1055
      end
      item
        Alignment = taCenter
        Position = 8
        Tag = 5
        Width = 180
        Aggregate = False
        FilterMode = 0
        WideText = #1042#1077#1088#1089#1080#1103
      end
      item
        Alignment = taCenter
        Position = 9
        Tag = 7
        Width = 10
        Aggregate = False
        FilterMode = 0
        WideText = #1054#1090#1074#1077#1090
      end>
  end
  object FlatPanel1: TFlatPanel
    Tag = 1
    Left = 0
    Top = 500
    Width = 1103
    Height = 41
    ParentColor = True
    ColorHighLight = 8623776
    ColorShadow = 8623776
    BorderColor = 8623776
    Align = alBottom
    TabOrder = 1
    UseDockManager = True
    ExplicitLeft = 88
    ExplicitTop = 504
    ExplicitWidth = 185
    object btUpdateInfo: TButton
      Left = 1
      Top = 1
      Width = 192
      Height = 39
      Align = alLeft
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '
      TabOrder = 0
      OnClick = btUpdateInfoClick
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 32
    Top = 48
    object miCreateRequest: TMenuItem
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1079#1072#1087#1088#1086#1089
      OnClick = miCreateRequestClick
    end
    object miSendRequest: TMenuItem
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1079#1072#1087#1088#1086#1089
      OnClick = miSendRequestClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object miOpenXML: TMenuItem
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088' XML'
      OnClick = miOpenXMLClick
    end
    object miSaveXML: TMenuItem
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082
      OnClick = miSaveXMLClick
    end
  end
  object XMLDocument1: TXMLDocument
    Active = True
    Left = 32
    Top = 104
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.xml'
    Filter = 'XML '#1092#1072#1081#1083'|.xml'
    Left = 32
    Top = 160
  end
end
