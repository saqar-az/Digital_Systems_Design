module fs(
    input A,B,Bin,
    output D,Bout
);
    assign D = A ^ B ^ Bin;
    assign Bout = (~A & B) | (~(A ^ B) & Bin);
endmodule

module mux2to1(
    input a,b,sel,
    output y
);
    assign y = sel ? b : a;
endmodule

module box(
    input x,y,cin,cntrl,
    output cout,out
);
    wire w1;

    fs FS(
        .A(x),
        .B(y),
        .Bin(cin),
        .D(w1),
        .Bout(cout)
    );

    mux2to1 MUX(
        .a(x),    
        .b(w1),   
        .sel(cntrl),
        .y(out)
    );
endmodule

module divider(
    input [5:0] z,        
    input [2:0] d,        
    output [2:0] q,        
    output [5:0] s         
);
    wire cout [0:8];
    wire out  [0:8];    

    box b0 (.x(z[3]), .y(d[2]), .cin(1'b0), .cntrl(q[0]), .cout(cout[0]), .out(out[0]));
    box b1 (.x(z[2]), .y(d[1]), .cin(cout[0]), .cntrl(q[0]), .cout(cout[1]), .out(out[1]));
    box b2 (.x(z[1]), .y(d[0]), .cin(cout[1]), .cntrl(q[0]), .cout(cout[2]), .out(out[2]));
    assign q[0] = z[0] | ~cout[2];

    box b3 (.x(z[4]), .y(d[2]), .cin(1'b0), .cntrl(q[1]), .cout(cout[3]), .out(out[3]));
    box b4 (.x(out[0]), .y(d[1]), .cin(cout[3]), .cntrl(q[1]), .cout(cout[4]), .out(out[4]));
    box b5 (.x(out[1]), .y(d[0]), .cin(cout[4]), .cntrl(q[1]), .cout(cout[5]), .out(out[5]));
    assign q[1] = out[2] | ~cout[5];

    box b6 (.x(z[5]), .y(d[2]), .cin(1'b0), .cntrl(q[2]), .cout(cout[6]), .out(out[6]));
    box b7 (.x(out[3]), .y(d[1]), .cin(cout[6]), .cntrl(q[2]), .cout(cout[7]), .out(out[7]));
    box b8 (.x(out[4]), .y(d[0]), .cin(cout[7]), .cntrl(q[2]), .cout(cout[8]), .out(out[8]));
    assign q[2] = out[5] | ~cout[8];

    assign s = {3'b000, out[8], out[7], out[6]};

endmodule

module divider_tb;
    reg [5:0] z;
    reg [2:0] d;
    wire [2:0] q;
    wire [5:0] s;

    divider dd (
        .z(z),
        .d(d),
        .q(q),
        .s(s)
    );

    initial begin
        z = 6'b111111; d = 3'b111; #10;
        z = 6'b101010; d = 3'b011; #10;
        z = 6'b011001; d = 3'b101; #10;
        z = 6'b100100; d = 3'b010; #10;
        z = 6'b000111; d = 3'b001; #10;
        $finish;
    end
endmodule
