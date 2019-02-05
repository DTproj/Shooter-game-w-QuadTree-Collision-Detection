unit BoidUnit;

interface
uses
  MyTypes, Vcl.Graphics, Winapi.Windows;

type
TBoid = class

  pozicija : TVector3f;
  radijus : integer;
  smjer : TVector3f;
  boja : TColor;
  hp : integer;

  constructor create;
  destructor destroy; override;

  procedure render(aCanvas : TCanvas);
  procedure move(aVector : TVector3f; aRect : TRect);
  function intersect (aBoid : TBoid) : boolean; virtual;

end;

implementation

{ TBoid }

constructor TBoid.create;
begin

  pozicija[0] := random(1000);
  pozicija[1] := random(800);
  pozicija[2] := 0;

  smjer[0] := random*10;
  smjer[1] := random*10;
  smjer[2] := 0;

  radijus := 10;

  hp := 10;

  boja := clBlue;

end;

destructor TBoid.destroy;
begin

  inherited;
end;

function TBoid.intersect(aBoid: TBoid): boolean;
var
  c, a, b : single;
begin

  result := false;

  a := abs( pozicija[0] - aBoid.pozicija[0]);
  b := abs( pozicija[1] - aBoid.pozicija[1]);

  c := sqrt(a*a + b*b);

  if c < (radijus + aBoid.radijus) then
  begin

    result := true;

  end;


end;

procedure TBoid.move(aVector: TVector3f; aRect : TRect);
var
  i : integer;
begin

   if (pozicija[0] >= aRect.Width) or (pozicija[0] <= 0) then
   begin
     smjer[0] := - smjer[0];
   end;

   if (pozicija[1] >= aRect.Height) or (pozicija[1] <= 0) then
   begin
     smjer[1] := - smjer[1];
   end;

   for i := 0 to 1 do
   begin
     pozicija[i] := pozicija[i] + smjer[i];
   end;

end;

procedure TBoid.render(aCanvas: TCanvas);
begin

  aCanvas.Brush.Color := boja;

  aCanvas.Ellipse(
    round(pozicija[0]-(radijus)),
    round(pozicija[1]-(radijus)),
    round(pozicija[0]+(radijus)),
    round(pozicija[1]+(radijus))
  );

end;

end.
