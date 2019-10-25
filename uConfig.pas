unit uConfig;

interface
uses
  Vcl.Forms,System.SysUtils;
const
  WORK_DIR:ansiString='ppserver'; // 工作目录
  DATA_DIR:ansiString='data'; // 数据目录
  LOG_NAME:ansiString='ppserverLog.txt'; //日志文件
  SWF_NAME:ansiString='crypt.swf';        //flash文件
  POLICY_NAME:ansiString='crossdomain.xml';//flash授权文件
  CROSS_NAME:ansiString='crossdomain.dat';//flash授权文件
  SOCKET_NAME:ansiString='socket.dat'; //socket数据文件
  YZCODE_NAME:ansiString='yzcode.png'; //验证码
  YZCODE_MSG_NAME:ansiString='yzcode.txt'; //验证码
var
  workdir,dataDir:ansiString;//工作目录
  policyfile,crossfile,logfile,socketFile,yzcodeFile:ansiString;//
  swfFileName,yzcodeMsgfile:ansiString;//xml配置参数文件
  isInit:boolean=false;
  procedure init();
implementation

procedure init();
var
    me:String;
begin
  isInit:=true;
  me:=application.ExeName;
  workdir:=extractfiledir(me)+'\'+WORK_DIR;
  if(not DirectoryExists(workdir))then ForceDirectories(workdir);
  dataDir:=workdir+'\'+DATA_DIR;
  if(not DirectoryExists(dataDir))then ForceDirectories(dataDir);
  logfile:=dataDir+'\'+LOG_NAME;
  policyfile:=workdir+'\'+POLICY_NAME;
  crossfile:=workdir+'\'+CROSS_NAME;
  swfFileName:=workdir+'\'+SWF_NAME;
  yzcodeFile:=workdir+'\'+YZCODE_NAME;
  socketFile:=dataDir+'\'+SOCKET_NAME;
  yzcodeMsgfile:=workdir+'\'+YZCODE_MSG_NAME;
end;
begin
  init();
end.
