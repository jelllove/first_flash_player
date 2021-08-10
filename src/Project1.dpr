program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  unit2 in 'unit2.pas' {Form2},
  about in 'about.pas' {bout},
  msg in 'msg.pas' {ms};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'FlashPlayer';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tbout, bout);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(Tms, ms);
  Application.Run;
end.
