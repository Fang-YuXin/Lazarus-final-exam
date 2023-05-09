program BookstoreERP;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, lazcontrols, unitfrm000, unitfrmf01, unitfrmf02,
  unitfrmc01, unitFRMC02, unitfrmd02, unitfrma01, unitfrma02, unitfrmb01,
  unitfrmb02, unitfrmd01, unitfrme01, unit1;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFrm000, Frm000);
  Application.CreateForm(TFrmF01, FrmF01);
  Application.CreateForm(TFrmF02, FrmF02);
  Application.CreateForm(TFrmC01, FrmC01);
  Application.CreateForm(TFrmC02, FrmC02);
  Application.CreateForm(TFrmD02, FrmD02);
  Application.CreateForm(TFrmA01, FrmA01);
  Application.CreateForm(TFrmA02, FrmA02);
  Application.CreateForm(TFrmB01, FrmB01);
  Application.CreateForm(TFrmB02, FrmB02);
  Application.CreateForm(TFrmD01, FrmD01);
  Application.CreateForm(TFrmE01, FrmE01);
  Application.Run;
end.

