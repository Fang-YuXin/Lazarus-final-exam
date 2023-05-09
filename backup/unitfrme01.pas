unit unitfrme01;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, Forms, Controls, Graphics, Dialogs, DBGrids,
  StdCtrls, DBCtrls, Spin, ExtCtrls, EditBtn, LCLType;

type

  { TFrmE01 }

  TFrmE01 = class(TForm)
    btnNew: TButton;
    btnSave: TButton;
    btnDelete: TButton;
    btnPaid: TButton;
    btnPrint: TButton;
    gridProcurement: TDBGrid;
    dtPurchase: TDateEdit;
    GroupBox1: TGroupBox;
    lbCode: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    txtTotal: TLabeledEdit;
    txtUnitPrice: TLabeledEdit;
    txtProduct: TLabeledEdit;
    txtPublisher: TLabeledEdit;
    numQuantity: TSpinEdit;
    procedure btnDeleteClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnPaidClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure gridProcurementCellClick(Column: TColumn);
    procedure numQuantityChange(Sender: TObject);
    procedure txtUnitPriceChange(Sender: TObject);
  private
    var isSelected : boolean;

  public
    var cmd : string;

  end;

var
  FrmE01: TFrmE01;

implementation
uses unitFrm000;

{$R *.lfm}

{ TFrmE01 }

procedure TFrmE01.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  closeaction:= cafree;
    FrmE01:=nil;
end;

procedure TFrmE01.gridProcurementCellClick(Column: TColumn);
var status : string;
begin
   isSelected := false;
   btnPaid.Enabled := false;

  if gridProcurement.SelectedRows.Count = 1 then
  begin
    isSelected := true;
    lbCode.Caption := gridProcurement.Datasource.Dataset.FieldByName('採購編號').AsString;
    txtProduct.Text := gridProcurement.Datasource.Dataset.FieldByName('商品名稱').AsString;
    txtPublisher.Text := gridProcurement.Datasource.Dataset.FieldByName('出版商').AsString;
    numQuantity.Value := gridProcurement.Datasource.Dataset.FieldByName('數量').AsInteger;
    txtUnitPrice.Text := gridProcurement.Datasource.Dataset.FieldByName('單價').AsString;
    txtTotal.Text := gridProcurement.Datasource.Dataset.FieldByName('總價').AsString;
    dtPurchase.Date := gridProcurement.Datasource.Dataset.FieldByName('採購日期').AsDateTime;

    status := gridProcurement.Datasource.Dataset.FieldByName('應付帳款狀態').AsString;

    if(cmd = 'E02') then
    begin
       if(status = '未付款') then btnPaid.Enabled := true;
    end;

    if(cmd = 'E01') then
    begin
       if(status = '未付款') then btnDelete.Enabled := true;
    end;

  end;
end;

procedure TFrmE01.numQuantityChange(Sender: TObject);
var unitPrice : integer;
    total : integer;
begin
  unitPrice := strToInt(txtUnitPrice.Text);
  total := numQuantity.Value * unitPrice;
  txtTotal.Text := IntToStr(total);

end;

procedure TFrmE01.txtUnitPriceChange(Sender: TObject);
var unitPrice : integer;
    total : integer;
begin
  unitPrice := strToInt(txtUnitPrice.Text);
  total := numQuantity.Value * unitPrice;
  txtTotal.Text := IntToStr(total);
end;



procedure TFrmE01.btnNewClick(Sender: TObject);
begin
  isSelected := false;
  lbCode.Caption := '將被分配';
  txtProduct.Text := '';
  numQuantity.Value := 1;
  txtUnitPrice.Text := '0';
  txtTotal.Text := '0';
  txtPublisher.Text := '';
end;

procedure TFrmE01.btnDeleteClick(Sender: TObject);
begin
  if isSelected = false then
  begin
    Application.MessageBox(PChar('請選擇記錄'), '錯誤');
    exit;
  end;

  if Application.MessageBox('是否要刪除此記錄？', '確認', MB_YESNO) = IDYES  then
  begin

    Frm000.sqlProcurement.Close;
    Frm000.sqlProcurement.SQL.Text := 'delete 採購商品資料 where 採購編號=:code;';
    Frm000.sqlProcurement.Params.ParamByName('code').AsString := lbCode.Caption;

    Frm000.sqlProcurement.ExecSQL;
    Frm000.sqlProcurement.SQLTransaction.Commit;

    gridProcurement.DataSource.DataSet.Active := False;
    Frm000.sqlProcurement.SQL.Text := 'select * from 採購商品資料';
    Frm000.sqlProcurement.Open;
    gridProcurement.DataSource.DataSet.Active := True;

     Application.MessageBox(PChar('刪除成功'), '信息');
  end;

end;

procedure TFrmE01.btnPaidClick(Sender: TObject);
var status : string;
begin
  if isSelected = false then
  begin
    Application.MessageBox(PChar('請選擇記錄'), '錯誤');
    exit;
  end;

  if Application.MessageBox('您要將此訂單的狀態更新為已付款嗎?', '確認', MB_YESNO) = IDYES  then
  begin
    status := '已付款'; // Paid
    Frm000.sqlProcurement.Close;
    Frm000.sqlProcurement.SQL.Text := 'update 採購商品資料 set 應付帳款狀態=:status where 採購編號=:code;';
    Frm000.sqlProcurement.Params.ParamByName('code').AsString := lbCode.Caption;
    Frm000.sqlProcurement.Params.ParamByName('status').AsString := status;

    Frm000.sqlProcurement.ExecSQL;
    Frm000.sqlProcurement.SQLTransaction.Commit;

    gridProcurement.DataSource.DataSet.Active := False;
    Frm000.sqlProcurement.SQL.Text := 'select * from 採購商品資料';
    Frm000.sqlProcurement.Open;
    gridProcurement.DataSource.DataSet.Active := True;

     Application.MessageBox(PChar('更新成功'), '信息');
  end;

end;

procedure TFrmE01.btnPrintClick(Sender: TObject);
var f: Text;
begin
  if isSelected = false then
  begin
    Application.MessageBox(PChar('請選擇記錄'), '錯誤');
    exit;
  end;

  system.Assign(f,'C:\Users\user\Desktop\系統分析網路書城\Final\Bookstore\Order.html'); // use AssignFile if you have SysUtils in your uses clause
  {$I-} // without this, if rewrite fails then a runtime error will be generated
  Rewrite(f);
  {$I+}
  if IOResult =0 then begin // OK, we can write the file
    system.WriteLn(f, '<table> <tr> <td> <img style="max-width: 50px" src="https://cdn-icons-png.flaticon.com/512/2232/2232688.png"/></td> <td><b>白沙網路書城系統</b><br/> <b>採購訂單</b><br/></td> <td> </tr></table><br/>');
    system.WriteLn(f, '<div style="font-family: Arial; font-size: 13px;">');

    system.WriteLn(f, '<b>採購内容</b><br/>');
    system.WriteLn(f, '<ul>');
    system.WriteLn(f, '<li>採購編號: ' + lbCode.Caption + '</li>');
    system.WriteLn(f, '<li>應付帳款狀態: ' + gridProcurement.Datasource.Dataset.FieldByName('應付帳款狀態').AsString + '</li>');

    system.WriteLn(f, '</ul>');
    system.WriteLn(f, '<table style="font-family: Arial; font-size: 12px; width: 555px; border: solid 1px black;border-collapse: collapse;">');
    system.WriteLn(f, '<thead><tr><th style="border: solid 1px black;">數字</th><th style="border: solid 1px black;">商品名稱</th><th style="border: solid 1px black;">單價</th><th style="border: solid 1px black;">數量</th><th style="border: solid 1px black;">總價</th></tr></thead>');
    system.WriteLn(f, '<tbody>');
    system.WriteLn(f, '<tr>');
    system.WriteLn(f, '<td style="border: solid 1px black; text-align: center">1</td>');
    system.WriteLn(f, '<td style="border: solid 1px black;">' + gridProcurement.Datasource.Dataset.FieldByName('商品名稱').AsString +'</td>');
    system.WriteLn(f, '<td style="border: solid 1px black;">' + gridProcurement.Datasource.Dataset.FieldByName('單價').AsString +'</td>');
    system.WriteLn(f, '<td style="border: solid 1px black;">' + gridProcurement.Datasource.Dataset.FieldByName('數量').AsString +'</td>');
    system.WriteLn(f, '<td style="border: solid 1px black;">' + gridProcurement.Datasource.Dataset.FieldByName('總價').AsString +'</td>');
    system.WriteLn(f, '</tr>');

  end else begin

  end;

  system.Close(f);

  executeprocess('C:\Program Files\Google\Chrome\Application\chrome.exe',['C:\Users\user\Desktop\系統分析網路書城\Final\Bookstore\Order.html', '--print']);


end;

procedure TFrmE01.btnSaveClick(Sender: TObject);
var code : string;
    sqlCommand : string;
    index : integer;
begin

  if isSelected = true then
  begin
    Frm000.sqlProcurement.SQL.Text := 'update 採購商品資料 set 商品名稱=:product, 採購日期=:date, 出版商=:publisher, 數量=:qty, 單價=:unitprice, 總價=:total where 採購編號=:code';
    Frm000.sqlProcurement.Params.ParamByName('code').AsString := lbCode.Caption;
    Frm000.sqlProcurement.Params.ParamByName('product').AsString := txtProduct.Text;
    Frm000.sqlProcurement.Params.ParamByName('publisher').AsString := txtPublisher.Text;
    Frm000.sqlProcurement.Params.ParamByName('qty').AsString := numQuantity.Text;
    Frm000.sqlProcurement.Params.ParamByName('unitprice').AsString := txtUnitPrice.Text;

    Frm000.sqlProcurement.Params.ParamByName('total').AsString := txtTotal.Text;
    Frm000.sqlProcurement.Params.ParamByName('date').AsString := FormatDateTime('YYYY-MM-DD', dtPurchase.Date);

    Frm000.sqlProcurement.Close;
    Frm000.sqlProcurement.ExecSQL;
    Frm000.sqlProcurement.SQLTransaction.Commit;

    gridProcurement.DataSource.DataSet.Active := False;
    Frm000.sqlProcurement.SQL.Text := 'select * from 採購商品資料';
    Frm000.sqlProcurement.Open;
    gridProcurement.DataSource.DataSet.Active := True;

    Application.MessageBox(PChar('更新成功'), '信息');

  end
  else
  begin
    sqlCommand := 'select 採購編號 from 採購商品資料';
    Frm000.sqlProcurement.SQL.Text := sqlCommand;

    Frm000.sqlProcurement.Open;
    Frm000.sqlProcurement.Last;

    code := Frm000.sqlProcurement.FieldByName('採購編號').AsString;

    if code.length <= 0 then
    begin
      code := 'B00001';
    end
    else
    begin
     code := copy(code, 2, 5);
     index := strtoint(code) + 1;
     code := inttostr(index);

    while(code.length < 5) do code := '0' + code;

    code := 'B' + code;

    lbCode.Caption := code;

    Frm000.sqlProcurement.SQL.Text := 'insert into 採購商品資料 values(:code, :product, :date, :publisher, :qty, :unitprice, :status, :total)';
    Frm000.sqlProcurement.Params.ParamByName('code').AsString := code;
    Frm000.sqlProcurement.Params.ParamByName('product').AsString := txtProduct.Text;
    Frm000.sqlProcurement.Params.ParamByName('publisher').AsString := txtPublisher.Text;
    Frm000.sqlProcurement.Params.ParamByName('qty').AsString := numQuantity.Text;
    Frm000.sqlProcurement.Params.ParamByName('unitprice').AsString := txtUnitPrice.Text;
    Frm000.sqlProcurement.Params.ParamByName('status').AsString := '未付款';
    Frm000.sqlProcurement.Params.ParamByName('total').AsString := txtTotal.Text;
    Frm000.sqlProcurement.Params.ParamByName('date').AsString := FormatDateTime('YYYY-MM-DD', dtPurchase.Date);

    Frm000.sqlProcurement.Close;
    Frm000.sqlProcurement.ExecSQL;
    Frm000.sqlProcurement.SQLTransaction.Commit;

    gridProcurement.DataSource.DataSet.Active := False;
    Frm000.sqlProcurement.SQL.Text := 'select * from 採購商品資料';
    Frm000.sqlProcurement.Open;
    gridProcurement.DataSource.DataSet.Active := True;

    Application.MessageBox(PChar('插入成功'), '信息');

    end;

  end;

end;

procedure TFrmE01.FormActivate(Sender: TObject);
begin
  if cmd = 'E01' then
   begin
     FrmE01.Text := '商品採購(E01)';
     btnNew.Enabled := true;
     btnSave.Enabled := true;
     btnDelete.Enabled := true;

     btnPaid.Enabled := False;
     btnPrint.Enabled := False;
   end
   else
   begin
   FrmE01.Text := '應付帳款管理(E02)';
    btnNew.Enabled := False;
    btnSave.Enabled := False;
    btnDelete.Enabled := False;

    btnPaid.Enabled := True;
    btnPrint.Enabled := True;
   end;

    gridProcurement.DataSource.DataSet.Active := False;
    Frm000.sqlProcurement.SQL.Text := 'select * from 採購商品資料';
    Frm000.sqlProcurement.Open;
    gridProcurement.DataSource.DataSet.Active := True;

end;

end.

