module genmul4x4(input [3:0]a,b, output reg [7:0]o);
integer k=4; //change as per required k*k multiplication
reg [3:0]ands[3:0];
reg [3:0]sums[2:0];
reg [4:0]cars[2:0];//change register values as per requirement like k=4 in this case
integer i,j;

always @(*)
begin
for(i=0; i<k; i=i+1)//computing and operations and making input carries as 0
begin
cars[i][0]=0;
for(j=0; j<k; j=j+1)
begin 
ands[i][j]=a[i]&b[j];
end
end

for(i=0; i<k; i=i+1)//1st stage multiplication using adders
begin
sums[0][i]=(ands[0][i+1])^(ands[1][i])^(cars[0][i]);
sums[0][k-1]=(ands[1][k-1])^(cars[0][k-1]);
cars[0][i+1]=(ands[0][i+1]&ands[1][i])|(ands[1][i]&cars[0][i])|(cars[0][i]&ands[0][i+1]);
cars[0][k]=(ands[1][k-1])&(cars[0][k-1]);
end

for(j=1; j<k-1; j=j+1)//further stages
begin
for(i=0; i<k; i=i+1)
begin
sums[j][i]=(sums[j-1][i+1])^(ands[j+1][i])^(cars[j][i]);
sums[j][k-1]=(ands[j+1][k-1])^(cars[j][k-1])^(cars[j-1][k]);
cars[j][i+1]=(sums[j-1][i+1]&ands[j+1][i])|(ands[j+1][i]&cars[j][i])|(cars[j][i]&sums[j-1][i+1]);
cars[j][k]=(cars[j-1][k]&ands[j+1][i])|(ands[j+1][i]&cars[j][i])|(cars[j][i]&cars[j-1][k]);
end
end

o[7:0]={cars[2][4],sums[2][3:0],sums[1][0],sums[0][0],ands[0][0]};//adjust as per need
end
endmodule
