module control(
               
               input[31:0] q_imem,
               input [4:0]Opcode,
					input [4:0]Op_Alu,
					input [31:0]data_readRegB,
					input [31:0]immediate_num,
					output reg ctrl_writeEnable,
					output reg wren,
					output reg[31:0] alu_inputB,
               output reg WriteBackMux_select,
					output reg [4:0] AluOpcode,
					output reg[4:0] ctrl_writeReg,
					output reg[4:0] ctrl_readRegA,
					output reg[4:0] ctrl_readRegB,
				   output reg[31:0] rstatus_data,
					output reg select_jal,
		         output reg select_branch,
		         output reg select_j,
		         output reg select_jr,
		         output reg select_setx,
		         output reg is_bex,
					output reg is_exception
				);







always @(Opcode or Op_Alu) begin  //????

case(Opcode)
 
 5'b00000:begin
  case(Op_Alu) 
    5'b00000: begin//ADD
	 
	 ctrl_writeEnable=1;
	 wren = 0; //no need to use data memory
	 WriteBackMux_select=0; //use alu_output as write back data
    AluOpcode=q_imem[6:2];		
	 ctrl_writeReg=q_imem[26:22]; //$rd
    ctrl_readRegA=q_imem[21:17]; //$rs
    ctrl_readRegB=q_imem[16:12]; //Although $rt would be meaningless if it's a I-type instruction 
	 rstatus_data=32'd1;
	 alu_inputB=data_readRegB;
	 //PC related control bits
	 select_jal = 0;
	 select_branch = 0;
	 select_j = 0;
	 select_jr= 0;
	 select_setx = 0;
	 is_bex = 0;
	 is_exception=1;

   end
	
	5'b00001:begin//SUB
	 
	 ctrl_writeEnable=1;
	 wren = 0; //no need to use data memory
	 WriteBackMux_select=0;
    AluOpcode=q_imem[6:2];		
	 ctrl_writeReg=q_imem[26:22]; //$rd
    ctrl_readRegA=q_imem[21:17]; //$rs
    ctrl_readRegB=q_imem[16:12]; //Although $rt would be meaningless if it's a I-type instruction 
	 rstatus_data=32'd3;	 
	 alu_inputB=data_readRegB;
	 select_jal = 0;
	 select_branch = 0;
	 select_j = 0;
	 select_jr= 0;
	 select_setx = 0;
	 is_bex = 0;
	 is_exception=1;
   end
	
	
	5'b00010:begin//&
	
	 ctrl_writeEnable=1;
	 wren = 0; //no need to use data memory
	 WriteBackMux_select=0;
    AluOpcode=q_imem[6:2];		
	 ctrl_writeReg=q_imem[26:22]; //$rd
    ctrl_readRegA=q_imem[21:17]; //$rs
    ctrl_readRegB=q_imem[16:12]; //Although $rt would be meaningless if it's a I-type instruction 
	 rstatus_data=1'd0;
	 alu_inputB=data_readRegB;
	 //PC related control bits
	 select_jal = 0;
	 select_branch = 0;
	 select_j = 0;
	 select_jr= 0;
	 select_setx = 0;
	 is_bex = 0;	
	 is_exception=0;
	end
	
	
	5'b00011:begin//Instruction: A|B (A or B)
	
	 ctrl_writeEnable=1;
	 wren = 0; //no need to use data memory
	 WriteBackMux_select=0;
    AluOpcode=q_imem[6:2];		
	 ctrl_writeReg=q_imem[26:22]; //$rd
    ctrl_readRegA=q_imem[21:17]; //$rs
    ctrl_readRegB=q_imem[16:12]; //Although $rt would be meaningless if it's a I-type instruction 
	 rstatus_data=1'd0;
    alu_inputB=data_readRegB;
	 //PC related control bits
	 select_jal = 0;
	 select_branch = 0;
	 select_j = 0;
	 select_jr= 0;
	 select_setx = 0;
	 is_bex = 0; 
	 is_exception=0;
	end
	
	5'b 00100:begin//$rd=$rs<<shamt

	 ctrl_writeEnable=1;
	 wren = 0; //no need to use data memory
	 WriteBackMux_select=0;
    AluOpcode=q_imem[6:2];		
	 ctrl_writeReg=q_imem[26:22]; //$rd
    ctrl_readRegA=q_imem[21:17]; //$rs
    ctrl_readRegB=q_imem[16:12]; //Although $rt would be meaningless if it's a I-type instruction 
	 rstatus_data=1'd0;
	 alu_inputB=data_readRegB;
	 //PC related control bits
	 select_jal = 0;
	 select_branch = 0;
	 select_j = 0;
	 select_jr= 0;
	 select_setx = 0;
	 is_bex = 0;
	is_exception=0; 
	end
	
	5'b 00101:begin//$rd=$rs>>>shamt

    ctrl_writeEnable=1;
	 wren = 0; //no need to use data memory
	 WriteBackMux_select=0;
    AluOpcode=q_imem[6:2];		
	  ctrl_writeReg=q_imem[26:22]; //$rd
     ctrl_readRegA=q_imem[21:17]; //$rs
     ctrl_readRegB=q_imem[16:12]; //Although $rt would be meaningless if it's a I-type instruction 
	  rstatus_data=1'd0;
     alu_inputB=data_readRegB;
	 //PC related control bits
	 select_jal = 0;
	 select_branch = 0;
	 select_j = 0;
	 select_jr= 0;
	 select_setx = 0;
	 is_bex = 0;
	 is_exception=0;
	end
	
	endcase
	end
	
	
	
	5'b00101:begin//addi
	
	 ctrl_writeEnable=1;
	 wren = 0; //no need to use data memory
	 WriteBackMux_select<=0;
    AluOpcode=5'b00000;	
	 ctrl_writeReg=q_imem[26:22]; //$rd
    ctrl_readRegA=q_imem[21:17];//$rs
	 rstatus_data=32'd2;
	 alu_inputB=immediate_num;
	 //PC related control bits
	 select_jal = 0;
	 select_branch = 0;
	 select_j = 0;
	 select_jr= 0;
	 select_setx = 0;
	 is_bex = 0;
	 is_exception=1;
	end
	
	5'b00111:begin//sw:MEM[$rs+N]=$rd
	 ctrl_writeEnable=0;
	 wren = 1; // need to use data memory
	 WriteBackMux_select=0; //although 0 or 1 doesn't matter because we disabled write-to-regi-file
    AluOpcode=5'b00000;	
	 ctrl_writeReg=q_imem[26:22]; //$rd but doesn't matter because we disabled write-to-regi-file
    ctrl_readRegA=q_imem[21:17]; //$rs
    ctrl_readRegB=q_imem[26:22]; //$rd
	 rstatus_data=1'd0;
	 alu_inputB=immediate_num;
	 //PC related control bits
	 select_jal = 0;
	 select_branch = 0;
	 select_j = 0;
	 select_jr= 0;
	 select_setx = 0;
	 is_bex = 0;
	 is_exception=0;
	
	end
	
	5'b01000:begin//lw:$rd=MEM[$rs+N]
	
	 ctrl_writeEnable=1;
	 wren = 0; //no need to write to data memory
	 WriteBackMux_select=1; //data flows from d-mem to reg-file
    AluOpcode=5'b00000;	
    ctrl_readRegA=q_imem[21:17]; //$rs
    ctrl_writeReg=q_imem[26:22]; //$rd
	 rstatus_data=1'd0;
    alu_inputB=immediate_num;
	 //PC related control bits
	 select_jal = 0;
	 select_branch = 0;
	 select_j = 0;
	 select_jr= 0;
	 select_setx = 0;
	 is_bex = 0;
    is_exception=0;	 
	end
	
	5'b00001:begin//j T:PC = T 
	
	 ctrl_writeEnable=0;
	 wren = 0; //no need to use data memory
	 WriteBackMux_select=0; //although 0 or 1 doesn't matter because we disabled write-to-regi-file
    AluOpcode=q_imem[6:2];
    ctrl_readRegA=q_imem[21:17]; //$rs
    ctrl_readRegB=q_imem[26:22]; //$rd
	 rstatus_data=1'd0;
	 alu_inputB=immediate_num;
	 //PC related control bits
	 select_jal = 0;
	 select_branch = 0;
	 select_j = 1;
	 select_jr= 0;
	 select_setx = 0;
	 is_bex = 0	 ;
	 is_exception=0;
	end

	5'b00010:begin//bne $rd, $rs, N 
	 ctrl_writeEnable=0;
	 wren = 0; //no need to use data memory
	 WriteBackMux_select=0; //although 0 or 1 doesn't matter because we disabled write-to-regi-file
    AluOpcode=5'b00001; //Alu_result = $rs - $rd
    ctrl_readRegA=q_imem[21:17]; //$rs
    ctrl_readRegB=q_imem[26:22]; //$rd
	 rstatus_data=1'd0;
	 alu_inputB=data_readRegB;
	 //PC related control bits
	 select_jal = 0;
	 select_branch = 1;
	 select_j = 0;
	 select_jr= 0;
	 select_setx = 0;
	 is_bex = 0;
	 is_exception=0;
	end
	
	5'b00011:begin//jal T: $r31 = PC + 1; PC = T  
	
	 ctrl_writeEnable=1;
	 wren = 0; //no need to use data memory
	 WriteBackMux_select=0; // write-to-regi-file
    AluOpcode=5'b00000; //doesn't matter
	 ctrl_writeReg=5'b11111; //need to write to $31
    ctrl_readRegA=q_imem[21:17]; //$rs
    ctrl_readRegB=q_imem[26:22]; //$rd
	 rstatus_data=1'd0;
	 alu_inputB=data_readRegB;
	 //PC related control bits
	 select_jal = 1;
	 select_branch = 0;
	 select_j = 1;
	 select_jr= 0;
	 select_setx = 0;
	 is_bex = 0	 ;
	 is_exception=0;
	end
	
	5'b00100:begin//jr $rd: PC = $rd 
	
	 ctrl_writeEnable=0;
	 wren = 0; //no need to use data memory
	 WriteBackMux_select=1; //although 0 or 1 doesn't matter because we disabled write-to-regi-file
    AluOpcode=5'b00000; //doesn't matter
    ctrl_readRegA=q_imem[21:17]; //$rs
    ctrl_readRegB=q_imem[26:22]; //$rd
	 rstatus_data=1'd0;
	 alu_inputB=data_readRegB; //doesn't matter
	 //PC related control bits
	 select_jal = 0;
	 select_branch = 0;
	 select_j = 0;
	 select_jr= 1;
	 select_setx = 0;
	 is_bex = 0	 ;
	 is_exception=0;
	end
	
	5'b00110:begin//blt $rd, $rs, N : if ($rs - $rd >0), PC = PC +1 +N 
	
	 ctrl_writeEnable=0;
	 wren = 0; //no need to use data memory
	 WriteBackMux_select=1; //although 0 or 1 doesn't matter because we disabled write-to-regi-file
    AluOpcode=5'b00001; //do $rs - $rd
    ctrl_readRegA=q_imem[26:22]; //$rd
    ctrl_readRegB=q_imem[21:17]; //$rs
	 rstatus_data=1'd0;
	 alu_inputB=data_readRegB;
	 //PC related control bits
	 select_jal = 0;
	 select_branch = 1;
	 select_j = 0;
	 select_jr= 0;
	 select_setx = 0;
	 is_bex = 0	 ;
	 is_exception=0;
	end

	
	5'b10110:begin//bex T : if($rstatus !=0 ), PC = T 
	
	 ctrl_writeEnable=0;
	 wren = 0; //no need to use data memory
	 WriteBackMux_select=1; //although 0 or 1 doesn't matter because we disabled write-to-regi-file
    AluOpcode=5'b00001; //do $rstatus - $r0
    ctrl_readRegA=5'b11110; //$r30
    ctrl_readRegB=5'b00000; //$r0
	 rstatus_data=1'd0;
	 alu_inputB=data_readRegB;
	 //PC related control bits
	 select_jal = 0;
	 select_branch = 0;//not blt or bne
	 select_j = 0;
	 select_jr= 0;
	 select_setx = 0;
	 is_bex = 1	 ;
	 is_exception=0;
	end
		
	5'b10101:begin//setx T: $rstatus = T
	
	 ctrl_writeEnable=1;
	 wren = 0; //no need to use data memory
	 WriteBackMux_select=1; // doesn't matter 
    AluOpcode=5'b00000; //doesn't matter
	 ctrl_writeReg=5'b11110; //need to write to $30
    ctrl_readRegA=q_imem[21:17]; //$rs,doesn't matter
    ctrl_readRegB=q_imem[26:22]; //$rd,doesn't matter
	 rstatus_data=1'd0;
	 alu_inputB=data_readRegB;
	 //PC related control bits
	 select_jal = 0;
	 select_branch = 0;//not blt or bne
	 select_j = 0;
	 select_jr= 0;
	 select_setx = 1;
	 is_bex = 0	 ;
	 is_exception=0;
	end
	
	
  endcase
  

  
  
 end


endmodule
