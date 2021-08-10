unit msg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  Tms = class(TForm)
    Shape1: TShape;
    Label1: TLabel;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ms: Tms;

implementation
    uses unit1;
{$R *.dfm}

procedure Tms.Timer1Timer(Sender: TObject);
begin
     try
        begin
              if ms.AlphaBlendValue<=0 then
                        begin
                            ms.AlphaBlendValue :=255;
                            close;
                        end
                   else
                        ms.AlphaBlendValue :=ms.AlphaBlendValue -1;
        end;
     except
     end;
end;

procedure Tms.FormShow(Sender: TObject);
begin
   try
      begin
       sleep(100);
       form1.Enabled :=false;
       timer1.Enabled :=true;
      end;
   except
   end;
end;

procedure Tms.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      try
         begin
              form1.enabled:=true;
              timer1.Enabled :=false;
         end
      except
      end;
end;

end.
