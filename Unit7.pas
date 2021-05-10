unit Unit7;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
    FMX.ANI, FMX.Objects, FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm7 = class(TForm)
    PlaceHolder: TLayout;
    PlaceHolderItem: TLayout;
    PlaceHolderHeader: TLayout;
    Circle1: TCircle;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    P1: TRectangle;
    P2: TRectangle;
    Layout1: TLayout;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Layout2: TLayout;
    Rectangle5: TRectangle;
    Rectangle6: TRectangle;
    Button1: TButton;
    TimerPlaceHolder: TTimer;
    Button2: TButton;
    Header: TLayout;
    Button3: TButton;
    Layout3: TRectangle;
    Image2: TImage;
    Layout4: TLayout;
    Layout5: TLayout;
    Circle2: TCircle;
    Text1: TText;
    Text2: TText;
    procedure FormCreate(Sender: TObject);
    procedure TimerPlaceHolderTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    FGradient : TGradient;
    FOffSet: Single;
    procedure SetOffSet(const Value: Single);
    Procedure Start;
    Procedure Stop;
  public
     Property OffSet : Single Read FOffSet Write SetOffSet;
  end;

var
  Form7: TForm7;

implementation

{$R *.fmx}

procedure TForm7.Button1Click(Sender: TObject);
begin
Header.Visible := True;
Start;
end;

procedure TForm7.Button2Click(Sender: TObject);
begin
Stop;
end;

procedure TForm7.Button3Click(Sender: TObject);
begin
Header.Visible := False;
end;

procedure TForm7.FormCreate(Sender: TObject);
begin
FGradient                     := TGradient.Create;
FGradient.Style               := TGradientStyle.Linear;
FGradient.StartPosition.Point := TPointF.Create(0, 0);
FGradient.StopPosition .Point := TPointF.Create(1, 1);
FGradient.Points.Add;
FGradient.Points[0].Color     := $FFdddddd;
FGradient.Points[1].Color     := $FFeeeeee;
FGradient.Points[2].Color     := $FFdddddd;
Offset := -1;
end;

procedure TForm7.SetOffSet(const Value: Single);

   Procedure ApplyGradient(aDest : TControl);
   Var
      I : Integer;
   Begin
   if aDest Is TShape then
      Begin
      (aDest As TShape).Fill.Kind := TBrushKind.Gradient;
      (aDest As TShape).Fill.Gradient.Assign(FGradient);
      End;
   for I := 0 to aDest.ControlsCount-1 do ApplyGradient(aDest.Controls[I]);
   End;

begin
FOffSet := Value;
FGradient.Points[0].Offset := FOffset+0;
FGradient.Points[1].Offset := FOffset+0.5;
FGradient.Points[2].Offset := FOffset+0.99999;
ApplyGradient(PlaceHolder);
end;

procedure TForm7.Start;

   Procedure StartGradient(aDest : TControl);
   Var
      I : Integer;
   Begin
   if aDest Is TShape then
      (aDest As TShape).Fill.Kind := TBrushKind.Gradient;
   for I := 0 to aDest.ControlsCount-1 do StartGradient(aDest.Controls[I]);
   End;

begin
StartGradient(PlaceHolder);
TimerPlaceHolder.Interval := 50;
TimerPlaceHolder.Enabled  := True;
end;

procedure TForm7.Stop;

   Procedure StopGradient(aDest : TControl);
   Var
      I : Integer;
   Begin
   if aDest Is TShape then
      (aDest As TShape).Fill.Kind := TBrushKind.Solid;
   for I := 0 to aDest.ControlsCount-1 do StopGradient(aDest.Controls[I]);
   End;

begin
TimerPlaceHolder.Enabled  := False;
StopGradient(PlaceHolder);
end;

procedure TForm7.TimerPlaceHolderTimer(Sender: TObject);
begin
TimerPlaceHolder.Enabled  := False;
TimerPlaceHolder.Interval := 1200;
OffSet := -1;
TAnimator.AnimateFloat(Self, 'OffSet', 1, 1);
TimerPlaceHolder.Enabled  := True;
end;

end.
