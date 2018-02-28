within HanserModelica.Machines.Functions;
function complexTurns "Calculation of complex number of turns of winding records"
  extends Modelica.Icons.Function;
  import Modelica.Constants.pi;
  input HanserModelica.Machines.Records.Winding winding "Input winding record";
  input Integer nc = 1 "Number of turns of one coil";
  input Modelica.SIunits.Angle offset = 0 "Angle offset";
  output Complex N[winding.m] "Complex numbers of turn";
protected
  Integer nCoil = size(winding.S,2) "Number of coils";
  Integer slots = size(winding.ycb,1) "Number of slots derived from ycb";
  Integer index "Local index of coil";
  Modelica.SIunits.Angle dgamma "Local coil width";
  Modelica.SIunits.Angle gamma "Orientation of local coil";
  Real xic "Local skewing factor of coil";
algorithm
  for k in 1:winding.m loop
    N[k] := Complex(0, 0) "Initialization of number of turns";
    for j in 1:nCoil loop
      index := winding.S[k, j] "Local index taken from matrix S";
      dgamma := 2*pi*(winding.yce[index] - winding.ycb[index])/slots;
      gamma := 2*pi*(winding.yce[index] + winding.ycb[index])/2/slots + offset;
      xic := sin(dgamma/2);
      // N[k] := N[i] + xic*nc*exp(j*gamma)
      N[k] := N[k] + xic*nc*Modelica.ComplexMath.fromPolar(1,gamma);
    end for;
  end for;
end complexTurns;
