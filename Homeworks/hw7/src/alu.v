module alu (
    input [7:0] a,
    input [7:0] b,
    input [3:0] control,
    output reg [7:0] result,
    output reg Z, N, V, C
);

reg carry;
reg [8:0] one;
initial begin
    one = 8'b00000001;
end
always @(*) begin
    case (control)
        4'b0000: begin 
            {carry, result} = a + b;
             C = carry;
             V = (result[7] ^ a[7]) & (result[7] ^ b[7]);
        end
        4'b0001: begin 
            {carry, result} = a - b;
            C = ~ carry;
            if(a == b)begin
             C = 0;   
            end
            if(a[7] != b[7]) begin
                if((result[7] == a[7]) || (result[7] == b[7]))begin
                    V =1;
                end
            end
            else begin
                V =0;
            end

        end
        4'b0010: begin 
            {carry, result} = a + one;
            C = carry;
            V = (result[7] ^ a[7]) & (result[7] ^ b[7]);
        end
        4'b0011: begin 
            {carry, result} = a - one;
             C = ~ carry;
             if(a == one)begin
             C = 0;   
             end
            if(a[7] != b[7]) begin
                if((result[7] == a[7]) || (result[7] == b[7]))begin
                    V =1;
                end
            end
            else begin
                V =0;
            end
        end
        4'b0100: begin
            {carry, result} = b + one;
            C = carry;
            V = (result[7] ^ a[7]) & (result[7] ^ b[7]);
        end
        4'b0101: begin 
            {carry, result} = b - one;
            C = ~ carry;
            if(b == one)begin
             C = 0;   
            end
            if(a[7] != b[7]) begin
                if((result[7] == a[7]) || (result[7] == b[7]))begin
                    V =1;
                end
            end
            else begin
                V =0;
            end
        end
        4'b0110: begin 
            result = a & b;
            C = 1'b0;
            V = 1'b0;
        end
        4'b0111: begin 
            result = a | b;
            C = 1'b0;
            V = 1'b0;
        end
        4'b1000: begin 
            result = ~(a & b);
            C = 1'b0;
            V = 1'b0;
        end
        4'b1001: begin 
            result = ~(a | b);
            C = 1'b0;
            V = 1'b0;
        end
        4'b1010: begin 
            result = a ^ b;
            C = 1'b0;
            V = 1'b0;
        end
        4'b1011: begin
            result = ~a;
            C = 1'b0;
            V = 1'b0;
        end
        default: begin 
            result = 8'b0;
            C = 1'b0;
            V = 1'b0;
        end
    endcase
    Z = (result == 8'b0);
    N = (result[7] == 1); 

end

endmodule


module tb;

reg [7:0] a;
reg [7:0] b;
reg [3:0] control;
wire [7:0] result;
wire Z, N, V, C;

alu t (
    .a(a),
    .b(b),
    .control(control),
    .result(result),
    .Z(Z),
    .N(N),
    .V(V),
    .C(C)
);

initial begin
    a = 8'b01110000;
    b = 8'b01011000;
    control = 4'b0000;
    #10;
    control = 4'b0001;
    #10;
    control = 4'b0010;
    #10;
    control = 4'b0011;
    #10;
    control = 4'b0100;
    #10;
    control = 4'b0101;
    #10;
    control = 4'b0110;
    #10;
    control = 4'b0111;
    #10;
    control = 4'b1000;
    #10;
    control = 4'b1001;
    #10;
    control = 4'b1010;
    #10;
    control = 4'b1011;
    #10;
end
endmodule
