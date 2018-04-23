within HanserModelica.Machines.Records;
record DoubleLayer10over12 "Winding example with skewing of 10/12"
  import Modelica.Constants.pi;
  extends Winding(
    final doubleLayer=true,
    final m=3,
    final p=2,
    final a=4,
    final Sprime=24,
    final ycb={ 1, 2, 3, 4},
    final yce={11,12,13,14},
    final nc=16,
    final offset=-112.5*pi/180);
end DoubleLayer10over12;
