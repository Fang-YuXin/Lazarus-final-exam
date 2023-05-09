unit unitfrmb02;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  DateTimePicker,DB;

type

  { TFrmB02 }

  TFrmB02 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    DateTimePicker1: TDateTimePicker;
    DBGrid1: TDBGrid;
    EditEID: TEdit;
    EditName: TEdit;
    EditBirth: TEdit;
    EditTel: TEdit;
    EditAddress: TEdit;
    EditEmail: TEdit;
    EditPassword: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure DateTimePicker1Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure EditBirthClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  FrmB02: TFrmB02;

implementation
uses unitFrm000;

{$R *.lfm}

{ TFrmB02 }

procedure TFrmB02.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  closeaction:= cafree;
    FrmB02:=nil;
end;

procedure TFrmB02.Button1Click(Sender: TObject);
begin
    If EditEID.Text <> NULL then
      with Frm000.SQLQueryScriptB01 do
        begin
          if not Frm000.SQLQueryB01.Locate('顧客編號',EditEID.Text,[loPartialKey]) then
            begin
            Append;
            fieldbyname('顧客編號').asstring:=EditEID.text;
            fieldbyname('顧客名稱').asstring:=EditName.text;
            fieldbyname('生日').asstring:=EditBirth.text;
            fieldbyname('電話').asstring:=EditTel.text;
            fieldbyname('地址').asstring:=EditAddress.text;
            fieldbyname('Email').asstring:=EditEmail.text;
            fieldbyname('密碼').asstring:=EditPassword.text;
            post;
            applyupdates;
            Frm000.SQLTransactionScriptB01.CommitRetaining;
            Frm000.SQLQueryB01.refresh;
            showmessage('資料已經正確新增');
            end
          else
            showmessage('資料新增時發生錯誤，原因: 顧客編號重複');
        end
    else
      showmessage('項目不得為空白');
      Frm000.SQLQueryB01.Locate('顧客編號',EditEID.Text,[loPartialKey]);

end;

procedure TFrmB02.Button2Click(Sender: TObject);
var sqlstr: string;
begin
    If (length(EditEID.Text)>0) and Frm000.SQLQueryB01.Locate('顧客編號',EditEID.Text,[loPartialKey]) then
      If messageDlg('確定要刪除顧客資料?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
      begin
        with Frm000.SQLQueryScriptB01 do
          begin
            Try
              sqlstr:='delete from 顧客資料 where 顧客編號= '''+ EditEID.Text +'''';
              Frm000.SQLQueryScriptB01.SQL.Text := sqlstr;
              Frm000.SQLQueryScriptB01.Close;
              Frm000.SQLQueryScriptB01.ExecSQL;

              Frm000.SQLTransactionScriptB01.Commit;
              showmessage('資料已經刪除');
            except
              showmessage('資料刪除時發生錯誤');
            end;
          end;
        Frm000.SQLQueryB01.Refresh;
      end;
end;

procedure TFrmB02.Button3Click(Sender: TObject);
var sqlstr: string;
begin
    if (length(EditEID.Text) > 0) and Frm000.SQLQueryB01.Locate('顧客編號',EditEID.Text, [loPartialKey])then
      if messageDlg('確定要修改顧客資料?', mtConfirmation,[mbYes,mbNo],0)=mrYes then
        begin
          with Frm000.SQLQueryScriptB01 do
            begin
              Try
              sqlstr:='update 顧客資料 set 顧客名稱= :name,  生日= :birth, 電話= :tel, 地址= :address, Email= :email, 密碼= :password where 顧客編號= :EID';
              Frm000.SQLQueryScriptB01.SQL.Text := sqlstr;
              Params.ParamByName('name').AsString :=EditName.Text;
              Params.ParamByName('birth').AsString :=EditBirth.Text;
              Params.ParamByName('tel').AsString :=EditTel.Text;
              Params.ParamByName('address').AsString :=EditAddress.Text;
              Params.ParamByName('email').AsString :=EditEmail.Text;
              Params.ParamByName('password').AsString :=EditPassword.Text;
              Params.ParamByName('EID').AsString :=EditEID.Text;
              Frm000.SQLQueryScriptB01.Close;
              Frm000.SQLQueryScriptB01.ExecSQL;
              Frm000.SQLTransactionScriptB01.Commit;
              except
              showmessage('資料修改時發生錯誤');
              end;
            end;
          Frm000.SQLQueryB01.Refresh;
          Frm000.SQLQueryB01.Locate('顧客編號',EditEID.Text,[loPartialKey])
        end;
end;

procedure TFrmB02.DateTimePicker1Click(Sender: TObject);
begin
    EditBirth.Text :=DateTostr(DateTimePicker1.date);
    DateTimePicker1.Visible:=False;
end;

procedure TFrmB02.DBGrid1CellClick(Column: TColumn);
begin
    EditEID.Text:=Frm000.SQLQueryB01.fieldbyName('顧客編號').value;

    if Frm000.SQLQueryB01.fieldbyName('顧客名稱').IsNull then
    EditName.Text:=''
    else
    EditName.Text:= Frm000.SQLQueryB01.fieldbyName('顧客名稱').value;

    if Frm000.SQLQueryB01.fieldbyName('生日').IsNull then
    EditBirth.Text:=''
    else
    EditBirth.Text:= Frm000.SQLQueryB01.fieldbyName('生日').value;

    if Frm000.SQLQueryB01.fieldbyName('電話').IsNull then
    EditTel.Text:=''
    else
    EditTel.Text:= Frm000.SQLQueryB01.fieldbyName('電話').value;

    if Frm000.SQLQueryB01.fieldbyName('地址').IsNull then
    EditAddress.Text:=''
    else
    EditAddress.Text:= Frm000.SQLQueryB01.fieldbyName('地址').value;

    if Frm000.SQLQueryB01.fieldbyName('Email').IsNull then
    EditEmail.Text:=''
    else
    EditEmail.Text:= Frm000.SQLQueryB01.fieldbyName('Email').value;

    if Frm000.SQLQueryB01.fieldbyName('密碼').IsNull then
    EditPassword.Text:=''
    else
    EditPassword.Text:= Frm000.SQLQueryB01.fieldbyName('密碼').value;

end;

procedure TFrmB02.EditBirthClick(Sender: TObject);
begin
    DateTimePicker1.Visible :=not DateTimePicker1.Visible;
    EditBirth:=(Sender as TEdit);
end;

end.

