within HanserModelica.VariablesTypes;
model VectorsArrays2
  extends Modelica.Icons.Example;
  parameter Real A[2,2]={{1,2},{3,4}};
  parameter Real B[3,3]={{cos((i-j)*2*Modelica.Constants.pi/3)
                         for i in 0:2} for j in 0:2};
  parameter Real C[2,2]=zeros(2,2);  // ={{0,0};{0,0}}
  parameter Real D[:,:]=ones(2,2);   // ={{1,1};{1,1}}
  parameter Real E[2,2]=fill(4,2,2); // ={{4,4};{4,4}}
  parameter Real F[:,:]=diagonal({1,2}); // ={{1,0};{0,2}}
  parameter Real X=sum(D);           // =4
  parameter Real Y=A[1,1]*4+A[2,2];  // =8
end VectorsArrays2;
