program Project2;

uses
  Vcl.Forms,
  Unit2 in 'Unit2.pas' {Form2},
  QuadTreeUnit in 'QuadTreeUnit.pas',
  BoidUnit in 'BoidUnit.pas',
  MyTypes in 'MyTypes.pas',
  PlayerUnit in 'PlayerUnit.pas',
  MetakUnit in 'MetakUnit.pas',
  GunUnit in 'GunUnit.pas',
  GameUnit in 'GameUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
