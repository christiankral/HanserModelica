within HanserModelica.Machines.Records;
record SingleLayer12over12 "Single layer winding example with skewing of 12/12"
  import Modelica.Constants.pi;
  extends Winding(
    final doubleLayer=false,
    final m=3,
    final p=2,
    final a=2,
    final Sprime=24,
    final ycb={ 1, 2, 3, 4},
    final yce={13,14,15,16},
    final nc=16,
    final offset=-127.5*pi/180);
end SingleLayer12over12;
