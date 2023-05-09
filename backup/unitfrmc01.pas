unit unitfrmc01;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, MSSQLConn, Forms, Controls, Graphics, Dialogs,
  StdCtrls, DBGrids;

type

  { TFrmC01 }

  TFrmC01 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  FrmC01: TFrmC01;

implementation
   uses unitFrm000;
{$R *.lfm}

{ TFrmC01 }

procedure TFrmC01.Button1Click(Sender: TObject);
begin
   if not Frm000.SQLQueryC01.Locate('商品編號',Edit1.Text,[loPartialKey]) then begin
   showmessage('查無此商品編號');
   end

end;

procedure TFrmC01.Button2Click(Sender: TObject);
begin
    if not Frm000.SQLQueryC01.Locate('商品名稱',Edit1.Text,[loPartialKey]) then begin
   showmessage('查無此商品名稱');
   end
end;

procedure TFrmC01.DBGrid1CellClick(Column: TColumn);
begin

end;

procedure TFrmC01.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  closeaction:= cafree;
    FrmC01:=nil;
end;

end.

