unit u2s;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPServer, CPort, IdGlobal,
  IdSocketHandle,Vcl.ExtCtrls,Windows,System.Threading;

type
  TForm1 = class(TForm)
    com: TComPort;
    udps: TIdUDPServer;
    procedure FormCreate(Sender: TObject);
    procedure udpsUDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  ticon: TTrayIcon;
  sss:String;

implementation

{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
begin
try
 ticon := TTrayIcon.Create(form1);
 ticon.Visible:=true;
 com.port := ParamStr(1);
 com.BaudRate := StrToBaudRate(ParamStr(1));
 udps.DefaultPort := ParamStr(3).ToInteger();
 udps.Active;
 com.Connected:= true;
 if ParamStr(4)='1' then sss:=#13#10 else sss:='';


 ticon.BalloonTitle:= 'udp2serial started';
 ticon.BalloonHint:= ParamStr(1)+' / '+ParamStr(2)+#13#10+'UDP Port / '+ParamStr(3);
 ticon.ShowBalloonHint;
except
 On E : Exception do
 begin
   ShowMessage(E.Message);
   Application.Terminate;
 end;

end;

end;

procedure TForm1.FormShow(Sender: TObject);
begin
Hide;

SetWindowLong(FindWindow(nil,PChar(Form1.Caption)), GWL_EXSTYLE, WS_EX_TOOLWINDOW);
{
TTAsk.run(
procedure begin
sleep(100);
ShowWindowAsync(FindWindow(nil,PChar(Form1.Caption)), SW_HIDE);
end);
}
end;

procedure TForm1.udpsUDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
begin
 com.WriteStr(TEncoding.ANSI.GetString(AData)+sss);
end;

end.
