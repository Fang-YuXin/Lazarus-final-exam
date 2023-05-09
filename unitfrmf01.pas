unit unitfrmf01;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, StdCtrls,
  ExtCtrls, DBCtrls, DB;

type

  { TFrmF01 }

  TFrmF01 = class(TForm)
    Btnclear: TButton;
    Btnworking: TButton;
    ComboBoxDepart: TComboBox;
    ComboBoxPosi: TComboBox;
    ComboBoxWork: TComboBox;
    DBGrid1: TDBGrid;
    EditQueryStr: TEdit;
    Label1: TLabel;

    procedure BtnclearClick(Sender: TObject);
    procedure BtnworkingClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);


  private

  public

  end;

var
  FrmF01: TFrmF01;

implementation
  uses unitFrm000;
{$R *.lfm}

  { TFrmF01 }

procedure TFrmF01.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:= cafree;
  FrmF01:=nil;
end;

procedure TFrmF01.BtnworkingClick(Sender: TObject);
var
  count: integer;
  sqlstr: string;
begin
    with Frm000.SQLQuery1 do begin
    Try

          //如果沒編號姓名


            //3 both
            if (length( ComboBoxPosi.Text) > 0) and (length( ComboBoxDepart.Text) > 0) and (length( ComboBoxWork.Text) > 0) then begin
            sqlstr:= ' SELECT * FROM 員工資料 WHERE 職位=''' + ComboBoxPosi.Text + ''' and 員工部門=''' + ComboBoxDepart.Text + ''' and 就職狀況=''' + ComboBoxWork.Text + '''';
            Frm000.SQLQueryEmployee.SQL.Text := sqlstr;
            Close;
            ExecSQL;
            end


            //2 both
            else if (length( ComboBoxPosi.Text) > 0) and (length( ComboBoxDepart.Text) > 0) then begin
            sqlstr:= ' SELECT * FROM 員工資料 WHERE 職位=''' + ComboBoxPosi.Text + ''' and 員工部門=''' + ComboBoxDepart.Text + '''';
            Frm000.SQLQueryEmployee.SQL.Text := sqlstr;
            Close;
            ExecSQL;
            Frm000.SQLTransaction1.Commit;
            end
            else if (length( ComboBoxPosi.Text) > 0) and (length( ComboBoxWork.Text) > 0) then begin
            sqlstr:= ' SELECT * FROM 員工資料 WHERE 職位=''' + ComboBoxPosi.Text + ''' and 就職狀況=''' + ComboBoxWork.Text + '''';
            Frm000.SQLQueryEmployee.SQL.Text := sqlstr;
            Close;
            ExecSQL;
            Frm000.SQLTransaction1.Commit;
            end
            else if (length( ComboBoxDepart.Text) > 0) and (length( ComboBoxWork.Text) > 0) then begin
            sqlstr:= ' SELECT * FROM 員工資料 WHERE 員工部門=''' + ComboBoxDepart.Text + ''' and 就職狀況=''' + ComboBoxWork.Text + '''';
            Frm000.SQLQueryEmployee.SQL.Text := sqlstr;
            Close;
            ExecSQL;
            Frm000.SQLTransaction1.Commit;
            end

            //1
            else if (length( ComboBoxPosi.Text) > 0) then begin
            sqlstr:= ' SELECT * FROM 員工資料 WHERE 職位=''' + ComboBoxPosi.Text + '''';
            Frm000.SQLQueryEmployee.SQL.Text := sqlstr;
            Close;
            ExecSQL;
            Frm000.SQLTransaction1.Commit;
            end
            else if (length( ComboBoxWork.Text) > 0) then begin
            sqlstr:= ' SELECT * FROM 員工資料 WHERE 就職狀況=''' + ComboBoxWork.Text + '''';
            Frm000.SQLQueryEmployee.SQL.Text := sqlstr;
            Close;
            ExecSQL;
            Frm000.SQLTransaction1.Commit;
            end
            else if (length( ComboBoxDepart.Text) > 0) then begin
            sqlstr:= ' SELECT * FROM 員工資料 WHERE 員工部門=''' + ComboBoxDepart.Text + '''';
            Frm000.SQLQueryEmployee.SQL.Text := sqlstr;
            Close;
            ExecSQL;
            Frm000.SQLTransaction1.Commit;
            end;


          //如果有編號姓名
          if (length(EditQueryStr.Text) > 0)then begin
            sqlstr:= ' SELECT * FROM 員工資料 WHERE 員工編號='''+ EditQueryStr.Text + ''' or 員工名稱=''' + EditQueryStr.Text + '''';
            Frm000.SQLQueryEmployee.SQL.Text := sqlstr;
            Close;
            ExecSQL;
            Frm000.SQLTransaction1.Commit;
          end;

    except
          showmessage('資料查詢時發生錯誤');
    end;//try
    end;//with sqlquery1
    Frm000.SQLQueryEmployee.refresh;


end;

procedure TFrmF01.BtnclearClick(Sender: TObject);
begin
    with Frm000.SQLQuery1 do
    begin
      Frm000.SQLQueryEmployee.SQL.Text:= 'SELECT * FROM 員工資料';
      Close;
      ExecSQL;
      Frm000.SQLQueryEmployee.Locate('員工名稱','L00001',[loPartialKey]);
      Frm000.SQLQueryEmployee.refresh;
    end;
end;


end.










end.

