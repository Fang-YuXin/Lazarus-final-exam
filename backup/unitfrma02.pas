unit unitfrma02;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs;

type

  { TFrmA02 }

  TFrmA02 = class(TForm)
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FrmA02: TFrmA02;

implementation

{$R *.lfm}

{ TFrmA02 }

procedure TFrmA02.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
    closeaction:= cafree;
    FrmA02:=nil;
end;


end.

