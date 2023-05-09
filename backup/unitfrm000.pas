unit unitfrm000;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, MSSQLConn, Forms, Controls, Graphics, Dialogs,
  Menus, StdCtrls,unitfrma01Session;

type

  { TFrm000 }

  TFrm000 = class(TForm)
    dataSource: TDataSource;
    DataSourceB01: TDataSource;
    DataSourceOrder: TDataSource;
    DataSourceOrderDetails: TDataSource;
    DataSourceDeliveryLookUp: TDataSource;
    DataSourceCustomerLookUp: TDataSource;
    DataSourceProductLookUp: TDataSource;
    DataSourceProduct2: TDataSource;
    DataSourceSstatueLookUp: TDataSource;
    DataSourceC01: TDataSource;
    DataSourceD02: TDataSource;
    DataSourceProduct: TDataSource;
    DataSourceEmployee: TDataSource;
    MainMenu1: TMainMenu;
    A0: TMenuItem;
    A01: TMenuItem;
    A02: TMenuItem;
    B0: TMenuItem;
    B01: TMenuItem;
    B02: TMenuItem;
    C0: TMenuItem;
    C01: TMenuItem;
    C02: TMenuItem;
    D0: TMenuItem;
    D01: TMenuItem;
    D02: TMenuItem;
    E0: TMenuItem;
    E01: TMenuItem;
    E02: TMenuItem;
    F0: TMenuItem;
    F01: TMenuItem;
    F02: TMenuItem;
    MSSQLConnection1: TMSSQLConnection;
    MSSQLConnectionB01: TMSSQLConnection;
    MSSQLConnectionUser: TMSSQLConnection;
    MSSQLConnectionScriptB01: TMSSQLConnection;
    MSSQLConnectionDeliveryScript: TMSSQLConnection;
    MSSQLConnectionOrder: TMSSQLConnection;
    MSSQLConnectionOrderDetails: TMSSQLConnection;
    MSSQLConnectionDeliveryLookUp: TMSSQLConnection;
    MSSQLConnectionCustomerLookUp: TMSSQLConnection;
    MSSQLConnectionProductLookUp: TMSSQLConnection;
    MSSQLConnectionProduct2: TMSSQLConnection;
    MSSQLConnectionSstatuScript: TMSSQLConnection;
    MSSQLConnectionSstatueLookUp: TMSSQLConnection;
    MSSQLConnectionC01: TMSSQLConnection;
    MSSQLConnectionD02: TMSSQLConnection;
    MSSQLConnectionD022: TMSSQLConnection;
    MSSQLConnectionProduct: TMSSQLConnection;
    MSSQLConnectionEmployee: TMSSQLConnection;
    sqlConnector: TSQLConnector;
    sqlQuery: TSQLQuery;
    SQLQuery1: TSQLQuery;
    sqlProcurement: TSQLQuery;
    SQLQueryUser: TSQLQuery;
    SQLQueryB01: TSQLQuery;
    SQLQueryScriptB01: TSQLQuery;
    SQLQueryDeliveryScript: TSQLQuery;
    SQLQueryOrder: TSQLQuery;
    SQLQueryOrderDetails: TSQLQuery;
    SQLQueryDeliveryLookUp: TSQLQuery;
    SQLQueryCustomerLookUp: TSQLQuery;
    SQLQueryProductLookUp: TSQLQuery;
    SQLQueryProduct2: TSQLQuery;
    SQLQuerySstatuScript: TSQLQuery;
    SQLQuerySstatueLookUp: TSQLQuery;
    SQLQueryC01: TSQLQuery;
    SQLQueryD02: TSQLQuery;
    SQLQueryD022: TSQLQuery;
    SQLQueryProduct: TSQLQuery;
    SQLQueryEmployee: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    sqlTransaction: TSQLTransaction;
    SQLTransactionUser: TSQLTransaction;
    SQLTransactionB01: TSQLTransaction;
    SQLTransactionScriptB01: TSQLTransaction;
    SQLTransactionDeliveryScript: TSQLTransaction;
    SQLTransactionOrder: TSQLTransaction;
    SQLTransactionOrderDetails: TSQLTransaction;
    SQLTransactionDeliveryLookUp: TSQLTransaction;
    SQLTransactionCustomerLookUp: TSQLTransaction;
    SQLTransactionProductLookUp: TSQLTransaction;
    SQLTransactionProduct2: TSQLTransaction;
    SQLTransactionSstatuScript: TSQLTransaction;
    SQLTransactionSstatueLookUp: TSQLTransaction;
    SQLTransactionC01: TSQLTransaction;
    SQLTransactionD02: TSQLTransaction;
    SQLTransactionD022: TSQLTransaction;
    SQLTransactionProduct: TSQLTransaction;
    SQLTransactionEmployee: TSQLTransaction;
    procedure A01Click(Sender: TObject);
    procedure A02Click(Sender: TObject);
    procedure B01Click(Sender: TObject);
    procedure B02Click(Sender: TObject);
    procedure C01Click(Sender: TObject);
    procedure C02Click(Sender: TObject);
    procedure D01Click(Sender: TObject);
    procedure D02Click(Sender: TObject);
    procedure E01Click(Sender: TObject);
    procedure E02Click(Sender: TObject);
    procedure F01Click(Sender: TObject);
    procedure F02Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Frm000: TFrm000;

implementation
  uses unitfrma01,unitfrma02,unitfrmb01,unitfrmb02,unitfrmc01,unitfrmc02,unitfrmd01,unitfrmd02,unitfrme01,unitfrmf01,unitfrmf02;
{$R *.lfm}

{ TFrm000 }

procedure TFrm000.A02Click(Sender: TObject);
begin
  close;
end;

procedure TFrm000.B01Click(Sender: TObject);
begin
  If not Assigned(FrmB01) then
     FrmB01:= TFrmB01.Create(Frm000);
  FrmB01.show
end;

procedure TFrm000.B02Click(Sender: TObject);
begin
  If not Assigned(FrmB02) then
     FrmB02:= TFrmB02.Create(Frm000);
  FrmB02.show
end;

procedure TFrm000.A01Click(Sender: TObject);
begin
  FrmA01.show
end;

procedure TFrm000.C01Click(Sender: TObject);
begin
   if not Assigned(FrmC01) then
     FrmC01:= TFrmC01.Create(Frm000);
  FrmC01.show
end;

procedure TFrm000.C02Click(Sender: TObject);
begin
   if not Assigned(FrmC02) then
     FrmC02:= TFrmC02.Create(Frm000);
   FrmC02.show
end;

procedure TFrm000.D01Click(Sender: TObject);
begin
   if not Assigned(FrmD01) then
     FrmD01:= TFrmD01.Create(Frm000);
   FrmD01.show

end;

procedure TFrm000.D02Click(Sender: TObject);
begin
   if not Assigned(FrmD02) then
     FrmD02:= TFrmD02.Create(Frm000);
  FrmD02.show
end;

procedure TFrm000.E01Click(Sender: TObject);
begin
  FrmE01.cmd:= 'E01';
  FrmE01.show();

end;

procedure TFrm000.E02Click(Sender: TObject);
begin
  FrmE01.cmd:= 'E02';
  FrmE01.show();
end;

procedure TFrm000.F01Click(Sender: TObject);
begin
   if not Assigned(FrmF01) then
     FrmF01:= TFrmF01.Create(Frm000);
  FrmF01.show

end;

procedure TFrm000.F02Click(Sender: TObject);
begin
   if not Assigned(FrmF02) then
     FrmF02:= TFrmF02.Create(Frm000);
  FrmF02.show
end;

procedure TFrm000.FormActivate(Sender: TObject);
var group : string;
begin


end;

procedure TFrm000.FormCreate(Sender: TObject);
begin

end;

end.

