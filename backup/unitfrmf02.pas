unit unitfrmf02;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids,
  StdCtrls, DBCtrls, ExtCtrls, DateTimePicker,DB, MSSQLConn, SQLDB;

type

  { TFrmF02 }

  TFrmF02 = class(TForm)
    BtnAppend: TButton;
    BtnUpdate: TButton;
    ComboBoxDepart: TComboBox;
    ComboBoxPosi: TComboBox;
    ComboBoxWork: TComboBox;
    DateTimePicker1: TDateTimePicker;
    DBGrid1: TDBGrid;
    EditPhone: TEdit;
    EditName: TEdit;
    EditEmail: TEdit;
    EditEID: TEdit;
    Label10: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    procedure BtnAppendClick(Sender: TObject);
    procedure BtnUpdateClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormActivate(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FrmF02: TFrmF02;

implementation
  uses unitFrm000;
{$R *.lfm}

{ TFrmF02 }

procedure TFrmF02.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  closeaction:= cafree;
    FrmF02:=nil;
end;

procedure TFrmF02.FormCreate(Sender: TObject);
begin
  with Frm000.SQLQuery1 do begin

      Frm000.SQLQueryEmployee.SQL.Text:= 'SELECT * FROM 員工資料';
      Close;
      ExecSQL;

      Frm000.SQLQueryEmployee.Locate('員工名稱','L00001',[loPartialKey]);

      Frm000.SQLQueryEmployee.refresh;

    end;
end;

procedure TFrmF02.BtnAppendClick(Sender: TObject);
var
  count: integer;
  ID: string;
  job: string;
  department: string;
  working: string;
begin

     count:=Frm000.SQLQueryEmployee.recordcount; //數幾行

      if length(inttostr(count))=1 then
      begin
        ID := 'L0000'+IntToStr(count+1);
      end;
      if length(inttostr(count))=2 then
      begin
        ID := 'L000'+IntToStr(count+1);
      end;
      if length(inttostr(count))=3 then
      begin
        ID := 'L00'+IntToStr(count+1);
      end;
      if length(inttostr(count))=4 then
      begin
        ID := 'L0'+IntToStr(count+1);
      end;
      if length(inttostr(count))=5 then
      begin
        ID := 'L'+IntToStr(count+1);
      end;




      with Frm000.SQLQuery1 do
        if  length(EditName.Text)=0 then begin
           showmessage('資料新增時發生錯誤,原因:姓名不得空白');
        end
        else if  length(EditPhone.Text)<>10 then begin
           showmessage('資料新增時發生錯誤,原因:電話格式錯誤');
        end

        else if not Locate('員工編號',ID,[loPartialkey]) then
          begin
          Append;

          fieldbyName('員工編號').asstring:=ID;
          //showmessage(fieldbyName('員工編號').asstring);
          fieldbyName('員工名稱').asstring:=EditName.text;
          fieldbyName('生日').asdatetime:=DateTimePicker1.date;
          fieldbyName('員工部門').asstring:=ComboBoxDepart.Text;
          fieldbyName('職位').asstring:=ComboBoxPosi.Text;
          fieldbyName('電話').asstring:=EditPhone.text;
          fieldbyName('Email').asstring:=EditEmail.text;
          fieldbyName('就職狀況').asstring:=ComboBoxWork.Text;
          post;
          applyupdates;

            Frm000.SQLTransaction1.CommitRetaining;
          Frm000.SQLQueryEmployee.refresh;
          showmessage('員工資料已經正確新增');

          end;

end;

procedure TFrmF02.BtnUpdateClick(Sender: TObject);
var sqlstr: string;
  work: string;
  posi: string;
  depart: string;
begin


  if (length(EditEID.Text)>0) and Frm000.SQLQueryEmployee.Locate('員工編號',EditEID.Text,[loPartialKey]) then BEGIN
     if messageDlg('確定要修改資料？',mtConfirmation,[mbYes,mbNo],0)=mrYes then
      begin
        with Frm000.SQLQuery1 do
          begin
          Try
             if(length(EditName.Text)>0) then begin
             sqlstr:='update 員工資料 set 員工名稱='''+EditName.Text+''' where 員工編號='''+EditEID.Text+'''';
             Frm000.SQLQuery1.SQL.Text := sqlstr ;
             Close;
             ExecSQL;
             Frm000.SQLTransaction1.Commit;
             end;

             if(length(EditEmail.Text)>0) then begin
             sqlstr:='update 員工資料 set Email='''+EditEmail.Text+''' where 員工編號='''+EditEID.Text+'''';
             Frm000.SQLQuery1.SQL.Text := sqlstr ;
             Close;
             ExecSQL;
             Frm000.SQLTransaction1.Commit;
             end;

             if(length(EditPhone.Text)>0) then begin
             sqlstr:='update 員工資料 set 電話='''+EditPhone.Text+''' where 員工編號='''+EditEID.Text+'''';
             Frm000.SQLQuery1.SQL.Text := sqlstr ;
             Close;
             ExecSQL;
             Frm000.SQLTransaction1.Commit;
             end;

             if (length(ComboBoxPosi.Text)<>0) then begin
             sqlstr:='update 員工資料 set 職位=''' + ComboBoxPosi.Text + ''' where 員工編號='''+EditEID.Text+'''';
             Frm000.SQLQuery1.SQL.Text := sqlstr ;
             Close;
             ExecSQL;
             Frm000.SQLTransaction1.Commit;
             end;

             if (length(ComboBoxDepart.Text)<>0) then begin
             sqlstr:='update 員工資料 set 員工部門=''' + ComboBoxDepart.Text + ''' where 員工編號='''+EditEID.Text+'''';
             Frm000.SQLQuery1.SQL.Text := sqlstr ;
             Close;
             ExecSQL;
             Frm000.SQLTransaction1.Commit;
             end;

             if (length(ComboBoxWork.Text)<>0) then begin
             sqlstr:='update 員工資料 set 就職狀況=''' + ComboBoxWork.Text + ''' where 員工編號='''+EditEID.Text+'''';
             Frm000.SQLQuery1.SQL.Text := sqlstr ;
             Close;
             ExecSQL;
             Frm000.SQLTransaction1.Commit;
             end;
             showmessage('資料已經修改');
          except
                showmessage('資料修改時發生錯誤');
          end;//try

        end;//with sqlquery1
      Frm000.SQLQueryEmployee.refresh;

      Frm000.SQLQueryEmployee.Locate('員工編號',EditEID.Text,[loPartialKey]);
      end//if messageDlg('確定要修改商品資料？'.mtConfirmation. [mbYes.mbNo].0=mrYes then

      else begin showmessage('wrong ID'); end;

      end;

end;

procedure TFrmF02.DBGrid1CellClick(Column: TColumn);
begin
  EditEID.Text:=Frm000.SQLQueryEmployee.fieldbyName('員工編號').value;
  EditName.Text:= Frm000.SQLQueryEmployee.fieldbyName('員工名稱').value;
end;

procedure TFrmF02.FormActivate(Sender: TObject);
begin
  with Frm000.SQLQuery1 do begin

    Frm000.SQLQueryEmployee.SQL.Text:= 'SELECT * FROM 員工資料';
    Close;
    ExecSQL;

    Frm000.SQLQueryEmployee.Locate('員工名稱','L00001',[loPartialKey]);

    Frm000.SQLQueryEmployee.refresh;

  end;
end;

procedure TFrmF02.FormClick(Sender: TObject);
begin
  with Frm000.SQLQuery1 do begin

    Frm000.SQLQueryEmployee.SQL.Text:= 'SELECT * FROM 員工資料';
    Close;
    ExecSQL;

    Frm000.SQLQueryEmployee.Locate('員工名稱','L00001',[loPartialKey]);

    Frm000.SQLQueryEmployee.refresh;

  end;

end;



end.

