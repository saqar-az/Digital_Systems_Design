module FA(
    input  a, b, cin,
    output sum, cout
);
    assign {cout, sum} = a + b + cin;
endmodule

module mux2to1(
    input  a, b, sel,
    output y
);
    assign y = sel ? b : a;
endmodule

module CarrySkipAdder (
    input  [3:0] A, B,
    input  cin,
    output [3:0] sum,
    output cout
);
    wire [3:0] c;
    wire [3:0] p;
    wire P_sel;

    FA fa0 (.a(A[0]), .b(B[0]), .cin(cin),  .sum(sum[0]), .cout(c[0]));
    FA fa1 (.a(A[1]), .b(B[1]), .cin(c[0]), .sum(sum[1]), .cout(c[1]));
    FA fa2 (.a(A[2]), .b(B[2]), .cin(c[1]), .sum(sum[2]), .cout(c[2]));
    FA fa3 (.a(A[3]), .b(B[3]), .cin(c[2]), .sum(sum[3]), .cout(c[3]));

    assign p[0] = A[0] ^ B[0];
    assign p[1] = A[1] ^ B[1];
    assign p[2] = A[2] ^ B[2];
    assign p[3] = A[3] ^ B[3];

    assign P_sel = p[0] & p[1] & p[2] & p[3];

    mux2to1 mux_inst (.a(c[3]), .b(cin), .sel(P_sel), .y(cout));
endmodule

module CarrySkipAdder_tb;

    reg  [3:0] A, B;
    reg  cin;
    wire [3:0] sum;
    wire cout;

    CarrySkipAdder dut (.A(A), .B(B), .cin(cin), .sum(sum), .cout(cout));

    initial begin
        A=4'b0000; B=4'b0000; cin=0; #10;
        A=4'b0101; B=4'b0011; cin=0; #10;
        A=4'b1010; B=4'b0101; cin=1; #10;
        A=4'b1111; B=4'b1111; cin=1; #10;
        A=4'b1100; B=4'b0011; cin=1; #10;
        A=4'b1001; B=4'b0110; cin=0; #10;
        A=4'b1110; B=4'b0001; cin=1; #10;
        A=4'b0010; B=4'b1101; cin=0; #10;
        A=4'b0100; B=4'b1011; cin=1; #10;

        $finish;
    end

endmodule
