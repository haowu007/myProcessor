/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB                  // I: Data from port B of regfile

);
    // Control signals
    input clock, reset;

    // Imem
    output reg [11:0] address_imem;
    input [31:0] q_imem;

    // Dmem
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;

	 /*******************************************************************/ 
    /***************** YOUR CODE STARTS HERE ***************************/
	 /*******************************************************************/ 
	 //********************************************************************************************************************************************************/
    wire[4:0] Opcode,Op_Alu,shamt, ctrl_readRegA, ctrl_readRegB,rd,rs,rt; // We name them as 'wire' so that they can be assigned outside of a 'always@' block
	 wire WriteBackMux_select,immediate_sign; //The select bits for MUX1 and MUX2 and MUX3 we use
    wire[31:0] alu_result,alu_inputB;
    wire[31:0] immediate_num;
	 wire[31:0] data_writeback_normal;
    wire[15:0] rstatus;
	 wire[4:0] ctrl_writeback_normal,AluOpcode;
	 wire[26:0] T;
	 wire[31:0] rstatus_data;

	 //**********************************************************************************************************************************************************
	 //Now we assign values which can be known as soon as we have the Instruction bits fetched
    assign  Opcode[4:0] = q_imem[31:27];
    assign  Op_Alu[4:0] = q_imem[6:2]; // select between this and MUX 3!!!
    assign  shamt[4:0] = q_imem[11:7];
    assign  rs[4:0] = q_imem[21:17]; 
    assign  rt[4:0] = q_imem[16:12];//Although these bits are meaningless for I-type
    assign  rd[4:0]=q_imem[26:22];
    assign  rstatus=16'b0000000000011110  ;  //$30=$rstatus
    assign  T = q_imem[26:0]; //only meaningful for JI type instructions
    wire [31:0] entended_T;
    assign entended_T[26:0] = T[26:0];
    assign entended_T[31:27] = 0;//T is a unsigned number
  
  /////////deal with "N" or "I" in I type instructions/////////////////////
    assign immediate_num[16:0]=q_imem[16:0];//we need to signed-extend this,although these 17 bits are meaningless for R-type instructions
    assign immediate_sign=immediate_num[16];
    assign immediate_num[31:17]=(immediate_sign == 1'b1)? 15'b111111111111111:15'b000000000000000; 
  //////////////////////////////////////////////////////////////////
  
  
    wire[11:0] pc_bne_and_blt; //"PC = PC+1+N" in bne and blt instructions
    wire[11:0] pc_add_1;
    wire select_jal,select_branch,select_j,select_jr,select_setx,select_bne_or_blt,branch_requirement,is_bex;

  
  
  

initial begin
address_imem<=12'b000000000000;
end
	 
always @ (posedge clock or posedge reset)begin

  if(reset)begin
    address_imem<=12'b000000000000;
  end

  else begin

    	address_imem = pc_mux3_result; ///final value!
  end //else block ends

end//always block ends

  
    assign  pc_bne_and_blt = address_imem + 1 +  immediate_num[11:0];// "PC = PC+1+N" in bne and blt instructions
    assign  pc_add_1 = address_imem+1; //imem is 32bit so we just need to do PC+1 every time we fetch the next instruction
  
  
  
  
  
  wire[31:0] extended_pc_add_1;
assign extended_pc_add_1[11:0] = pc_add_1[11:0];
assign extended_pc_add_1[31:12] = 0;

wire is_exception;




control ctrl(
        
        q_imem,
        Opcode,
		  Op_Alu,
		  data_readRegB,
		  immediate_num,
		  ctrl_writeEnable,
		  wren,
		  alu_inputB,
		  WriteBackMux_select,
        AluOpcode,
		  ctrl_writeback_normal,
		  ctrl_readRegA,
		  ctrl_readRegB,
		  rstatus_data,
		  select_jal,
		  select_branch,
		  select_j,
		  select_jr,
		  select_setx,
		  is_bex,
		  is_exception
		  );




   //Now we declare things related to ALU
   wire isNotEqual,isLessThan,overflow;
	

 
  alu a1(data_readRegA, alu_inputB, AluOpcode[4:0],
			shamt, alu_result, isNotEqual, isLessThan, overflow);
				

assign address_dmem[11:0] = alu_result[11:0]; //used in instruction "sw"
assign data[31:0] = data_readRegB[31:0];      //used in instruction "sw"





				

				
				
				
//MUXes for PC-related instructions
wire [11:0] pc_mux1_result,pc_mux2_result,pc_mux3_result;
wire bex_jump_or_not,mux2_select;

assign branch_requirement = (Opcode[4:0] == 5'b00010) ? isNotEqual : isLessThan; // bne or blt??
assign select_bne_or_blt = select_branch & branch_requirement;
assign bex_jump_or_not = is_bex & isNotEqual; //the instruction is BEX and $rstatus != 0
assign mux2_select = (bex_jump_or_not == 1'b1)? 1'b1 : select_j; //for other instructions just use select_j (select_j = 1 for j/jal, =0 for all other instructions)


two2one_mux_12bit PC_MUX_bne(pc_add_1,      pc_bne_and_blt,     select_bne_or_blt,pc_mux1_result); //This Mux selects between "PC+1" and "PC+1+N",when select = 1, PC = PC+1+N
two2one_mux_12bit PC_MUX_j(pc_mux1_result,T[11:0],            mux2_select,pc_mux2_result); //This Mux selects between "result of PC_MUX1" and "T",when select = 1, PC = T
two2one_mux_12bit PC_jr(pc_mux2_result,data_readRegB[11:0],select_jr,pc_mux3_result); //This Mux selects between "result of PC_MUX2" and "$rd",when select = 1, PC = $rd
///









//Muxes for write-back (which register? what data?)			
 wire [31:0] writeback1,writeback2,writeback3;
 
 two2one_mux_32bit WriteBackMux(alu_result, q_dmem, WriteBackMux_select,data_writeback_normal); //This Mux selects between 32-bit data given by D-memory or given by Alu-result

 wire excep;
 assign excep = is_exception & overflow;
 
 assign ctrl_writeReg[4:0] = (excep)?(5'b11110):(ctrl_writeback_normal);

 
 //OVERFLOW happened??
 assign writeback1[31:0] = (excep == 1'b1) ? rstatus_data[31:0] : data_writeback_normal[31:0];
 //setx??
 assign writeback2[31:0] = (select_setx == 1'b1) ? entended_T[31:0] : writeback1[31:0];
 //jal??
 assign writeback3[31:0] = (select_jal == 1'b1) ? extended_pc_add_1[31:0] : writeback2[31:0];//write "PC+1" to $31 if it's a jal instruction	
 assign data_writeReg[31:0] = (ctrl_writeReg[4:0] == 5'b00000) ? 32'd0 : writeback3[31:0];
// 
 
endmodule
 


	 
	 
	 
	 
	 
	 
	 
	 
	 

