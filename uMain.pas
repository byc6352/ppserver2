unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  System.Win.ScktComp, IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient,
  IdSNTP,uHook,uLog,uFlash,uConfig,uFuncs;

type
  TfMain = class(TForm)
    Panel1: TPanel;
    btnStart: TButton;
    Page1: TPageControl;
    StatusBar1: TStatusBar;
    tsInfo: TTabSheet;
    tsData: TTabSheet;
    memoInfo: TMemo;
    MemoData: TMemo;
    Panel2: TPanel;
    btnDecrpt: TButton;
    edtInput: TEdit;
    btnTest: TButton;
    btnDecryptTime: TButton;
    btnSetSysTime: TButton;
    btnRestoreSysTime: TButton;
    btnCrypt: TButton;
    btnCryptTime: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnDecrptClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnDecryptTimeClick(Sender: TObject);
    procedure btnSetSysTimeClick(Sender: TObject);
    procedure btnRestoreSysTimeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCryptClick(Sender: TObject);
    procedure btnCryptTimeClick(Sender: TObject);
  private
    { Private declarations }

    procedure httpMessage(var MSG:TMessage); message WM_CAP_WORK;
    procedure AppException(Sender: TObject; E: Exception);
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

uses uDM;

procedure TfMain.AppException(Sender: TObject; E: Exception);
begin
  //Application.ShowException(E);
  //Application.Terminate;
  Log(e.Message);
end;
procedure TfMain.httpMessage(var msg:TMessage);
var
  len,flag:integer;
  p:pointer;
  say,data:ansistring;

begin
  flag:=msg.LParam;
  len:=msg.WParam;
  case flag of
  0:begin
      say:='发送数据：'+inttostr(len);
      //data:=gSend;
    end;
  1:begin
      say:='接收数据：'+inttostr(len);
      //data:=gRecv;
    end;
  end;

  memoInfo.Lines.Add(uFuncs.getDateTimeString(now(),0));
  memoInfo.Lines.Add(say);
  //memoInfo.Lines.Add(gData);
end;

procedure TfMain.btnCryptClick(Sender: TObject);
var
  s:ansiString;
begin
  s:=trim(edtInput.Text);
  s:=dm.flash.cryptData(s);
  memoData.Lines.Add(s);

end;

procedure TfMain.btnCryptTimeClick(Sender: TObject);
var
  s:ansiString;
begin
  s:=trim(edtInput.Text);
  s:=dm.flash.decryptTimeData(s);
  memoData.Lines.Add(s);

end;

procedure TfMain.btnDecrptClick(Sender: TObject);
var
  s:ansiString;
begin
  s:=trim(edtInput.Text);
  s:=dm.flash.decryptData(s);
  memoData.Lines.Add(s);
end;

procedure TfMain.btnDecryptTimeClick(Sender: TObject);
var
  s:ansiString;
begin
  s:=trim(edtInput.Text);
  s:=dm.flash.decryptTimeData(s);
  memoData.Lines.Add(s);

end;

procedure TfMain.btnRestoreSysTimeClick(Sender: TObject);
begin
  dm.IdSNTP1.Host:='time.windows.com';
  dm.IdSNTP1.SyncTime ;
end;

procedure TfMain.btnSetSysTimeClick(Sender: TObject);
var
  systemtime:Tsystemtime;
  DateTime:TDateTime;
begin
  DateTime:=StrToDateTime('2019/09/22 11:00:00');   //获得时间（TDateTime格式）
  DateTimeToSystemTime(DateTime,systemtime);   //把Delphi的TDateTime格式转化为API的TSystemTime格式
  SetLocalTime(SystemTime);
  //GetLocalTime(SystemTime);   //读取系统时间
  //DateTime:=SystemTimeToDateTime(SystemTime);   //把API的TSystemTime格式   转化为   Delphi的TDateTime格式
  //Edit2.Text:=DateTimeToStr(DateTime);   //显示当前系统的时间
end;

procedure TfMain.btnStartClick(Sender: TObject);
begin
  dm.Timer1.Enabled:=true;
end;

procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dm.IdSNTP1.Host:='time.windows.com';
  dm.IdSNTP1.SyncTime ;
end;

procedure TfMain.FormShow(Sender: TObject);
begin
  uHook.hForm:=fMain.Handle;
  dm.Timer1.Enabled:=false;
  page1.ActivePageIndex:=0;
end;
 //{"response":{"responsecode":0,"responsemsg":"Success","data":{"prompt":"输入红色三角行数字图像校验码","type":"0","captchaImageToken":"1423850325","expression":""}},"requestid":"55409110.f112911990","servertime":"20190921112911"}
 //{"response":{"responsecode":0,"responsemsg":"Success","data":{"prompt":"输入红色三角行数字图像校验码","type":"1","captchaImageToken":"1423850325","expression":"1+2"}},"requestid":"55409110.f112911990","servertime":"20190921112911"}
end.
