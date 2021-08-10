unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OleCtrls, ShockwaveFlashObjects_TLB, StdCtrls, Buttons, ExtCtrls, jpeg;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    c6: TShape;
    c5: TShape;
    c4: TShape;
    c3: TShape;
    c2: TShape;
    c1: TShape;
    Panel2: TPanel;
    Timer1: TTimer;
    Shape1: TShape;
    lapro: TLabel;
    Image4: TImage;
    Image3: TImage;
    Image2: TImage;
    Panel3: TPanel;
    Timer2: TTimer;
    Timer3: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure c2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure c3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure c4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure c6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure c5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure c1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CloseForm;
  private
    { Private declarations }
  public
      p:Tpoint;
      count:integer;
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
    uses unit1, msg;
{$R *.DFM}
procedure Tform2.CloseForm;
var
   i:integer;
    pt,pt2: TPoint;
begin
     try
                  for i:=0 to form2.panel2.ControlCount -1 do
                        if form2.Panel2.Controls[i].ClassName  ='TShockwaveFlash' then
                              with  form2.panel2.Controls[i]  as TShockwaveFlash do
                                  begin

                                          Parent :=form1;
                                          Left := 8;
                                          Top :=56;
                                          Width :=347;
                                          Height :=369;
                                          Quality :=1;
                                          form1.show;
                                          getcursorpos(pt2);
                                          pt:= form1.flash.ClientToScreen( Point( 1,1 ));
                                          SetCursorPos( pt.x, pt.y );
                                          mouse_event( MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0 );
                                          mouse_event( MOUSEEVENTF_LEFTUP, 0, 0, 0, 0 );
                                          mouse_event( MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0 );
                                          mouse_event( MOUSEEVENTF_LEFTUP, 0, 0, 0, 0 );
                                          setcursorpos(pt2.X,pt2.Y );
                                          showcursor(true);
                                          form2.close;
                                          exit;
                                  end;
     except
     end;
end;
procedure TForm2.FormCreate(Sender: TObject);
begin
      try
          begin
             form2.Width :=screen.Width;
             form2.Height :=screen.Height;
             panel3.Left :=5;
             panel3.Top :=form2.Height;

          end
      except
      end;
end;

procedure TForm2.c2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   i:integer;
begin
   try
     for i :=0 to panel2.ControlCount -1 do
          if panel2.Controls[i].ClassName ='TShockwaveFlash' then
                  with panel2.Controls[i] as TShockwaveFlash do
                      begin
                              play;
                      end;
   except
   end;
end;

procedure TForm2.c3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   i:integer;
begin
   try
     for i :=0 to panel2.ControlCount -1 do
          if panel2.Controls[i].ClassName ='TShockwaveFlash' then
                  with panel2.Controls[i] as TShockwaveFlash do
                      begin
                                  StopPlay ;
                      end;
   except
   end;
end;

procedure TForm2.c4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   i:integer;
begin
  try
        begin
            for i :=0 to panel2.ControlCount -1 do
                if panel2.Controls[i].ClassName ='TShockwaveFlash' then
                    with panel2.Controls[i] as TShockwaveFlash do
                      begin
                              Rewind;
                              stop;
                      end;
        end
  except
  end;
     
end;

procedure TForm2.c6MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
       CloseForm;
end;

procedure TForm2.c5MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var
     i,k:integer;
begin
   try
      begin
           i:=form1.gird.Row;
           k:=i+1;
           if k> (form1.gird.RowCount-1) then
                 begin
                      form1.gird.Row :=1;
                      k:=1;
                 end;
           if fileexists(form1.gird.Cells[2,k])=false then
               begin

                       if form1.gird.Row >= (form1.gird.RowCount -1) then
                                form1.gird.Row :=1
                            else form1.gird.Row :=form1.gird.Row+1;
                       if form1.gird.Cells[2,form1.gird.Row]='' then exit;
                       form1.gird.Cells[3,k]:='文件不存在';
                       ms.Show;
                       exit;
               end;

           for i :=0 to panel2.ControlCount -1 do
                   if panel2.Controls[i].ClassName ='TShockwaveFlash' then
                           with panel2.Controls[i] as TShockwaveFlash do
                                 begin
                                        stop;
                                        movie:=form1.gird.Cells[2,k];
                                        play;
                                        
                                        form1.gird.row:=k;
                                        exit;
                                 end;
      end
   except
   end;
end;

procedure TForm2.c1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var
     i,k:integer;
begin
    try
       begin
           i:=form1.gird.Row;
           k:=i-1;
           if k<=0  then
                 begin
                      form1.gird.Row :=(form1.gird.RowCount -1);
                      k:=(form1.gird.RowCount -1);
                 end;
           if fileexists(form1.gird.Cells[2,k])=false then
               begin

                       if form1.gird.Row <= 1 then
                                form1.gird.Row :=(form1.gird.RowCount -1)
                            else form1.gird.Row :=form1.gird.Row-1;
                        if form1.gird.Cells[2,form1.gird.Row]='' then exit;
                        form1.gird.Cells[3,k]:='文件不存在';
                        ms.Show;
                       exit;
               end;

           for i :=0 to panel2.ControlCount -1 do
                   if panel2.Controls[i].ClassName ='TShockwaveFlash' then
                           with panel2.Controls[i] as TShockwaveFlash do
                                 begin
                                        stop;
                                        movie:=form1.gird.Cells[2,k];
                                        play;
                                        
                                        form1.gird.row:=k;
                                        exit;

                                  end;
       end
    except
    end;
end;

procedure TForm2.FormShow(Sender: TObject);
var
   i:integer;
begin
  try
        begin
           for i :=0 to panel2.ControlCount -1 do
           if panel2.Controls[i].ClassName ='TShockwaveFlash' then
                     with panel2.Controls[i] as   TShockwaveFlash do
                               begin
                                         panel3.Color :=  BackgroundColor;
                                         break;
                               end;
            timer1.Enabled :=true;
        end
  except
  end;


end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
           timer1.Enabled :=false;
           timer2.Enabled :=false;
           timer3.Enabled :=false;
end;

procedure TForm2.Timer1Timer(Sender: TObject);
var
   pt:Tpoint;
   a,b,c:double;
   i:integer;
begin
   try
                if GetAsyncKeyState(VK_ESCAPE)<>0 then closeForm;
                for i :=0 to form2.Panel2.ControlCount -1 do
                   if form2.Panel2.Controls[i].ClassName ='TShockwaveFlash' then
                           with form2.Panel2.Controls[i] as TShockwaveFlash do
                                 begin
                                        form2.lapro.Caption :=inttostr(FrameNum )+'/'+inttostr(TotalFrames );
                                        a:=FrameNum;
                                        b:=TotalFrames ;
                                        form2.lapro.Left :=335 -form2.lapro.Width ;
                                        c:=form2.Image4.Width/2;
                                        form2.image4.Left :=9-trunc(c)+trunc((a/b)*image3.Width );
                                        break;
                                 end;
            GetCursorPos(pt);
            if (p.X <> pt.X) or (p.Y <> pt.Y )then
                    begin
                          p.X :=pt.X;
                          p.Y :=pt.Y;
                          count:=0;
                          if (panel1.Top =0) and (panel3.Top =form2.Height -panel3.Height) then
                                              exit
                                      else
                                            begin
                                              if timer2.Enabled =false then
                                                             begin
                                                                timer2.Enabled :=false;
                                                                showcursor(true);
                                                             end;
                                              if timer3.Enabled <>true  then
                                                            timer3.Enabled :=true;
                                            end;

                    end
               else
                    begin
                            count:=count+1;
                            if count>=200 then
                                   if (panel1.Top =-panel1.Height ) and (panel3.Top =form2.Height) then
                                               exit
                                          else
                                               begin

                                                      if timer2.Enabled =false then
                                                            begin

                                                                    timer2.Enabled :=true;
                                                                    while (showcursor(false)<>-1) do


                                                            end

                                               end;

                    end;


   except
   end;
end;

procedure TForm2.Timer2Timer(Sender: TObject);
begin
  try
        begin
                if timer3.Enabled =true then timer3.Enabled :=false;
                panel1.Top :=panel1.Top -1;
                if panel1.Top < -panel1.Height then panel1.Top :=-panel1.Height;
                panel3.Top :=panel3.Top +1;
                if panel3.Top > form2.Height then panel3.Top :=form2.Height;
                if ((panel3.Top =form2.Height ) and (panel1.Top =-panel1.Height )) then
                       timer2.Enabled :=false;
        end
  except
  end;


end;

procedure TForm2.Timer3Timer(Sender: TObject);
begin
  try
        begin
           if timer2.Enabled =true then timer2.Enabled :=false;
           panel1.Top :=panel1.Top +1;
           if panel1.Top >0  then panel1.Top :=0;
           panel3.Top :=panel3.Top -1;
           if panel3.Top < form2.Height -panel3.Height then panel3.Top :=form2.Height -panel3.Height;
           if( (panel3.Top =form2.Height -panel3.Height) and (panel1.top=0)) then
             timer3.Enabled :=false;
        end
  except
  end;
     
end;

procedure TForm2.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   a,b,c:double;
   i:integer;
begin
try
           for i :=0 to form2.Panel2.ControlCount -1 do
                   if form2.Panel2.Controls[i].ClassName ='TShockwaveFlash' then
                           with form2.Panel2.Controls[i] as TShockwaveFlash do
                                 begin
                                        if  (Playing =false) then exit;
                                        a:=x;
                                        b:=a/image3.Width ;
                                        c:=b*TotalFrames;
                                        FrameNum :=trunc(c);
                                        Play;
                                        break;
                                 end;



except
end;
end;

end.
