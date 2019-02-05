unit QuadTreeUnit;

interface

uses
Winapi.Windows,  System.Classes, Vcl.Graphics, Math, BoidUnit;

type
TQuadTree = class

  rub : TRect;
  kapc : integer;
  pts : TList;
  divided : Boolean;

  topL, botL, topR, botR : TQuadTree;

  constructor create(aRect : TRect);
  destructor destroy; override;

  procedure insert(aBoid : TBoid);
  procedure subdiv;
  procedure render (aCanvas : TCanvas);
  procedure query(range : TRect; found : TList);

end;

implementation

{ TQuadTree }

constructor TQuadTree.create(aRect : TRect);
begin

  kapc := 4;

  pts := TList.Create;

  rub := aRect;

end;

destructor TQuadTree.destroy;
begin

  if divided then
  begin
    topL.Destroy;
    topR.Destroy;
    botL.Destroy;
    botR.Destroy;
  end;

  inherited;
end;

procedure TQuadTree.insert(aBoid : TBoid);
var
 point : TPoint;
begin

  point.X := round(aBoid.pozicija[0]);
  point.Y := round(aBoid.pozicija[1]);

  if not ptInRect(rub, point) then
  begin

    exit;

  end;

  if (pts.Count < kapc) then
  begin
      pts.Add(aBoid);
  end
  else
  begin

    if  not divided then
    begin
      subdiv;
      divided := true;
    end;

    if divided then
    begin

      topL.insert(aBoid);
      topR.insert(aBoid);
      botL.insert(aBoid);
      botR.insert(aBoid);

    end;

  end;


end;

procedure TQuadTree.query(range : TRect; found : TList);
var
  i : integer;
  point : TPoint;
begin

  if  not rub.IntersectsWith(range) then
  begin
    exit;
  end

  else
  begin

    for i := 0 to pts.Count-1 do
    begin

       point.X := round(TBoid (pts[i]).pozicija[0]);
       point.Y := round(TBoid (pts[i]).pozicija[1]);

      if ptInRect(range, point) then
      begin

        found.Add(TBoid (pts[i]));

      end;


    end;

    if divided then
    begin

      topL.query(range, found);
      topR.query(range, found);
      botL.query(range, found);
      botR.query(range, found);

    end;

  end;

end;

procedure TQuadTree.render(aCanvas: TCanvas);
begin

   aCanvas.Rectangle(rub);

   if divided then
   begin
     topL.render(aCanvas);
     topR.render(aCanvas);
     botL.render(aCanvas);
     botR.render(aCanvas);
   end;

end;

procedure TQuadTree.subdiv;
var
  tLRect, bLRect, tRRect, bRRect : TRect;
begin

    tLRect := bounds(
        round(rub.Left),
        round(rub.Top),
        round(rub.Width/2),
        round(rub.Height/2)
    );

    bLRect := bounds(
        round(rub.Left),
        round(rub.Top + rub.Height/2),
        round(rub.Width/2),
        round(rub.Height/2)
    );

    tRRect := bounds(
        round(rub.Left + rub.Width/2),
        round(rub.Top),
        round(rub.Width/2),
        round(rub.Height/2)
    );

    bRRect := bounds(
        round(rub.Left + rub.Width/2),
        round(rub.Top + rub.Height/2),
        round(rub.Width/2),
        round(rub.Height/2)
    );

    topL := TQuadTree.create(tLRect);
    botL := TQuadTree.create(bLRect);
    topR := TQuadTree.create(tRRect);
    botR := TQuadTree.create(bRRect);

end;

end.
