unit unitfrma01;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls,unitfrma01Session,DB;

type

  { TFrmA01 }

  TFrmA01 = class(TForm)
    btnLogin: TButton;
    StaticText1: TStaticText;
    SubLabel: TBoundLabel;
    txtUsername: TLabeledEdit;
    txtPassword: TLabeledEdit;
    procedure btnLoginClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  FrmA01: TFrmA01;

implementation
uses unitFrm000;

{$R *.lfm}

{ TFrmA01 }

procedure TFrmA01.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  closeaction:= cafree;
  FrmA01:=nil;
end;

procedure TFrmA01.btnLoginClick(Sender: TObject);
var user: string;
    pass: string;
begin
   user := txtUsername.Text;
   pass := txtPassword.Text;

   if user.Length <= 0 then
   begin
        Application.MessageBox(PChar('用戶名是必需的'), '錯誤');
        exit;
   end;

   if pass.Length <= 0 then
   begin
        Application.MessageBox(PChar('密碼是必需的'), '錯誤');
        exit;
   end;



   if not Frm000.sqlQuery.Locate('使用者編號',user,[LoPartialKey]) then
    begin
    showmessage('無使用者');
    end;



   if Frm000.sqlQuery.FieldByName('使用者編號').AsString <> user then
   begin
     Application.MessageBox(PChar('User not found'), '錯誤');
     exit;
   end;

   if Frm000.sqlQuery.FieldByName('使用者密碼').AsString <> pass then
   begin
     Application.MessageBox(PChar('您的密碼不正確。 請再試一次！'), '錯誤');
     exit;
   end;

   Application.MessageBox(PChar('登錄成功'), '信息');

   //使用者職位
   if Frm000.sqlQuery.FieldByName('使用者職位').AsString = '主管' then
   begin
      Frm000.E0.enabled:= True;
      Frm000.B0.enabled:= True;
      Frm000.C0.enabled:= True;
      Frm000.D0.enabled:= True;
      Frm000.F0.enabled:= True;

   end;
   if Frm000.sqlQuery.FieldByName('使用者職位').AsString = '員工' then
   begin
      Frm000.E0.enabled:= True;
      Frm000.B0.enabled:= True;
      Frm000.C0.enabled:= True;
      Frm000.D0.enabled:= True;
      Frm000.F0.enabled:= False;
   end;

   FrmA01.hide;
   //end;
   Refresh;

   txtUsername.Text := '';
   txtPassword.Text := '';


end;

procedure TFrmA01.FormActivate(Sender: TObject);
begin
    txtUsername.Text := '';
    txtPassword.Text := '';
end;

end.

