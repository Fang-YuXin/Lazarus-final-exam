unit unitDashboard;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus;

type

  { TFormDashboard }

  TFormDashboard = class(TForm)
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
    MenuItem1: TMenuItem;
    D01: TMenuItem;
    D02: TMenuItem;
    E0: TMenuItem;
    E01: TMenuItem;
    E02: TMenuItem;
    F0: TMenuItem;
    F1: TMenuItem;
    F2: TMenuItem;
    procedure A02Click(Sender: TObject);
  private

  public

  end;

var
  FormDashboard: TFormDashboard;

implementation

{$R *.lfm}

{ TFormDashboard }

procedure TFormDashboard.A02Click(Sender: TObject);
begin
  close;
end;

end.

