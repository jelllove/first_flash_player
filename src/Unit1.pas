unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, OleCtrls, ShockwaveFlashObjects_TLB, StdCtrls, Buttons, Menus,shellapi,
  ImgList, Grids, registry;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Image4: TImage;
    g1: TImage;
    g2: TImage;
    g3: TImage;
    g4: TImage;
    g5: TImage;
    g6: TImage;
    shclose: TShape;
    shmenu: TShape;
    shmax: TShape;
    Image3: TImage;
    lapro: TLabel;
    dia: TOpenDialog;
    pop: TPopupMenu;
    N2: TMenuItem;
    D1: TMenuItem;
    L1: TMenuItem;
    ImageList1: TImageList;
    Timer1: TTimer;
    Image5: TImage;
    Image6: TImage;
    Shape2: TShape;
    gird: TStringGrid;
    c5: TShape;
    c6: TShape;
    c4: TShape;
    c3: TShape;
    c2: TShape;
    c1: TShape;
    img_z: TImage;
    img_s: TImage;
    Shape3: TShape;
    A1: TMenuItem;
    image2: TImage;
    flash: TShockwaveFlash;
    tempflash: TShockwaveFlash;
    procedure hideimage;
    procedure c1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure c2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure c3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure c4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure c5MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure c6MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure shcloseMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure c6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure c4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure c3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure c2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure wmdropfiles(var message:tmessage);message wm_dropfiles;
    procedure c1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure c5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure shmenuMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure Shape3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure girdSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure D1Click(Sender: TObject);
    procedure L1Click(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure CloseForm;
    procedure shmaxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    hotkeyid: integer;
    procedure WMhotkeyhandle(var msg: Tmessage);message WM_HOTKEY; //响应热键消息
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
   uses unit2,about,msg;
{$R *.DFM}




procedure registerfiletype(ft, key, desc, icon, prg: string);
var myreg: treginifile;
  ct: integer;
begin

  // 取文件的后缀
  ct := pos('.', ft);
  while ct > 0 do begin
    delete(ft, ct, 1);
    ct := pos('.', ft);
  end;
  if (ft = '') or (prg = '') then exit; //判断后缀及应用程序是否有效
  ft := '.' + ft;
  myreg := treginifile.create('');
  try
    myreg.rootkey := hkey_classes_root; // 根应该为HKEY_CLASSES_ROOT
    if key = '' then key := copy(ft, 2, maxint) + '_auto_file';
    // 如果没给出键值，则自动创建一个
    myreg.writestring(ft, '', key); // 写入描述的键值
    myreg.writestring(key, '', desc); // 写入描述
    if icon <> '' then
      myreg.writestring(key + '\DefaultIcon', '', icon);
    // 写入缺省图标
    myreg.writestring(key + '\shell\open\command', '', prg+' "%1"' );
    //写入相关联的应用程序
  finally
    myreg.free;
  end;
end;







procedure TForm1.WMhotkeyhandle(var msg: Tmessage);

begin
  if (msg.LParamHi = $46) and
    (msg.lparamLo = MOD_CONTROL) then
  begin
    msg.Result := 1; //该消息已经处理
    if form2.Showing =true then
          form2.CloseForm
       else
          form1.CloseForm;
  end;
end;

procedure Tform1.CloseForm;
begin
 try
    begin
     if (flash.Movie ='')  then exit;
     flash.Parent :=form2.Panel2 ;
     flash.Left :=0;
     flash.Top :=0;
     flash.Width :=form2.Width;
     flash.Height :=form2.Height;
     form2.Show;
     flash.Quality :=1;

    end
 except
 end;

end;
procedure tform1.wmdropfiles(var message:tmessage);
var
  p:array[0..254] of char;
  i:word;
  list1:TlistBox;
begin
  inherited;

  {$IFDEF WIN32}
  I:=dragqueryfile(message.wparam,$ffffffff,nil,0);
  {$ELSE}
  I:=dragqueryfile(message.wparam,$ffff,nil,0);
  {$ENDIF}
  list1:=TlistBox.Create(self);
  list1.Parent :=bout;
  list1.Clear;
  for i:=0 to i-1 do
       begin
             dragqueryfile(message.wparam,i,p,255);
             if (gird.RowCount =2) and (gird.Cells[2,1]='') then
                           gird.Rowcount:=gird.RowCount
                     else
                           gird.Rowcount:=gird.RowCount +1;
             gird.Cells[1,gird.RowCount-1 ]:=changeFileExt( ExtractFilename( strpas(p)),'');
             gird.Cells[2,gird.RowCount-1]:=strpas(p);
             tempflash.Stop;
             if fileexists(strpas(p))=false then
                      gird.cells[3,gird.RowCount-1]:='文件不存在'
                  else
                      begin
                             tempflash.Movie:=strpas(p);
                             gird.cells[3,gird.RowCount-1]:=inttostr(tempflash.TotalFrames );
                      end;
             tempflash.Rewind;
             tempflash.stop;
       end;
  for i :=1 to gird.RowCount -1 do
          list1.Items.Add(gird.Cells[2,i]);
  list1.Items.SaveToFile(extractFileDir(application.ExeName)+'\temp.dat');
  list1.Free;

end;


procedure tform1.hideimage;
begin
     try
        begin
           g1.Visible :=false;
           g2.Visible :=false;
           g3.Visible :=false;
           g4.Visible :=false;
           g5.Visible :=false;
           g6.Visible :=false;

        end;
     except
     end;
end;
procedure TForm1.c1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
     try
        begin
            hideimage;
            g1.Visible :=true;

        end;
     except
     end;
end;

procedure TForm1.c2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
     try
        begin
            hideimage;
            g2.Visible :=true;

        end;
     except
     end;
end;

procedure TForm1.c3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
     try
        begin
            hideimage;
            g3.Visible :=true;

        end;
     except
     end;
end;

procedure TForm1.c4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
     try
        begin
           hideimage;
           g4.Visible :=true;

        end;
     except
     end;
end;

procedure TForm1.c5MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
     try
        begin
         hideimage;
         g5.Visible :=true;

        end;
     except
     end;
     
end;

procedure TForm1.c6MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   try
      begin
        hideimage;
        g6.Visible :=true;
      end;
   except
   end;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
     try
       begin
         hideimage;
         if ssleft in shift then
         begin
            releasecapture;
            form1.Perform(WM_SYSCOMMAND,$F012,0);
         end;

       end;
     except
     end;
end;

procedure TForm1.Image4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    try
        hideimage;
    except
    end;
end;

procedure TForm1.shcloseMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    try
         close;
    except
    end;
end;

procedure TForm1.c6MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var
    i:integer;
    list1:TlistBox;
begin
 try
     if  dia.Execute then
         begin
                      gird.RowCount :=2;
                      for i :=0 to dia.Files.Count -1 do
                                 begin


                                       gird.Cells[1,gird.RowCount-1 ]:=changeFileExt( extractFileName(dia.Files.Strings[i]),'');
                                       gird.Cells[2,gird.RowCount-1]:=dia.Files.Strings[i];
                                       tempflash.Stop;
                                       if fileexists(dia.Files.Strings[i])=false then
                                                   gird.cells[3,gird.RowCount-1]:='文件不存在'
                                             else
                                                   begin
                                                        tempflash.Movie :=dia.Files.Strings[i];
                                                        gird.cells[3,gird.RowCount-1]:=inttostr(tempflash.TotalFrames );
                                                   end;
                                       tempflash.Rewind;
                                       tempflash.stop;
                                       gird.RowCount :=gird.RowCount +1;
                                 end;
                     if gird.RowCount >2 then
                          gird.RowCount :=gird.RowCount -1;
                      list1:=Tlistbox.Create(self);
                      list1.Parent := bout;
                      list1.Visible :=false;
                      for i :=1 to gird.RowCount -1 do
                                list1.Items.Add(gird.Cells[2,i]);
                     list1.Items.SaveToFile(extractFileDir(application.ExeName)+'\temp.dat');
                     list1.Free;
                     gird.Row :=1;
                     flash.Movie :=gird.Cells[2,1];
                     flash.Play;
         end
  except
  end;
end;

procedure TForm1.c4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  try
    begin
       flash.Rewind;
       flash.Playing :=false;
    end
  except
  end;
end;

procedure TForm1.c3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   try
       flash.Playing :=false;
   except
   end;
end;

procedure TForm1.c2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

     try
            flash.Play;
     except
     end;
end;

procedure TForm1.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   a,b,c:double;
begin
try
  begin
  if (flash.Movie ='') or (flash.Playing =false) then exit;
    a:=x;
    b:=a/image2.Width ;
    c:=b*flash.TotalFrames;
    flash.FrameNum :=trunc(c);
    flash.Play;

  end;
except
end;

end;

procedure TForm1.c1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var
     i,k:integer;
begin
    try
       begin
           i:=gird.Row;
           k:=i-1;
           if k<=0  then
                 begin
                      gird.Row :=(gird.RowCount -1);
                      k:=(gird.RowCount -1);
                 end;
           if fileexists(gird.Cells[2,k])=false then
               begin

                       if gird.Row <= 1 then
                                gird.Row :=(gird.RowCount -1)
                            else gird.Row :=gird.Row-1;
                        if gird.Cells[2,gird.Row]='' then exit;
                        gird.Cells[3,k]:='文件不存在';
                        ms.Show;
                       exit;
               end;

           for i :=0 to form1.ControlCount -1 do
                   if form1.Controls[i].ClassName ='TShockwaveFlash' then
                           with form1.Controls[i] as TShockwaveFlash do
                                 begin
                                        stop;
                                        movie:=form1.gird.Cells[2,k];
                                        play;
                                        
                                        gird.row:=k;
                                        exit;

                                  end;
       end
    except
    end;
end;


procedure TForm1.c5MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var
     i,k:integer;
begin
   try
      begin
           i:=gird.Row;
           k:=i+1;
           if k> (gird.RowCount-1) then
                 begin
                      gird.Row :=1;
                      k:=1;
                 end;
           if fileexists(gird.Cells[2,k])=false then
               begin
                       
                       if gird.Row >= (gird.RowCount -1) then
                                gird.Row :=1
                            else gird.Row :=gird.Row+1;
                       if gird.Cells[2,gird.Row]='' then exit;
                       gird.Cells[3,k]:='文件不存在';
                       ms.Show;
                       exit;
               end;

           for i :=0 to form1.ControlCount -1 do
                   if form1.Controls[i].ClassName ='TShockwaveFlash' then
                           with form1.Controls[i] as TShockwaveFlash do
                                 begin
                                        stop;
                                        movie:=form1.gird.Cells[2,k];
                                        play;
                                        
                                        gird.row:=k;
                                        exit;
                                 end;
      end
   except
   end;
end;

procedure TForm1.Shape2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 try
   begin
      image6.Visible :=not image6.Visible;
      if image6.Visible =false then
           shape2.Hint :='自动播放'
         else
           shape2.hint:='不自动播放';
   end
 except
 end;
end;

procedure TForm1.shmenuMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  bout.Show;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
 var
     a,b,c:double;
     i,k:integer;

begin
try
begin
if flash.Movie ='' then exit;
if flash.FrameNum >=(flash.TotalFrames-2) then
   begin
    if image6.Visible =true then
       begin
           i:=gird.Row;
           k:=i+1;
           if k> (gird.RowCount-1) then
                 begin
                      gird.Row :=1;
                      k:=1;
                 end;
           if fileexists(gird.Cells[2,k])=false then
               begin
                       gird.Cells[3,k]:='文件不存在';
                       if gird.Row >= (gird.RowCount -1) then
                                gird.Row :=1
                            else gird.Row :=gird.Row+1;
                       ms.Show;
                       exit;
               end;

           for i :=0 to form1.ControlCount -1 do
                   if form1.Controls[i].ClassName ='TShockwaveFlash' then
                           with form1.Controls[i] as TShockwaveFlash do
                                 begin
                                        stop;
                                        movie:=form1.gird.Cells[2,k];
                                        play;
                                       
                                        form1.gird.Row :=k;
                                        break;
                                 end;
           for i :=0 to form2.Panel2.ControlCount -1 do
                   if form2.Panel2.Controls[i].ClassName ='TShockwaveFlash' then
                           with form2.Panel2.Controls[i] as TShockwaveFlash do
                                 begin
                                        stop;
                                        movie:=form1.gird.Cells[2,k];
                                        play;
                                        
                                        form1.gird.Row :=k;
                                        break;
                                 end;


       end;


    end;
end
except
end;


////////////////////////////////////////
   try
      begin

              form1.lapro.Caption :=inttostr(flash.FrameNum )+'/'+inttostr(flash.TotalFrames );
              a:=flash.FrameNum;
              b:=flash.TotalFrames ;
              form1.lapro.Left :=343-form1.lapro.Width ;
              c:=form1.image3.Width /2;
              form1.image3.Left :=176+trunc((a/b)*161)-trunc(c);
      end
   except
   end;
///////////////////////////////////////////
end;

procedure TForm1.Shape3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 try
   begin
     if  form1.Height =660 then
                begin
                       form1.Height := 435;
                       img_z.Visible :=true;
                       img_s.Visible :=false;
                       img_z.Left :=24;
                       img_z.Top :=image1.Top +2;
                       img_s.Left :=24;
                       img_s.Top :=image1.Top +2;
                       shape3.Hint :='展开文件列表';
                end
            else
                begin
                       form1.Height :=660;
                       img_z.Visible :=false;
                       img_s.Visible :=true;
                       img_z.Left :=24;
                       img_z.Top :=image1.Top +2;
                       img_s.Left :=24;
                       img_s.Top :=image1.Top +2;
                       shape3.Hint :='隐藏文件列表';
                end;
   end
 except
 end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  list1:TlistBox;
  i:integer;
begin


 ///////////////////////////////////////////////////////////////////

 ///////////////////////////////////检测文件是否关联，以便建立文件关联
             try
                 registerFileType('.swf', 'FlashPlayer', 'FlashPlayer', Application.ExeName + ',1', Application.ExeName);
             except
             end;
 ////////////////////////////////////////////////////////////////////
     try
        if paramcount>=1 then
                        flash.Movie :=  ParamStr(1);
     except
     end;



////////////////////////////////////////////////////////////////////

  try
    begin

      form1.Height :=435;
      flash.Quality :=1;
      gird.Cells[1,0]:='文件名';
      gird.Cells[2,0]:='文件来源';
      gird.Cells[3,0]:='总帧数';
      gird.RowCount :=2;

      if FileExists(extractFileDir(application.ExeName)+'\temp.dat')=true then
             begin
                     LIST1:=Tlistbox.Create(self);
                     list1.Parent :=form1;
                     list1.Visible :=false;
                     list1.items.LoadFromFile(extractFileDir(application.ExeName)+'\temp.dat');
                     for i :=0 to list1.Items.Count -1 do
                           begin
                                  gird.Cells[1,gird.RowCount-1 ]:=changeFileExt( ExtractFilename( list1.items.Strings[i]),'');
                                  gird.Cells[2,gird.RowCount-1]:=list1.items.Strings[i];
                                  tempflash.Stop;
                                  if fileexists(list1.items[i])=false then
                                             gird.cells[3,gird.RowCount-1]:='文件不存在'
                                          else
                                             begin
                                                tempflash.Movie:=list1.items.Strings[i];
                                                gird.cells[3,gird.RowCount-1]:=inttostr(tempflash.TotalFrames );
                                             end;
                                  tempflash.Rewind;
                                  tempflash.stop;
                                  gird.RowCount :=gird.RowCount +1;

                           end;
                     list1.Items.SaveToFile(extractFileDir(application.ExeName)+'\temp.dat');
                     list1.Free;
                     if gird.RowCount >2 then
                          gird.RowCount :=gird.RowCount -1;
                     gird.Row :=1;
                     if flash.Movie ='' then
                            begin
                                  i:=1;
                                  while(fileexists(gird.Cells[2,i])=false) do
                                       begin
                                               if i >= gird.RowCount then exit;
                                               i:=i+1;
                                       end;
                                  flash.Movie :=gird.Cells[2,i];
                                  flash.Play;
                            end;


             end;
    end
  finally
             hotkeyid := GlobalAddAtom(pchar('UserDefineHotKey')) - $C000;//减去$C000是为了保证取值范围的限制
             registerhotkey( handle, hotkeyid,MOD_CONTROL, $46);//热键为WIN键+ ctrl+F
             Dragacceptfiles(form1.handle,true);////////////实现文件拖放功能
  end;
end;

procedure TForm1.girdSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
   try
     begin
       if fileexists(gird.Cells[2,arow])=true then
               with flash  do
                  begin
                      stop;
                      movie:=gird.Cells[2,arow];
                      play;
                  end
            else
                  begin
                      if gird.Cells[2,arow]='' then exit;
                      gird.Cells[3,arow]:='文件不存在';
                      ms.Show;
                  end;
       gird.Hint :='名称:'+gird.Cells[1,arow]+chr(10)+chr(13)+'来源:'+gird.Cells[2,arow]+chr(10)+chr(13)+'总帧数:'+gird.Cells[3,arow];
     end
   except
   end;
end;

procedure TForm1.D1Click(Sender: TObject);
var
   i,k:integer;
   list1:Tlistbox;
begin
  try
    begin
     for i :=gird.Row  to gird.RowCount -2 do
            for k:=1 to gird.ColCount -1 do
                   gird.Cells[k,i]:=gird.Cells[k,i+1];
     if gird.Rowcount<=2 then
                   for i :=1 to gird.ColCount -1 do
                         gird.Cells[i,1]:=''
        else
             gird.RowCount :=gird.RowCount -1;
     LIST1:=Tlistbox.Create(self);
     list1.Parent :=form2;
     list1.Visible :=false;
     for i :=1 to gird.Rowcount-1 do
            list1.Items.Add(gird.Cells[2,i]);
     list1.Items.SaveToFile(extractFileDir(application.ExeName)+'\temp.dat');
     list1.Free;
    end
  except
  end;
end;

procedure TForm1.L1Click(Sender: TObject);
var
   k:integer;
   list1:Tlistbox;
begin
  try
    begin
     gird.RowCount:=2;
     for k:=1 to gird.ColCount -1 do
             gird.Cells[k,1]:='';
     LIST1:=Tlistbox.Create(self);
     list1.Parent :=form2;
     list1.Visible :=false;
     list1.Items.SaveToFile(extractFileDir(application.ExeName)+'\temp.dat');
     list1.Free;
    end
  except
  end;

end;

procedure TForm1.A1Click(Sender: TObject);
  var
    i:integer;
    list1:TlistBox;
begin
 try
     if  dia.Execute then
         begin
                      for i :=0 to dia.Files.Count -1 do
                                 begin
                                       if (gird.RowCount =2 ) and ( gird.Cells[2,1]='' ) then
                                                      gird.RowCount :=gird.Rowcount
                                                 else
                                                      gird.RowCount :=gird.RowCount +1;
                                       gird.Cells[1,gird.RowCount-1 ]:=changeFileExt( extractFileName(dia.Files.Strings[i]),'');
                                       gird.Cells[2,gird.RowCount-1]:=dia.Files.Strings[i];
                                       tempflash.Stop;
                                       if fileexists(dia.Files.Strings[i])=false then
                                                   gird.cells[3,gird.RowCount-1]:='文件不存在'
                                             else
                                                   begin
                                                        tempflash.Movie :=dia.Files.Strings[i];
                                                        gird.cells[3,gird.RowCount-1]:=inttostr(tempflash.TotalFrames );
                                                   end;
                                       tempflash.Rewind;
                                       tempflash.stop;
                                 end;

                      list1:=Tlistbox.Create(self);
                      list1.Parent := bout;
                      list1.Visible :=false;
                      for i :=1 to gird.RowCount -1 do
                                list1.Items.Add(gird.Cells[2,i]);
                      list1.Items.SaveToFile(extractFileDir(application.ExeName)+'\temp.dat');
                      list1.Free;
         end
  except
  end;
end;

procedure TForm1.shmaxMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
       form1.CloseForm;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   unregisterhotkey(handle, hotkeyid);
   DeleteAtom(HotKeyID);//消除热键
end;

end.
