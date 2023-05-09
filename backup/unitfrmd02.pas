unit unitfrmd02;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, MSSQLConn, Forms, Controls, Graphics, Dialogs,
  StdCtrls, DBGrids;
type

  { TFrmD02 }

  TFrmD02 = class(TForm)
    ButAppend: TButton;
    ButDelete: TButton;
    ButUpdate: TButton;
    DBGrid1: TDBGrid;
    EditCName: TEdit;
    EditPName: TEdit;
    EditPID: TEdit;
    EditNum: TEdit;
    EditPrice: TEdit;
    EditTotalPrice: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure ButAppendClick(Sender: TObject);
    procedure ButDeleteClick(Sender: TObject);
    procedure ButUpdateClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  FrmD02: TFrmD02;

implementation
 uses unitFrm000;
{$R *.lfm}

{ TFrmD02 }

procedure TFrmD02.ButAppendClick(Sender: TObject);
begin
   if EditCName.Text<>NULL then
        with Frm000.SQLQueryD022 do
          begin
          if not Frm000.SQLQueryD02.Locate('顧客名稱',EditCName.Text,[loPartialkey]) then
          begin
          Append;
          fieldbyName('顧客名稱').asstring:=EditCName.text;
          fieldbyName('商品名稱').asstring:=EditPName.text;
          fieldbyName('商品編號').asstring:=EditPID.text;
          fieldbyName('數量').asstring:=EditNum.text;
          fieldbyName('售價').asstring:=EditPrice.text;
          fieldbyName('總金額').asstring:=EditTotalPrice.text;
          post;
          applyupdates;
          //必須加入此行

          Frm000.SQLTransactionD022.CommitRetaining;
          Frm000.SQLQueryD02.refresh;
          showmessage('資料已經正確新增');
            end
          else
              showmessage('資料新增時敬生錯誤');
          end
        else
          showmessage('項目不得為空白');
        Frm000.SQLQueryD02.Locate('顧客名稱',EditCName.Text,[loPartialkey]);

end;

procedure TFrmD02.ButDeleteClick(Sender: TObject);
var sqlstr:string;
begin
    if(length(EditCName.Text)>0)and Frm000.SQLQueryD02.Locate('顧客名稱',EditCName.Text,[loPartialkey])then
       if messageDlg('確定要刪除此記錄？',mtConfirmation,[mbYes,mbNo],0)=mrYes then
       begin
       with Frm000.SQLQueryD022 do
         begin
         Try
           sqlstr:='delete from 退貨記錄 where 顧客名稱 ='''+EditCName.Text+'''';
           Frm000.SQLQueryD022.SQL.Text :=sqlstr;
           Frm000.SQLQueryD022.Close;
           Frm000.SQLQueryD022.ExecSQL;
//必須加入此行，用於完成交易
           Frm000.SQLTransactionD022.Commit;
           showmessage('資料已經刪除');
         except
           showmessage('資料刪除時發生錯誤');
         end;//Try
        end;//with SQLQueryDelete do
        Frm000.SQLQueryD02.refresh;
        end//if messageDlg('確定要刪除此記錄？'.mtConfirmation. [mbYes.mbNo].0=mrYes then


end;

procedure TFrmD02.ButUpdateClick(Sender: TObject);
var sqlstr:string;
begin
   if(length(EditCName.Text)>0)and Frm000.SQLQueryD02.Locate('顧客名稱',EditCName.Text,[loPartialkey])then
       if messageDlg('確定要修改此記錄？',mtConfirmation,[mbYes,mbNo],0)=mrYes then
       begin
       with Frm000.SQLQueryD022 do
         begin
         Try
           sqlstr:='update 退貨記錄 set 商品名稱=:PName,商品編號=:PID,數量=:Num,售價=:Price,總金額=:TotalPrice where 顧客名稱=:CName';
           Frm000.SQLQueryD022.SQL.Text :=sqlstr;
           Params.ParamByName('PName').AsString :=EditPName.Text;
           Params.ParamByName('PID').AsString :=EditPID.Text;
           Params.ParamByName('Num').AsString :=EditNum.Text;
           Params.ParamByName('Price').AsString :=EditPrice.Text;
           Params.ParamByName('TotalPrice').AsString :=EditTotalPrice.Text;
           Params.ParamByName('CName').AsString :=EditCName.Text;
           Frm000.SQLQueryD022.Close;
           Frm000.SQLQueryD022.ExecSQL;
           //必須加入此行，用於完成交易
           Frm000.SQLTransactionD022.Commit;
           showmessage('資料已經修改');
         except
           showmessage('資料修改時發生錯誤');
         end;//Try
        end;//with SQLQueryDelete do
        Frm000.SQLQueryD02.refresh;
        Frm000.SQLQueryD02.Locate('顧客名稱', EditCName.Text, [loPartialKey])
        end//if messageDlg('確定要修改商品資料？'.mtConfirmation. [mbYes.mbNo].0=mrYes then


end;

procedure TFrmD02.DBGrid1CellClick(Column: TColumn);
begin
   EditCName.Text:=Frm000.SQLQueryD02.fieldbyName('顧客名稱').value;

   if Frm000.SQLQueryD02.fieldbyName('商品名稱').IsNull then
   EditPName.Text:=''
   else
   EditPName.Text:= Frm000.SQLQueryD02.fieldbyName('商品名稱').value;

   if Frm000.SQLQueryD02.fieldbyName('商品編號').IsNull then
   EditPID.Text:=''
   else
   EditPID.Text:= Frm000.SQLQueryD02.fieldbyName('商品編號').value;

   if Frm000.SQLQueryD02.fieldbyName('數量').IsNull then
   EditNum.Text:=''
   else
   EditNum.Text:= Frm000.SQLQueryD02.fieldbyName('數量').value;

   if Frm000.SQLQueryD02.fieldbyName('售價').IsNull then
   EditPrice.Text:=''
   else
   EditPrice.Text:= Frm000.SQLQueryD02.fieldbyName('售價').value;

   if Frm000.SQLQueryD02.fieldbyName('總金額').IsNull then
   EditTotalPrice.Text:=''
   else
   EditTotalPrice.Text:= Frm000.SQLQueryD02.fieldbyName('總金額').value;



end;

procedure TFrmD02.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
    CloseAction :=caFree;
    FrmD02:=nil;
end;

end.

