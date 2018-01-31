within HanserModelica.SynchronousMachines;
model SMEE_LoadImpedance4 "Electrical excited synchronous machine operating at variable load impedance with angle 60° ind."
  import Modelica.Constants.pi;
  extends SMEE_LoadImpedance1(phi=30*pi/180);
end SMEE_LoadImpedance4;
