within HanserModelica.SynchronousMachines;
model SMEE_LoadImpedance2 "Electrical excited synchronous machine operating at variable load impedance with angle 30° cap."
  import Modelica.Constants.pi;
  extends SMEE_LoadImpedance1(phi=-30*pi/180);
end SMEE_LoadImpedance2;
