unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Vcl.Menus;

type
  TForm1 = class(TForm)
    Memo: TMemo;
    PopupMenu1: TPopupMenu;
    ActionList1: TActionList;
    actNewSave: TAction;
    N1: TMenuItem;
    actExit: TAction;
    actSave: TAction;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    SaveDialog: TSaveDialog;
    actOpen: TAction;
    OpenDialog1: TOpenDialog;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    clBlack: TMenuItem;
    clGray: TMenuItem;
    clWhite: TMenuItem;
    trans_100: TMenuItem;
    trans_80: TMenuItem;
    trans_50: TMenuItem;
    trans_20: TMenuItem;
    trans_1: TMenuItem;
    t1: TMenuItem;
    g1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure SetTransparentForm(AHandle : THandle; AValue : byte = 0);
    procedure actExitExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actNewSaveExecute(Sender: TObject);
    procedure actOpenExecute(Sender: TObject);
    procedure FormMouseEnter(Sender: TObject);
    procedure MemoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure MemoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel2MouseEnter(Sender: TObject);
    procedure Panel2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormChangeColor(Sender: TObject);
    procedure init(a, b, c :Integer; d: String);
    function Split(str, delimiter: string): TStringList;

    procedure SetBackgound(_color: TColor);
    procedure SetTransparent(trasnPercent: Integer);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormChangeTrans(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure MemoChange(Sender: TObject);
    procedure g1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  savePath : string;
  cfgWidth, cfgHeight, cfgTrans, cfgColor : string;
  isChanged : boolean;
  CONFIG_PATH : string;
  CONFIG_SAVE_PATH : string;


implementation

{$R *.dfm}


procedure TForm1.FormCreate(Sender: TObject);
procedure RemoveNull (var str : string);
var
  n : integer;
begin
n := 1;
while n <= Length(str) do begin
  if str[n] = #0 then begin
    Delete(str, n, 1);
    Continue;
  end;
  inc(n);
end;
end;

function GetCurrentUserName: string;
const
  cnMaxUserNameLen = 254;
var
  sUserName: string;
  dwUserNameLen: DWORD;
begin
  dwUserNameLen := cnMaxUserNameLen - 1;
  SetLength(sUserName, cnMaxUserNameLen);
  GetUserName(PChar(sUserName), dwUserNameLen);
  SetLength(sUserName, dwUserNameLen);
  RemoveNull(sUserName);
  Result := sUserName;
end;
var
tmpList : TStringList;

begin
  CONFIG_SAVE_PATH :=  'C:\Users\'+GetCurrentUserName+'\Documents\';
  CONFIG_PATH := CONFIG_SAVE_PATH + 'mem.cfg';

  if not DirectoryExists( CONFIG_SAVE_PATH ) then CreateDir( CONFIG_SAVE_PATH );

  if fileexists( CONFIG_PATH ) then
  begin
    tmpList:= TStringList.Create;
    tmpList.LoadFromFile( CONFIG_PATH );
    tmpList := Split(tmpList[0],'|');
    cfgWidth  := tmpList[0];
    cfgHeight := tmpList[1];
    cfgTrans  := tmpList[2];
    cfgColor  := tmpList[3];

    FreeAndNil(tmpList);
  end
  else
  begin
    cfgWidth  := '400';
    cfgHeight := '300';
    cfgTrans  := '50';
    cfgColor  := 'clWhite';
  end;
end;

procedure TForm1.actExitExecute(Sender: TObject);
var
  buttonSelected : Integer;
begin
  if isChanged then
  begin
    if savePath.Length = 0 then
      buttonSelected := messagedlg('변경내용을 저장하시겠습니까?',mtCustom, [mbYes,mbNo,mbCancel], 0)
    else
      buttonSelected := messagedlg( savePath+ '에 변경내용을 저장하시겠습니까?',mtCustom, [mbYes,mbNo,mbCancel], 0);

    if buttonSelected = 2 then
      Exit;
    
    if buttonSelected = 6 then
      actSave.Execute;
  end;

  Form1.Close;

end;

procedure TForm1.init(a, b, c :Integer; d: String);
begin
//  Form1.Width := a;
//  Form1.Height := b;

  SetTransparent(c);

  if d = 'clBlack' then
    SetBackgound(TColor(clBlack))
  else if d = 'clGray' then
    SetBackgound(TColor(clSilver))
  else if d = 'clWhite' then
    SetBackgound(TColor(clWindow));

  isChanged := false;
end;

procedure TForm1.actNewSaveExecute(Sender: TObject);
begin
  SaveDialog := TSaveDialog.Create(Application);
  if SaveDialog.Execute then begin
    savePath := string(SaveDialog.FileName);
    Memo.Lines.SaveToFile(savePath);
    isChanged := False;
  end
  else
  begin
    isChanged := True;
  end;
  SaveDialog.Free;
end;

procedure TForm1.actOpenExecute(Sender: TObject);
var
  buttonSelected : Integer;
begin
  if isChanged then
  begin
    if savePath.Length = 0 then
      buttonSelected := messagedlg('변경내용을 저장하시겠습니까?',mtCustom, [mbYes,mbNo,mbCancel], 0)
    else
      buttonSelected := messagedlg( savePath+ '에 변경내용을 저장하시겠습니까?',mtCustom, [mbYes,mbNo,mbCancel], 0);

    if buttonSelected = 2 then
      Exit;

    if buttonSelected = 6 then
      actSave.Execute;

    isChanged := False;
    Exit;
  end;
  OpenDialog1 := TOpenDialog.Create(Application);
  if OpenDialog1.Execute then begin
    savePath := string(OpenDialog1.FileName);
    Memo.Lines.LoadFromFile(savePath);
    isChanged := False;
  end;
  OpenDialog1.Free;
end;

procedure TForm1.actSaveExecute(Sender: TObject);
begin
  if savePath = '' then
  begin
    actNewSave.Execute;
    Exit;
  end;
  isChanged := False;
  Memo.Lines.SaveToFile(savePath);
end;

procedure TForm1.FormChangeTrans(Sender: TObject);
var
  trans : string;
begin
  trans := string(TMenuItem(Sender).Name);

  if trans = 'trans_100' then
    SetTransparent(100)
  else if trans = 'trans_80' then
    SetTransparent(80)
  else if trans = 'trans_50' then
    SetTransparent(50)
  else if trans = 'trans_20' then
    SetTransparent(20)
  else if trans = 'trans_1' then
    SetTransparent(1);

  cfgTrans := StringReplace(trans, 'trans_','', [rfReplaceAll]);
end;

procedure TForm1.FormChangeColor(Sender: TObject);
var
  col : string;
begin
  col := string(TMenuItem(Sender).Name);

  if col = 'clBlack' then
    SetBackgound(TColor(clBlack))
  else if col = 'clGray' then
    SetBackgound(TColor(clSilver))
  else if col = 'clWhite' then
    SetBackgound(TColor(clWindow));

  cfgColor := col;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
tmpList : TStringList;
begin
    tmpList := TStringList.Create;
    tmpList.Add(cfgWidth + '|' +cfgHeight+ '|' +cfgTrans+ '|' +cfgColor);
    tmpList.SaveToFile( CONFIG_PATH );
    FreeAndNil(tmpList);
end;

procedure TForm1.SetTransparent(trasnPercent: Integer);
begin
  SetTransparentForm(Form1.Handle,trasnPercent);
  SetTransparentForm(Memo.Handle,trasnPercent);
end;


procedure TForm1.SetBackgound(_color: TColor);
begin
  Memo.Color := _color;
  panel1.Color := _color;
  panel2.Color := _color;

  if _color = TColor(clBlack) then
    Memo.Font.Color := TColor(clHighlightText)
  else
    Memo.Font.Color := TColor(clWindowText);
end;


procedure TForm1.FormMouseEnter(Sender: TObject);
begin
  if GetKeyState(VK_CONTROL) < 0 then
    Memo.Cursor := crDrag
  else
    Memo.Cursor := crDefault;
end;


procedure TForm1.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  if GetKeyState(VK_CONTROL) < 0 then Exit;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
//  cfgWidth := string(Form1.Width);
//  cfgHeight := string(Form1.Height);
end;

procedure TForm1.FormShow(Sender: TObject);
begin

  init( cfgWidth.ToInteger , cfgHeight.ToInteger , cfgTrans.ToInteger , cfgColor);
end;

procedure TForm1.g1Click(Sender: TObject);
begin
  g1.Checked := not g1.Checked;

  if g1.Checked then
    SetWindowPos(Form1.handle, HWND_TOPMOST, Form1.Left, Form1.Top, Form1.Width, Form1.Height,0)
  else
    SetWindowPos(Form1.handle, HWND_NOTOPMOST, Form1.Left, Form1.Top, Form1.Width, Form1.Height,0);
end;

procedure TForm1.MemoChange(Sender: TObject);
begin
  isChanged := True;
end;

procedure TForm1.MemoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
  SC_DRAGMOVE = $F012;
begin
  if (Memo.Cursor = crDrag) and (Button = mbLeft) then
  begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
    Perform(WM_SYSCOMMAND, SC_MOVE + 1, 0);
  end;
end;

procedure TForm1.MemoMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if GetKeyState(VK_CONTROL) < 0 then
    Memo.Cursor := crDrag
  else
    Memo.Cursor := crDefault;
end;

procedure TForm1.Panel2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    Self.Perform(WM_SYSCOMMAND, SC_SIZE + WMSZ_BOTTOMRIGHT, 0);
  end;
end;

procedure TForm1.Panel2MouseEnter(Sender: TObject);
begin
    panel2.Cursor := crSizeNWSE;
end;

procedure TForm1.SetTransparentForm(AHandle : THandle; AValue : byte = 0);
var
 Info: TOSVersionInfo;
 SetLayeredWindowAttributes: TSetLayeredWindowAttributes;
begin
 //Check Windows version
 Info.dwOSVersionInfoSize := SizeOf(Info);
 GetVersionEx(Info);
 if (Info.dwPlatformId = VER_PLATFORM_WIN32_NT) and
 (Info.dwMajorVersion >= 5) then
   begin
     SetLayeredWindowAttributes := GetProcAddress(GetModulehandle(user32), 'SetLayeredWindowAttributes');
      if Assigned(SetLayeredWindowAttributes) then
       begin
        SetWindowLong(AHandle, GWL_EXSTYLE, GetWindowLong(AHandle, GWL_EXSTYLE) or WS_EX_LAYERED);
        //Make form transparent
        SetLayeredWindowAttributes(AHandle, 0, AValue, LWA_ALPHA);
      end;
   end;
end;


function TForm1.Split(str, delimiter: string): TStringList;
var
  P, dlen, flen: integer;
begin
  Result := TStringList.Create;
  dlen := Length(delimiter);
  flen := Length(str);
  repeat
    P := Pos(delimiter, str);
    if P = 0 then
      P := flen + dlen;
    Result.Add(copy(str, 1, P - 1));
    str := copy(str, P + dlen, flen);
    flen := Length(str);
  until flen = 0;
end;


end.
