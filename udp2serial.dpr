program udp2serial;

uses
  System.StartUpCopy,
  FMX.Forms,
  u2s in 'u2s.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
