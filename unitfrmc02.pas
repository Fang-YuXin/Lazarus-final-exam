unit unitFRMC02;

{$mode ObjFPC}{$H+}

interface

uses
   Classes, SysUtils, DB, SQLDB, MSSQLConn, Forms, Controls, Graphics, Dialogs,
  DBGrids, StdCtrls;

type

  { TFrmC02 }

  TFrmC02 = class(TForm)
    ButAppend: TButton;
    ButDelete: TButton;
    ButUpdate: TButton;
    DBGrid1: TDBGrid;
    EditPID: TEdit;
    EditPName: TEdit;
    EditInventory: TEdit;
    EditSalePrice: TEdit;
    EditPublisher: TEdit;
    EditAuthor: TEdit;
    EditPWord1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    EditPWord: TMemo;
    procedure ButAppendClick(Sender: TObject);
    procedure ButDeleteClick(Sender: TObject);
    procedure ButUpdateClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);

  private

  public

  end;

var
  FrmC02: TFrmC02;

implementation
  uses unitFrm000;
{$R *.lfm}

{ TFrmC02 }

procedure TFrmC02.ButDeleteClick(Sender: TObject);
  var sqlstr:string;
begin
    if(length(EditPID.Text)>0)and Frm000.SQLQueryC01.Locate('商品編號',EditPID.Text,[loPartialkey])then
       if messageDlg('確定要刪除商品資料？',mtConfirmation,[mbYes,mbNo],0)=mrYes then
       begin
       with Frm000.SQLQueryProduct do
         begin
         Try
           sqlstr:='delete from 商品資料 where 商品編號 ='''+EditPID.Text+'''';
           SQL.Text :=sqlstr;
           Close;
           ExecSQL;
//必須加入此行，用於完成交易
           Frm000.SQLTransactionProduct.Commit;
           showmessage('資料已經刪除');
         except
           showmessage('資料刪除時發生錯誤');
         end;//Try
        end;//with SQLQueryDelete do
        Frm000.SQLQueryC01.refresh;
        end//if messageDlg('確定要刪除商品資料？'.mtConfirmation. [mbYes.mbNo].0=mrYes then
end;




procedure TFrmC02.ButAppendClick(Sender: TObject);
begin
    if EditPID.Text<>NULL then
           with Frm000.SQLQueryProduct do
             begin
             if not Frm000.SQLQueryC01.Locate('商品編號',EditPID.Text,[loPartialkey]) then
             //if not Locate('商品編號',EditPID.Text,[loPartialkey]) then
             begin
             Append;
             fieldbyName('商品編號').asstring:=EditPID.text;
             fieldbyName('商品名稱').asstring:=EditPName.text;
             fieldbyName('商品敘述').asstring:=EditPWord1.text;
             fieldbyName('作者名稱').asstring:=EditAuthor.text;
             fieldbyName('庫存').asstring:=EditInventory.text;
             fieldbyName('售價').asstring:=EditSalePrice.text;
             fieldbyName('出版商').asstring:=EditPublisher.text;
             post;
             applyupdates;
             //必須加入此行

             Frm000.SQLTransactionProduct.CommitRetaining;
             Frm000.SQLQueryC01.refresh;
             showmessage('資料已經正確新增');

             end
             else
                 showmessage('資料新增時敬生錯誤,原因:商品編號重複');
             end
           else
             showmessage('項目不得為空白');
           Frm000.SQLQueryC01.Locate('商品編號',EditPID.Text,[loPartialkey]);



end;


procedure TFrmC02.ButUpdateClick(Sender: TObject);
var sqlstr:string;
begin
   if(length(EditPID.Text)>0)and Frm000.SQLQueryC01.Locate('商品編號', EditPID.Text,[loPartialkey])then
       if messageDlg('確定要修改商品資料？',mtConfirmation,[mbYes,mbNo],0)=mrYes then
       begin
       with Frm000.SQLQueryProduct do
         begin
         Try
           sqlstr:='update 商品資料 set 商品名稱=:PName,商品敘述=:PWord,作者名稱=:Author,庫存=:Inventory,售價=:SalePrice,出版商=:Publisher where 商品編號=:PID';
           SQL.Text :=sqlstr;
           Params.ParamByName('PName').AsString :=EditPName.Text;
           Params.ParamByName('PWord').AsString :=EditPWord1.Text;
           Params.ParamByName('Author').AsString :=EditAuthor.Text;
           Params.ParamByName('Inventory').AsString :=EditInventory.Text;
           Params.ParamByName('SalePrice').AsString :=EditSalePrice.Text;
           Params.ParamByName('Publisher').AsString :=EditPublisher.Text;
           Params.ParamByName('PID').AsString :=EditPID.Text;
           Close;
           ExecSQL;
           //必須加入此行，用於完成交易
           Frm000.SQLTransactionProduct.Commit;
           showmessage('資料已經修改');
         except
           showmessage('資料修改時發生錯誤');
         end;//Try
        end;//with SQLQueryDelete do
        Frm000.SQLQueryC01.refresh;
        Frm000.SQLQueryC01.Locate('商品編號', EditPID.Text, [loPartialKey])
        end//if messageDlg('確定要修改商品資料？'.mtConfirmation. [mbYes.mbNo].0=mrYes then

end;

procedure TFrmC02.DBGrid1CellClick(Column: TColumn);
begin
   EditPID.Text:=Frm000.SQLQueryC01.fieldbyName('商品編號').value;

   if Frm000.SQLQueryC01.fieldbyName('商品名稱').IsNull then
   EditPName.Text:=''
   else
   EditPName.Text:= Frm000.SQLQueryC01.fieldbyName('商品名稱').value;

   if Frm000.SQLQueryC01.fieldbyName('商品敘述').IsNull then
   EditPWord.Text:=''
   else
   EditPWord.Text:= Frm000.SQLQueryC01.fieldbyName('商品敘述').value;

   if Frm000.SQLQueryC01.fieldbyName('作者名稱').IsNull then
   EditAuthor.Text:=''
   else
   EditAuthor.Text:= Frm000.SQLQueryC01.fieldbyName('作者名稱').value;

   if Frm000.SQLQueryC01.fieldbyName('庫存').IsNull then
   EditInventory.Text:=''
   else
   EditInventory.Text:= Frm000.SQLQueryC01.fieldbyName('庫存').value;

   if Frm000.SQLQueryC01.fieldbyName('售價').IsNull then
   EditSalePrice.Text:=''
   else
   EditSalePrice.Text:= Frm000.SQLQueryC01.fieldbyName('售價').value;

   if Frm000.SQLQueryC01.fieldbyName('出版商').IsNull then
   EditPublisher.Text:=''
   else
   EditPublisher.Text:= Frm000.SQLQueryC01.fieldbyName('出版商').value;

end;




procedure TFrmC02.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   CloseAction :=caFree;
   FrmC02:=nil;
end;

procedure TFrmC02.FormCreate(Sender: TObject);
begin
  //EditPWord1.WordWrap:= true;
end;


end.

