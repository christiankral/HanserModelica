within HanserModelica.Machines.Functions;
function complexTurns "Calculation of complex number of turns of winding records"
  extends Modelica.Icons.Function;
  import Modelica.Constants.pi;
  input HanserModelica.Machines.Records.Winding winding "Input winding record";
  output Complex N[winding.m] "Complex numbers of turn";
protected
  Integer ycb[winding.m,size(winding.ycb,1)] "Coil begin index";
  Integer yce[winding.m,size(winding.yce,1)] "Coil end index";
  Integer index "Local index";
  Integer Sg = if winding.doubleLayer then div(winding.Sprime,2) else winding.Sprime "Number of slots per coil group";
  Integer yShift = div(winding.Sprime, winding.m) "Slot displacement between two adjacent windings";
  Integer coilSideCounter[Sg]=zeros(Sg) "Coil side counter to validate winding";
  Modelica.SIunits.Angle dgamma "Local coil width";
  Modelica.SIunits.Angle gamma "Local orientation of coil";
  Real xic "Local skewing factor of coil";
algorithm
  // Check for odd number of phases
  assert(rem(winding.m,2)==1,"Number of phases must be odd");
  // Check maximum number of parallel branches
  assert(if winding.doubleLayer then winding.a<=2*winding.p else winding.a<=winding.p,"Number of parallel branch is too big");
  // Check of valid number of parallel connections
  if winding.doubleLayer then
    assert(rem(2*winding.p,winding.a)==0,"2*p/a is not an integer number");
  else
    assert(rem(winding.p,winding.a)==0,"p/a is not an integer number");
  end if;
  // Check valid integral slot winding
  assert(rem(winding.Sprime,2*winding.m)==0,"Not an integral slot winding");
  // Check if length of begin and end index vectors is equal
  assert(size(winding.ycb,1)==size(winding.yce,1),"Lengh of begin and end index vectors is not equal");
  // Assemble windings of all phases, 1 <= j <= m
  for j in 1:winding.m loop
    // Assemble windings for all phases
    for k in 1:size(winding.ycb,1) loop
      ycb[j,k] :=HanserModelica.Machines.Functions.mapSlotIndex(winding.ycb[k] + (j - 1)*yShift, winding.Sprime);
      yce[j,k] :=HanserModelica.Machines.Functions.mapSlotIndex(winding.yce[k] + (j - 1)*yShift, winding.Sprime);
    end for;
  end for;
  // Determine number of all windings sides of each slot
  for j in 1:winding.m loop
    for k in 1:size(winding.yce,1) loop
      index := HanserModelica.Machines.Functions.mapSlotIndex(ycb[j,k],Sg);
      coilSideCounter[index] := coilSideCounter[index] + 1;
      index := HanserModelica.Machines.Functions.mapSlotIndex(yce[j,k],Sg);
      coilSideCounter[index] := coilSideCounter[index] + 1;
    end for;
  end for;
  // Check if each slot contains the correct number of coil sides
  // to be fully symmetrical winding
  for j in 1:Sg loop
    if winding.doubleLayer then
      assert(coilSideCounter[j]==2,"Double layer winding is not fully symmetrical");
    else
      assert(coilSideCounter[j]==1,"Single layer winding is not fully symmetrical");
    end if;
  end for;
  // Calculate effective winding numbers
  for j in 1:winding.m loop
    N[j] := Complex(0, 0) "Initialization of number of turns";
    for k in 1:size(winding.ycb,1) loop
     dgamma := 2*pi*(yce[j,k] - ycb[j,k])/winding.Sprime;
     gamma := 2*pi*(yce[j,k] + ycb[j,k])/2/winding.Sprime + winding.offset;
     xic := sin(dgamma/2);
     // N[j] := N[k] + (p/a)*xic*nc*exp(j*gamma)
     if winding.doubleLayer then
       N[j] := N[j] + 2*winding.p/winding.a*xic*winding.nc*Modelica.ComplexMath.fromPolar(1,gamma);
     else
       N[j] := N[j] + winding.p/winding.a*xic*winding.nc*Modelica.ComplexMath.fromPolar(1,gamma);
     end if;
    end for;
  end for;
end complexTurns;
