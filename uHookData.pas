unit uHookData;

interface
uses
   System.SysUtils,windows,winsock2;
const
  DATA_DIRECTION_SEND=1;                             //数据方向：发送的数据；
  DATA_DIRECTION_RECV=0;                             //数据方向：接收到的数据；
type
  stSocketConnectInfo=record               //socket连接信息；
    s:TSocket;                            //保存旧连接信息
    remoteAddr:ansiString;
    localAddr:ansiString;
    remotePort:WORD;
    localPort:WORD;
  end;
var
  hFile:HWND;
  mSocketConnectInfo:stSocketConnectInfo;

procedure SaveSocketDataToFile(s:TSocket;dataDirection, dataSize: DWORD;pData:pointer);
procedure getSocketConnectInfo(s:TSocket;var socketConnectInfo:stSocketConnectInfo);
procedure myCloseHandle(var hFile:HWND);
implementation
uses
  uConfig,uFuncs,uLog;
//-----------------------------------------保存通讯数据 --------------------------------------------
procedure SaveSocketDataToFile(s:TSocket;dataDirection, dataSize: DWORD;pData:pointer);
var
  header,dataId:ansistring;
  NumberOfBytesWritten,NumberOfBytesWrittenSum:DWORD;
  ret:BOOL;
begin
  if(dataSize<=0)then exit;
  try
    getSocketConnectInfo(s,mSocketConnectInfo);
    if (hFile=0) then
    begin
      hFile:=CreateFileA(pansichar(uConfig.socketFile),GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE,nil,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,0);
      if(hFile = INVALID_HANDLE_VALUE)then exit;
      //Log('hFile:'+dataId);
      //dwFileSize:=getFileSize(hFile,@dwFileSize);
      setFilePointer(hFile,0,nil,FILE_END);
    end;
    //getSocketConnectInfo(s,mSocketConnectInfo);
    if(dataDirection=DATA_DIRECTION_RECV)then dataId:='recv';
    if(dataDirection=DATA_DIRECTION_SEND)then dataId:='send';
    header:=#13#10#13#10+getDateTimeString(now(),0)+'--------'+dataId+'--------local:('+mSocketConnectInfo.localAddr
      +'  port:'+inttostr(mSocketConnectInfo.localPort)+')remote:(' +mSocketConnectInfo.remoteAddr+'  port:'+inttostr(mSocketConnectInfo.remotePort)+')'+#13#10#13#10;
    ret:=writeFile(hFile,header[1],length(header),NumberOfBytesWritten,0);
    if(ret=false)then begin CloseHandle(hFile);hFile:=0;exit;end;

    NumberOfBytesWritten:=0;
    NumberOfBytesWrittenSum:=0;
    while(NumberOfBytesWrittenSum<dataSize)do
    begin
      ret:=writeFile(hFile,pData^,dataSize-NumberOfBytesWrittenSum,NumberOfBytesWritten,0);
      if(ret=false)then begin CloseHandle(hFile);hFile:=0;exit;end;
      NumberOfBytesWrittenSum:=NumberOfBytesWrittenSum+NumberOfBytesWritten;

    end;
    FlushFileBuffers(hFile);
  finally

  end;
end;
procedure getSocketConnectInfo(s:TSocket;var socketConnectInfo:stSocketConnectInfo);
var
  addr:sockaddr;
  addr_v4:sockaddr_in;
  ret,addr_len:integer;
begin
  if(integer(s)=integer(socketConnectInfo.s))then exit;  //还是同一个连接就退出
  socketConnectInfo.s:=s;
  ZeroMemory(@addr, sizeof(addr));
  addr_len:=sizeof(addr);
  ret:=getsockname(s, addr, addr_len);
  if(ret=0)then
  begin
    if (addr.sa_family = AF_INET)then
    begin
      addr_v4 := sockaddr_in(addr);
      socketConnectInfo.localAddr:=inet_ntoa(addr_v4.sin_addr);
      socketConnectInfo.localPort:= ntohs(addr_v4.sin_port);
    end;
  end;
  ZeroMemory(@addr, sizeof(addr));
  addr_len:=sizeof(addr);
  ret:=getpeername(s,  addr, addr_len);
  if(ret=0)then
  begin
    if (addr.sa_family = AF_INET)then
    begin
      addr_v4:= sockaddr_in(addr);
      socketConnectInfo.remoteAddr := inet_ntoa(addr_v4.sin_addr);
      socketConnectInfo.remotePort:= ntohs(addr_v4.sin_port);
    end;
  end;
end;




procedure myCloseHandle(var hFile:HWND);
begin
  if(hFile<>0)then
  begin
    closeHandle(hFile);
    hFile:=0;
  end;
end;


initialization

finalization
   myCloseHandle(hFile);
end.



{
 procedure SaveFile(dataId:ansiString; var Buf;len: Integer);
var
  header:ansistring;
  lpNumberOfBytesWritten,dwFileSize:DWORD;
  ret:BOOL;
begin
  if(len<=0)then exit;
  try
    if (hFile=0) then
    begin
      hFile:=CreateFileA(pansichar(uConfig.socketFile),GENERIC_READ or GENERIC_WRITE,FILE_SHARE_READ or FILE_SHARE_WRITE,nil,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,0);
      if(hFile = INVALID_HANDLE_VALUE)then exit;
      //Log('hFile:'+dataId);
      //dwFileSize:=getFileSize(hFile,@dwFileSize);
      setFilePointer(hFile,0,nil,FILE_END);
    end;
    header:=#13#10+getDateTimeString(now(),0)+'--------'+dataId+'--------'+#13#10;
    ret:=writeFile(hFile,header[1],length(header),lpNumberOfBytesWritten,0);
    if(ret=false)then begin CloseHandle(hFile);hFile:=0;exit;end;

    lpNumberOfBytesWritten:=0;
    while(lpNumberOfBytesWritten<len)do
    begin
      ret:=writeFile(hFile,Buf,len,lpNumberOfBytesWritten,0);
      if(ret=false)then begin CloseHandle(hFile);hFile:=0;exit;end;
    end;
    FlushFileBuffers(hFile);
  finally

  end;
end;





}
