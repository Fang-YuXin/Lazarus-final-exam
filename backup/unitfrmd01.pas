unit unitfrmd01;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, MSSQLConn, SQLDB, DB, Forms, Controls, Graphics, Dialogs,
  DBGrids, StdCtrls, ColorBox, DBCtrls;

type

  { TFrmD01 }

  TFrmD01 = class(TForm)
    Button1: TButton;
    ButtonDelivery: TButton;
    ButtonSstatu: TButton;
    DBGridOrder: TDBGrid;
    DBGridOrder1: TDBGrid;
    CustomerName: TDBLookupComboBox;
    ProductName: TDBLookupComboBox;
    Delivery: TDBLookupComboBox;
    Sstatu: TDBLookupComboBox;
    Sdate: TEdit;
    Snum_1: TEdit;
    Pnum: TEdit;
    SalePrice: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure ButtonDeliveryClick(Sender: TObject);
    procedure ButtonSstatuClick(Sender: TObject);
    procedure DBGridOrderCellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure ProductNameChange(Sender: TObject);
  private

  public

  end;

var
  FrmD01: TFrmD01;
  Sid:string;
  OrderSstatu:string;

implementation
uses unitFrm000;

{$R *.lfm}

{ TFrmD01 }

//提取訂單編號的函式
function extractnumbers(line: string): string;
const
  n = ['0'..'9'];
var
  i: integer;
begin
  i := 1;
  extractnumbers :='';
  while  i < length(line)+1 do
  begin
    if line[i] in n then extractnumbers := extractnumbers + line[i];
    inc(i);
  end;
end;

procedure TFrmD01.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  closeaction:= cafree;
    FrmD01:=nil;
end;

procedure TFrmD01.ProductNameChange(Sender: TObject);
var PNAME:string;
var Pnum0: integer;
var SalePrice0: integer;
begin

  //找尋商品單價與庫存
  PNAME := ProductName.KeyValue;
  if not Frm000.SQLQueryProduct2.Locate('商品編號',PNAME,[LoPartialKey]) then
  begin
  showmessage('查無商品');
  end;

  try
    Pnum0 := Frm000.SQLQueryProduct2.FieldByName('庫存').AsInteger;
    SalePrice0 := Frm000.SQLQueryProduct2.FieldByName('售價').AsInteger;

    SalePrice.text := inttostr(SalePrice0);
    Pnum.text := inttostr(Pnum0);
    Frm000.SQLQueryProduct2.Refresh;
  finally
    Frm000.SQLQueryProduct2.Refresh;
  end;

end;

procedure TFrmD01.Button1Click(Sender: TObject);
var astr:string;
var a0:integer;

var a:string;
var b:string;

var SalePrice_0:integer;
var TotalPrice:integer;
var PNAME:string;
var Count:integer;
var Pnum_0:integer;
begin


     refresh;


//檢查庫存是否足夠
     Pnum_0 := strtoint(Pnum.text);
     if strtoint(Pnum.text) < strtoint(Snum_1.text) then
       begin
       showmessage('商品庫存不足，採購部該採購此商品');
       end;


//計算總金額
     with Frm000.SQLQueryProductLookUp do
       begin
       PNAME := ProductName.KeyValue;
       SalePrice_0 := strtoint(SalePrice.text);
       TotalPrice := SalePrice_0*strToint(Snum_1.text);
       end;




//新增訂單管理資訊
     with Frm000.SQLQueryOrder do
       begin
         astr:=Frm000.SQLQueryOrder.Fields[0].Asstring;  //提取最大值訂單編號
         a:= extractnumbers(astr);    //訂單編號(沒有S)
         a0 := strtoint(a)+1;          //訂單編號+1
         b := 'S000'+IntToStr(a0);

         if not Locate('訂單編號',b,[loCaseInsensitive]) then
           begin
              Append;
              FieldByName('訂單編號').asstring := b ;
              fieldbyName('訂購日期').asstring:=Sdate.text;
              fieldbyName('總金額').asinteger:=TotalPrice;
              fieldbyName('訂單狀態').asstring:='未確認';
              fieldbyName('繳費狀態').asstring:='未繳費';
              fieldbyName('送貨方式').asstring:=Delivery.KeyValue;

              post;
              applyupdates;
              Frm000.SQLTransactionOrder.CommitRetaining;
              Frm000.SQLQueryOrder.refresh;
              showmessage('訂單資料已經正確新增');
            end
          else
          showmessage('項目不得為空白');
       end;


     with Frm000.SQLQueryOrderDetails do
       begin

         Append;
         FieldByName('訂單編號').asstring := b ;
         fieldbyName('訂購日期').asstring:=Sdate.text;
         fieldbyName('顧客編號').asstring:=CustomerName.KeyValue;
         fieldbyName('商品編號').asstring:=PNAME;
         fieldbyName('數量').asinteger:=strToint(Snum_1.text);
         fieldbyName('售價').asinteger:=SalePrice_0;
         fieldbyName('總價').asinteger:=TotalPrice;

         post;
         applyupdates;
         Frm000.SQLTransactionOrderDetails.CommitRetaining;
         Frm000.SQLQueryOrderDetails.refresh;

       end;


end;

procedure TFrmD01.ButtonDeliveryClick(Sender: TObject);
var sqlstr:string;
begin

  with Frm000.SQLQueryDeliveryScript do
    begin


      if OrderSstatu <> '已出貨' then
      begin
          Try
          sqlstr:='update 訂單管理 set 送貨方式=:Delivery where 訂單編號=:Sid';
          SQL.Text := sqlstr;
          Params.ParamByName('Delivery').AsString := Delivery.KeyValue;
          Params.ParamByName('Sid').AsString := Sid;

          Frm000.SQLQueryDeliveryScript.Close;
          Frm000.SQLQueryDeliveryScript.ExecSQL;
          //Close; 要往上移 不然會出現一個視窗顯示error
          Frm000.SQLTransactionDeliveryScript.Commit;
          showmessage('已修改送貨方式');
        except
          showmessage('資料修改時發生錯誤');
        end;

        end

      else
      begin
        showmessage('該訂單已出貨，無法改變送貨方式。');

      end;

end;
   Frm000.SQLQueryOrder.Refresh;
   Frm000.SQLQueryOrder.Locate('訂單編號',Sid,[loPartialKey]);


end;

procedure TFrmD01.ButtonSstatuClick(Sender: TObject);
var sqlstr:string;
begin

   with Frm000.SQLQuerySstatuScript do
    begin


      if Sstatu.KeyValue <> '已繳費' then
      begin
          Try
          sqlstr:='update 訂單管理 set 訂單狀態=:Sstatu, 繳費狀態=:PayStatu where 訂單編號=:Sid';
          Frm000.SQLQuerySstatuScript.SQL.Text := sqlstr;
          Params.ParamByName('Sstatu').AsString := '未確認';
          Params.ParamByName('PayStatu').AsString := Sstatu.KeyValue;
          Params.ParamByName('Sid').AsString := Sid;

          Frm000.SQLQuerySstatuScript.Close;
          Frm000.SQLQuerySstatuScript.ExecSQL;
          //Close; 要往上移 不然會出現一個視窗顯示error
          Frm000.SQLTransactionSstatuScript.Commit;
          showmessage('已修改繳費狀態');
        except
          showmessage('資料修改時發生錯誤');
        end;

        end

      else
      begin
        Try
          sqlstr:='update 訂單管理 set 訂單狀態=:Sstatu, 繳費狀態=:PayStatu where 訂單編號=:Sid';
          Frm000.SQLQuerySstatuScript.SQL.Text := sqlstr;
          Params.ParamByName('Sstatu').AsString := '未出貨';
          Params.ParamByName('PayStatu').AsString := Sstatu.KeyValue;
          Params.ParamByName('Sid').AsString := Sid;

          Frm000.SQLQuerySstatuScript.Close;
          Frm000.SQLQuerySstatuScript.ExecSQL;
          //Close; 要往上移 不然會出現一個視窗顯示error
          Frm000.SQLTransactionSstatuScript.Commit;
          showmessage('已修改繳費狀態');
        except
          showmessage('資料修改時發生錯誤');
        end;

end;

end;
   Frm000.SQLQueryOrder.Refresh;
   Frm000.SQLQueryOrder.Locate('訂單編號',Sid,[loPartialKey]);

end;

procedure TFrmD01.DBGridOrderCellClick(Column: TColumn);
begin
  Sid := Frm000.SQLQueryOrder.fieldbyName('訂單編號').value;
  OrderSstatu := Frm000.SQLQueryOrder.fieldbyName('訂單狀態').value;
end;



end.

