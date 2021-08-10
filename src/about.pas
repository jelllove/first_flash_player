unit about;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, jpeg;

type
  Tbout = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure Shape1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Shape2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  bout: Tbout;

implementation
     uses unit1;
{$R *.DFM}

procedure Tbout.Shape1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
if ssleft in shift then
         begin
            releasecapture;
            bout.Perform(WM_SYSCOMMAND,$F012,0);
         end;
end;

procedure Tbout.Shape2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
      close;
end;

end.
