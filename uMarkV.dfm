object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Mark-V Markdown Viewer'
  ClientHeight = 416
  ClientWidth = 616
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 616
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitLeft = 32
    ExplicitTop = 32
    ExplicitWidth = 185
    object btReload: TSpeedButton
      Left = 5
      Top = 5
      Width = 25
      Height = 25
      Hint = #20877#35501#36796
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000B0030000B00300000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFADADFFBFBFFFE7E7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFBFBFFF8080FF8080FF9898FFFFFFFFFFFFFF9595FF8282FF8080FFA9A9FFF5
        F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F5FF8989FF8080FF9595FFFFFFFF
        FFFFFFFFFFFFF7F7FFC3C3FF8484FF9494FFF5F5FFFFFFFFFFFFFFFFFFFFFFFF
        FFA7A7FF8484FFB1B1FFA0A0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE2E2FF84
        84FFA9A9FFFFFFFFFFFFFFFFFFFFE6E6FF8080FFC5C5FFFFFFFFDBDBFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3C3FF8080FFE7E7FFFFFFFFFFFFFFBDBD
        FF8383FFF8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7
        F7FF8282FFBFBFFFFFFFFFFFFFFFAAAAFF9595FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9393FFABABFFFFFFFFFFFFFFABAB
        FF9494FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF9393FFACACFFFFFFFFFFFFFFBFBFFF8282FFF8F8FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7FF8282FFBFBFFFFFFFFFFFFFFFE6E6
        FF8080FFC5C5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC4
        C4FF8080FFE7E7FFFFFFFFFFFFFFFFFFFFA7A7FF8585FFE4E4FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFE3E3FF8585FFA8A8FFFFFFFFFFFFFFFFFFFFFFFF
        FFF4F4FF9292FF8585FFC5C5FFF9F9FFFFFFFFFFFFFFF7F7FFC5C5FF8484FF92
        92FFF5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F4FFA6A6FF8080FF8282FF
        9696FF9494FF8282FF8080FFA8A8FFF5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFE5E5FFBEBEFFAAAAFFAAAAFFBEBEFFE6E6FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btReloadClick
    end
    object btPriv: TSpeedButton
      Left = 30
      Top = 5
      Width = 25
      Height = 25
      Hint = #20877#35501#36796
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000B0030000B00300000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFADADFFBFBFFFE7E7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFBFBFFF8080FF8080FF9898FFFFFFFFFFFFFF9595FF8282FF8080FFA9A9FFF5
        F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F5FF8989FF8080FF9595FFFFFFFF
        FFFFFFFFFFFFF7F7FFC3C3FF8484FF9494FFF5F5FFFFFFFFFFFFFFFFFFFFFFFF
        FFA7A7FF8484FFB1B1FFA0A0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE2E2FF84
        84FFA9A9FFFFFFFFFFFFFFFFFFFFE6E6FF8080FFC5C5FFFFFFFFDBDBFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3C3FF8080FFE7E7FFFFFFFFFFFFFFBDBD
        FF8383FFF8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7
        F7FF8282FFBFBFFFFFFFFFFFFFFFAAAAFF9595FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9393FFABABFFFFFFFFFFFFFFABAB
        FF9494FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF9393FFACACFFFFFFFFFFFFFFBFBFFF8282FFF8F8FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7FF8282FFBFBFFFFFFFFFFFFFFFE6E6
        FF8080FFC5C5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC4
        C4FF8080FFE7E7FFFFFFFFFFFFFFFFFFFFA7A7FF8585FFE4E4FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFE3E3FF8585FFA8A8FFFFFFFFFFFFFFFFFFFFFFFF
        FFF4F4FF9292FF8585FFC5C5FFF9F9FFFFFFFFFFFFFFF7F7FFC5C5FF8484FF92
        92FFF5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F4FFA6A6FF8080FF8282FF
        9696FF9494FF8282FF8080FFA8A8FFF5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFE5E5FFBEBEFFAAAAFFAAAAFFBEBEFFE6E6FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btPrivClick
    end
    object btNext: TSpeedButton
      Left = 55
      Top = 5
      Width = 25
      Height = 25
      Hint = #20877#35501#36796
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000B0030000B00300000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFADADFFBFBFFFE7E7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFBFBFFF8080FF8080FF9898FFFFFFFFFFFFFF9595FF8282FF8080FFA9A9FFF5
        F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F5FF8989FF8080FF9595FFFFFFFF
        FFFFFFFFFFFFF7F7FFC3C3FF8484FF9494FFF5F5FFFFFFFFFFFFFFFFFFFFFFFF
        FFA7A7FF8484FFB1B1FFA0A0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE2E2FF84
        84FFA9A9FFFFFFFFFFFFFFFFFFFFE6E6FF8080FFC5C5FFFFFFFFDBDBFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3C3FF8080FFE7E7FFFFFFFFFFFFFFBDBD
        FF8383FFF8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7
        F7FF8282FFBFBFFFFFFFFFFFFFFFAAAAFF9595FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9393FFABABFFFFFFFFFFFFFFABAB
        FF9494FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF9393FFACACFFFFFFFFFFFFFFBFBFFF8282FFF8F8FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7FF8282FFBFBFFFFFFFFFFFFFFFE6E6
        FF8080FFC5C5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC4
        C4FF8080FFE7E7FFFFFFFFFFFFFFFFFFFFA7A7FF8585FFE4E4FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFE3E3FF8585FFA8A8FFFFFFFFFFFFFFFFFFFFFFFF
        FFF4F4FF9292FF8585FFC5C5FFF9F9FFFFFFFFFFFFFFF7F7FFC5C5FF8484FF92
        92FFF5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F4FFA6A6FF8080FF8282FF
        9696FF9494FF8282FF8080FFA8A8FFF5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFE5E5FFBEBEFFAAAAFFAAAAFFBEBEFFE6E6FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btNextClick
    end
    object btPrint: TSpeedButton
      Left = 101
      Top = 5
      Width = 25
      Height = 25
      Hint = #20877#35501#36796
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000B0030000B00300000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFADADFFBFBFFFE7E7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFBFBFFF8080FF8080FF9898FFFFFFFFFFFFFF9595FF8282FF8080FFA9A9FFF5
        F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F5FF8989FF8080FF9595FFFFFFFF
        FFFFFFFFFFFFF7F7FFC3C3FF8484FF9494FFF5F5FFFFFFFFFFFFFFFFFFFFFFFF
        FFA7A7FF8484FFB1B1FFA0A0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE2E2FF84
        84FFA9A9FFFFFFFFFFFFFFFFFFFFE6E6FF8080FFC5C5FFFFFFFFDBDBFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3C3FF8080FFE7E7FFFFFFFFFFFFFFBDBD
        FF8383FFF8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7
        F7FF8282FFBFBFFFFFFFFFFFFFFFAAAAFF9595FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9393FFABABFFFFFFFFFFFFFFABAB
        FF9494FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF9393FFACACFFFFFFFFFFFFFFBFBFFF8282FFF8F8FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7FF8282FFBFBFFFFFFFFFFFFFFFE6E6
        FF8080FFC5C5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC4
        C4FF8080FFE7E7FFFFFFFFFFFFFFFFFFFFA7A7FF8585FFE4E4FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFE3E3FF8585FFA8A8FFFFFFFFFFFFFFFFFFFFFFFF
        FFF4F4FF9292FF8585FFC5C5FFF9F9FFFFFFFFFFFFFFF7F7FFC5C5FF8484FF92
        92FFF5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F4FFA6A6FF8080FF8282FF
        9696FF9494FF8282FF8080FFA8A8FFF5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFE5E5FFBEBEFFAAAAFFAAAAFFBEBEFFE6E6FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentShowHint = False
      ShowHint = True
      OnClick = btPrintClick
    end
  end
  object WebBrowser: TWebBrowser
    Left = 32
    Top = 104
    Width = 300
    Height = 150
    TabOrder = 1
    SelectedEngine = EdgeIfAvailable
    ControlData = {
      4C000000B8110000DC0800000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
end
