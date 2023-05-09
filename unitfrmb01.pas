unit unitfrmb01;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, DB,Graphics, Dialogs, StdCtrls, DBGrids;

type

  { TFrmB01 }

  TFrmB01 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  FrmB01: TFrmB01;

implementation
uses unitFrm000;

{$R *.lfm}

{ TFrmB01 }

procedure TFrmB01.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  closeaction:= cafree;
    FrmB01:=nil;
end;

procedure TFrmB01.Button1Click(Sender: TObject);
begin
    if not Frm000.SQLQueryB01.Locate('顧客編號',Edit1.Text,[loPartialKey]) then
    begin
    showmessage('查無此顧客編號');
    end;
end;

procedure TFrmB01.Button2Click(Sender: TObject);
begin
    begin
    Frm000.SQLQueryB01.Locate('顧客名稱',Edit1.Text,[loPartialKey]);
    end;
end;

end.

