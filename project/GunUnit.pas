unit GunUnit;

interface

uses
  MyTypes, MetakUnit;

type

TGun = class

  pozicija : TVector3f;
  smjer : TVector3f;
  ammo, maxAmmo : integer;
  cd, maxCd : integer;

  constructor create(aPos : TVector3f; aDir : TVector3f);
  destructor destroy; override;
  function fire : TMetak; virtual;
  procedure reduceAmmo;
  function crMetak : TMetak; virtual;

end;

TGun2 = class (TGun)

  constructor create(aPos : TVector3f; aDir : TVector3f);
  destructor destroy; override;
  function fire : TMetak; override;
  function crMetak : TMetak; override;

end;

TGrenade = class (TGun)

  constructor create(aPos : TVector3f; aDir : TVector3f);
  destructor destroy; override;
  function fire : TMetak; override;
  function crMetak : TMetak; override;

end;

TMine = class (TGun)

  constructor create(aPos : TVector3f; aDir : TVector3f);
  destructor destroy; override;
  function fire: TMetak; override;
  function crMetak : TMetak; override;

end;

implementation

{ TGun }

constructor TGun.create(aPos : TVector3f; aDir : TVector3f);
begin

  inherited create;

  pozicija := aPos;
  smjer := aDir;
  ammo := 20;
  maxAmmo := ammo;
  maxCd := 0;
  cd := 0;

end;

function TGun.crMetak: TMetak;
begin

  result := TMetak.create;

end;

destructor TGun.destroy;
begin

  inherited;
end;

function TGun.fire: TMetak;
begin

  result := crMetak;

  result.pozicija := pozicija;
  result.smjer := smjer;

  reduceAmmo;

end;

procedure TGun.reduceAmmo;
begin

  dec(ammo);

end;



{ TGun2 }

constructor TGun2.create(aPos : TVector3f; aDir : TVector3f);
begin

  inherited;

  ammo := 10;
  maxAmmo := ammo;
  maxCd := 40;
  cd := 0;
end;

function TGun2.crMetak: TMetak;
begin

  result := TMetak2.create;

end;

destructor TGun2.destroy;
begin

  inherited;
end;

function TGun2.fire: TMetak;
begin

  result := inherited;
  result.pozicija := pozicija;
  result.smjer := smjer;
  cd := maxCd;

end;



{ TGrenade }

constructor TGrenade.create(aPos, aDir: TVector3f);
begin

  inherited;

  ammo := 3;
  maxAmmo := ammo;
  maxCd := 100;
  cd := 0;

end;

function TGrenade.crMetak: TMetak;
begin

  result := TMetak3.create;

end;

destructor TGrenade.destroy;
begin

  inherited;
end;

function TGrenade.fire: TMetak;
begin

  result := inherited;
  result.pozicija := pozicija;
  result.smjer := smjer;
  cd := maxCd;

end;



{ TMine }

constructor TMine.create(aPos, aDir: TVector3f);
begin

  inherited;

  ammo := 2;
  maxAmmo := ammo;
  maxCd := 300;
  cd := 0;

end;

function TMine.crMetak: TMetak;
begin

  result := TMetak4.create;

end;

destructor TMine.destroy;
begin

  inherited;
end;

function TMine.fire: TMetak;
begin

  result := inherited;
  result.pozicija := pozicija;
  cd := maxCd;

end;

end.
