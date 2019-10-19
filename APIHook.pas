unit APIHook;

interface

uses
SysUtils,Messages,
Windows, WinSock;

Const
  WM_CAP_WORK = WM_USER+1000;
type
//ҪHOOK��API��������
TSockProc = function (s: TSocket; var Buf; len, flags: Integer): Integer; stdcall;

PJmpCode = ^TJmpCode;
TJmpCode = packed record
JmpCode: BYTE;
Address: TSockProc;
MovEAX: Array [0..2] of BYTE;
end;

//--------------------��������---------------------------
procedure HookAPI;
procedure UnHookAPI;

var
OldSend, OldRecv: TSockProc; //ԭ����API��ַ
JmpCode: TJmpCode;
OldProc: array [0..1] of TJmpCode;
AddSend, AddRecv: pointer; //API��ַ
TmpJmp: TJmpCode;
ProcessHandle: THandle;
  hForm:HWND;
  gRecv,gSend:ansistring;
implementation

{---------------------------------------}
{��������:Send������HOOK
{��������:ͬSend
{��������ֵ:integer
{---------------------------------------}
function MySend(s: TSocket; var Buf; len, flags: Integer): Integer; stdcall;
var
  //dwSize: cardinal;
  dwSize:NativeUInt;
begin
  //������з��͵����ݴ���
  setlength(gSend,len);
  move(buf,gSend[1],len);
  postMessage(hform, WM_CAP_WORK,len,0);

  MessageBeep(10000); //�򵥵���һ��
  //����ֱ����Send����
  WriteProcessMemory(ProcessHandle, AddSend, @OldProc[0], 8, dwSize);
  Result := OldSend(S, Buf, len, flags);
  JmpCode.Address := @MySend;
  WriteProcessMemory(ProcessHandle, AddSend, @JmpCode, 8, dwSize);
end;

{---------------------------------------}
{��������:Recv������HOOK
{��������:ͬRecv
{��������ֵ:integer
{---------------------------------------}
function MyRecv(s: TSocket; var Buf; len, flags: Integer): Integer; stdcall;
var
  //dwSize: cardinal;
  dwSize:NativeUInt;
begin
//������н��յ����ݴ���
  setlength(gRecv,len);
  move(buf,gRecv[1],len);
  postMessage(hform, WM_CAP_WORK,len,1);
  MessageBeep(1000); //�򵥵���һ��
//����ֱ����Recv����
WriteProcessMemory(ProcessHandle, AddRecv, @OldProc[1], 8, dwSize);
Result := OldRecv(S, Buf, len, flags);
JmpCode.Address := @MyRecv;
WriteProcessMemory(ProcessHandle, AddRecv, @JmpCode, 8, dwSize);
end;

{------------------------------------}
{���̹���:HookAPI
{���̲���:��
{------------------------------------}
procedure HookAPI;
var
DLLModule: THandle;
  //dwSize: cardinal;
  dwSize:NativeUInt;
begin
ProcessHandle := GetCurrentProcess;
DLLModule := LoadLibrary('ws2_32.dll');
AddSend := GetProcAddress(DLLModule, 'send'); //ȡ��API��ַ
AddRecv := GetProcAddress(DLLModule, 'recv');
JmpCode.JmpCode := $B8;
JmpCode.MovEAX[0] := $FF;
JmpCode.MovEAX[1] := $E0;
JmpCode.MovEAX[2] := 0;
ReadProcessMemory(ProcessHandle, AddSend, @OldProc[0], 8, dwSize);
JmpCode.Address := @MySend;
WriteProcessMemory(ProcessHandle, AddSend, @JmpCode, 8, dwSize); //�޸�Send���
ReadProcessMemory(ProcessHandle, AddRecv, @OldProc[1], 8, dwSize);
JmpCode.Address := @MyRecv;
WriteProcessMemory(ProcessHandle, AddRecv, @JmpCode, 8, dwSize); //�޸�Recv���
OldSend := AddSend;
OldRecv := AddRecv;
end;

{------------------------------------}
{���̹���:ȡ��HOOKAPI
{���̲���:��
{------------------------------------}
procedure UnHookAPI;
var
  //dwSize: cardinal;
  dwSize:NativeUInt;
begin
WriteProcessMemory(ProcessHandle, AddSend, @OldProc[0], 8, dwSize);
WriteProcessMemory(ProcessHandle, AddRecv, @OldProc[1], 8, dwSize);
end;

end.
